//
//  NIPError.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "NIPError.h"

@implementation NIPError

+(void)submitErrorWithMessage:(NSException*)exception
{
	NSString* title = @"An Error Has Occured";
	NSString* message = @"Would you like to email the error information to the developer to assist with providing a fix?";
	
	UIAlertView* hbfer = [[UIAlertView alloc] initWithTitle:title
													message:message
												   delegate:nil
										  cancelButtonTitle:nil
										  otherButtonTitles:nil];

	[hbfer addButtonWithTitle:@"Yes"];
	[hbfer addButtonWithTitle:@"No"];
	[hbfer show];
}

@end
