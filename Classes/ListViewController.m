//
//  ListViewController.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "ListViewController.h"

@implementation ListViewController

@synthesize nibLoadedCell;

-(void)viewDidLoad
{
	[super viewDidLoad];

	//[self.view addSubview:loadingViewController.view];
	//[self.parentViewController.view addSubview:loadingViewController.view];
	
	numberOfHeightsConfigured = 0;
	
	NSLog(@"loading list view");
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
		
	NSLog(@"list view will appear");
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	NSLog(@"list view did appear");
}

- (void)viewWillDisappear:(BOOL)animated
{
	NSLog(@"list view will dissapear");

    [[DataManager sharedManager] persistData];
}

- (void)viewDidDisappear:(BOOL)animated
{
	NSLog(@"list view did dissapear");
}

- (void)viewDidUnload
{
	NSLog(@"unloading list view");
}

#pragma mark -
#pragma mark table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // NOTE: do I even need this function ?
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = [DataManager numberOfFacts];
    
    NSLog(@"there are %d", rows);
    
    return rows;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
	// check if loading screen is still showing
	ThatGuyFactsAppDelegate *app = (ThatGuyFactsAppDelegate*)[UIApplication sharedApplication].delegate;
	if (app.loadingScreenShowing == YES)
	{
		app.loadingScreenShowing = NO;
		[app.loadingViewController.view removeFromSuperview];
	}
	
    TableCell* cell = (TableCell*)[tableView dequeueReusableCellWithIdentifier:@"ChuckNorrisFactTableCell"];
    
    if (cell == nil)
    {
		[[NSBundle mainBundle] loadNibNamed:@"TableCell"
									  owner:self
									options:NULL];
     
        if (nibLoadedCell == nil)
            @throw [NSException exceptionWithName:@"TableCellError" reason:@"unable to get empty table cell from nib or cache" userInfo:nil];

		cell = (TableCell*)nibLoadedCell;
    }
    
    Fact *fact = [DataManager getFactWithId:indexPath.row];
    
    cell.fact = fact;

	return cell;
}

- (NSIndexPath*)tableView:(UITableView*)tableView willSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    return nil;
}

-(void)updateProgressView
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
	ThatGuyFactsAppDelegate *app = (ThatGuyFactsAppDelegate*)[UIApplication sharedApplication].delegate;
	if (app.loadingScreenShowing == YES)
		[app.loadingViewController setProgressValue:numberOfHeightsConfigured++];
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);

    Fact *fact = [DataManager getFactWithId:indexPath.row];

    if (fact == nil)
        @throw [NSException exceptionWithName:@"NullFact" reason:@"fact is null" userInfo:nil];
 
	// update progress view
	[self performSelectorInBackground:@selector(updateProgressView) withObject:nil];
	//ChuckNorrisFactsAppDelegate *app = (ChuckNorrisFactsAppDelegate*)[UIApplication sharedApplication].delegate;
	//[self performSelector:@selector(updateProgressView) onThread:[app loadingScreenThread] withObject:nil waitUntilDone:NO];
	
	return [TableCell cellHeightForFact:fact];
    
    //return 10.0f;
}

- (void)dealloc
{
    [super dealloc];
}

@end
