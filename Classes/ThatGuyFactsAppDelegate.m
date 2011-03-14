//
//  ChuckNorrisFactsAppDelegate.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "ThatGuyFactsAppDelegate.h"

@implementation ThatGuyFactsAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize loadingViewController;
@synthesize loadingScreenShowing;
//@synthesize loadingScreenThread;

#pragma mark -
#pragma mark Application

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
	// add main view
	[window addSubview:tabBarController.view];

	tabBarController.delegate = self;
	
	//loadingScreenThread = [[NSThread alloc] init];
	//[loadingScreenThread start];
	
	// clear all badge values
	for (UITableViewController *controller in tabBarController.viewControllers)
		controller.tabBarItem.badgeValue = 0;
	
    [window makeKeyAndVisible];
	
	[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"firstLaunch",nil]];
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],@"displyRandomHelp",nil]];
	
	// create data on first launch

	bool isFirstLaunch = [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
	
	NSLog(@"first launch: %@", (isFirstLaunch ? @"yes" : @"no"));
	
	if (isFirstLaunch == YES)
	{
		// create facts in database
		//[[DataManager sharedManager] createFactsInContext];
        //[[DataManager sharedManager] persistData];
		
		NSError* error;
		
		NSString* applicationPath = [[NSBundle mainBundle] resourcePath];
		NSString* sourcePath = [applicationPath stringByAppendingPathComponent: @"ChuckNorrisFacts.sqlite"];
		
		NSString* applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]; // autorelease
		NSString* destinationPath = [applicationDocumentsDirectory stringByAppendingPathComponent: @"ChuckNorrisFacts.sqlite"];
		
		// copy database to documents directory
		[[NSFileManager defaultManager] copyItemAtPath:sourcePath 
												toPath:destinationPath
												 error:&error];
		
        //DLogFunction(@"%@", [error localizedDescription]);
		
        // only done here because applicationWillTerminate does not seem to be working
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] synchronize];
	}

	listAlreadyLoaded = NO;
	
	return YES;
}

- (void)applicationWillTerminate:(UIApplication*)application
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
    //NSLog(@"application is terminating, setting \"firstLaunch\" to false");
    
	// NOTE: This will not run if the application crashed.
	//[[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    
    // persist changes?
}

- (void)applicationDidEnterBackground:(UIApplication*)application
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
    
    // persist just for good measure?
    [[DataManager sharedManager] persistData];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication*)application
{
    NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
}

#pragma mark -

-(void)showLoadingScreen
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);

	int erer = [DataManager numberOfFacts];
	
	float knerkb = (float)erer;
	
	[loadingViewController setMaximumProgressValue:knerkb];
	[window addSubview:loadingViewController.view];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
	// only for list view
	if (viewController.view.tag == 22 && listAlreadyLoaded == NO)
	{
		NSLog(@"%s", __FUNCTION__);
	
		listAlreadyLoaded = YES;
		
		// show loading screen
		loadingScreenShowing = YES;
		[self performSelectorInBackground:@selector(showLoadingScreen) withObject:nil];
		//[self performSelector:@selector(showLoadingScreen) onThread:loadingScreenThread withObject:nil waitUntilDone:NO];
		//[self performSelectorOnMainThread:@selector(showLoadingScreen) withObject:nil waitUntilDone:NO];
	}
}

#pragma mark -

- (void)dealloc
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end
