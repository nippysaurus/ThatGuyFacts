//
//  RandomViewController.h
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#import "ThatGuyFactsAppDelegate.h"

@interface RandomViewController : UIViewController <AVAudioPlayerDelegate>
{

	// label which displays the number of characters comprising of the currently displaying fact
	IBOutlet UILabel *characterCountLabel;
	
	IBOutlet UIButton *makeTextSmall;
	IBOutlet UIButton *makeTextMedium;
	IBOutlet UIButton *makeTextLarge;
	
    // ui elements
	IBOutlet UILabel *label;

    // wehther to display the help bubble
	bool displyRandomHelp;
    
    // currently displayed random fact
    Fact *fact;
    
    // audio playback
    AVAudioPlayer *audioPlayer;

}

-(IBAction)randomize:(id)sender;

-(IBAction)makeTextSmall;
-(IBAction)makeTextMedium;
-(IBAction)makeTextLarge;

@end
