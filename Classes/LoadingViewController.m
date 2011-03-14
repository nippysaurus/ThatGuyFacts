//
//  LoadingViewController.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "LoadingViewController.h"

@implementation LoadingViewController

@synthesize myActivityIndicator;
@synthesize progressView;

-(void)setProgressValue:(float)value
{
	NSLog(@"%s", __FUNCTION__);

	// determine percent (actually its 1.0/percent)
	float percent = (1.0f / maximumValue) * value;
	
	// only set value if new value is bigger than old value
	if (percent > [progressView progress])
		[progressView setProgress:percent];
}

-(void)setMaximumProgressValue:(float)value
{
	NSLog(@"%s", __FUNCTION__);
	
	maximumValue = value;
}

- (void)viewDidLoad
{
	[myActivityIndicator startAnimating];
}

- (void)viewWillDisappear: (BOOL)animated
{
	[myActivityIndicator stopAnimating];
}

@end
