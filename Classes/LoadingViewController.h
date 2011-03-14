//
//  LoadingViewController.h
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingViewController : UIViewController {

	UIActivityIndicatorView* myActivityIndicator;
	UIProgressView* progressView;
	
	//float actualValue;
	float maximumValue;
	
}

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *myActivityIndicator;
@property (nonatomic, retain) IBOutlet UIProgressView *progressView;

-(void)setProgressValue:(float)value;
-(void)setMaximumProgressValue:(float)value;

@end
