//
//  ListViewController.h
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ThatGuyFactsAppDelegate.h"
#import "Fact.h"
#import "TableCell.h"
#import "LoadingViewController.h"

@interface ListViewController : UITableViewController
{

	UITableViewCell *nibLoadedCell;
	
	int numberOfHeightsConfigured;
    
}

@property (nonatomic, retain) IBOutlet UITableViewCell *nibLoadedCell;

@end
