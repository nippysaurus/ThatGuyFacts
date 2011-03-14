//
//  ChuckNorrisFactsAppDelegate.h
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <iAd/iAD.h>

#import "DataManager.h"
#import "Fact.h"
#import "LoadingViewController.h"

@interface ThatGuyFactsAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>
{
	
    UIWindow *window;
    UITabBarController *tabBarController;
    LoadingViewController* loadingViewController;
	
	bool loadingScreenShowing;
	
	bool listAlreadyLoaded;
	
	//NSThread* loadingScreenThread;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet LoadingViewController* loadingViewController;
@property (nonatomic) bool loadingScreenShowing;
//@property (nonatomic, retain) IBOutlet NSThread* loadingScreenThread;

@end
