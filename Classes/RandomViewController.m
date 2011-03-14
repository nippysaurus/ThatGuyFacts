//
//  RandomViewController.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "RandomViewController.h"

@implementation RandomViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{	
    [super viewDidLoad];
    
	NSLog(@"loading random view");
	
	// seed the random number generator
	srandom( time( NULL ) );
    
    //Setup our Audio Session
    //OSStatus status = AudioSessionInitialize(NULL, NULL, NULL, NULL);    
    //We want our audio to play if the screen is locked or the mute switch is on
    //UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    //status = AudioSessionSetProperty (kAudioSessionProperty_AudioCategory, sizeof (sessionCategory), &sessionCategory);
    //We want our audio to mix with other app's audio
    //UInt32 shouldMix = true;
    //status = AudioSessionSetProperty (kAudioSessionProperty_OverrideCategoryMixWithOthers, sizeof (shouldMix), &shouldMix);
    //Enable "ducking" of the iPod volume level while our sounds are playing
    //UInt32 shouldDuck = true;
    //AudioSessionSetProperty(kAudioSessionProperty_OtherMixableAudioShouldDuck, sizeof(shouldDuck), &shouldDuck);
    //Activate our audio session
    //AudioSessionSetActive(YES);
    
    //Setup the Music Player to access the iPod music library
    //musicPlayerController = [MPMusicPlayerController applicationMusicPlayer];
    //[musicPlayerController setShuffleMode: MPMusicShuffleModeSongs];
    //[musicPlayerController setRepeatMode: MPMusicRepeatModeNone];
    //[musicPlayerController setQueueWithQuery:[MPMediaQuery songsQuery]];
    
    //Setup a AVAudioPlayer sound to overlay against the Music Player audio
    //NSString *soundUrlPath = [[NSBundle mainBundle] pathForResource:@"punch1" ofType:@"wav"]; // autorelease
    //NSURL *soundUrl = [NSURL URLWithString:soundUrlPath]; // autorelease
    
    //NSError *error = nil;

    //NSURL* ergweg = [NSURL fileURLWithPath:@"/var/mobile/Applications/EC4E028E-1373-4CF3-8C0B-1FE725F3F247/ChuckNorrisFacts.app/punch1.wav"];
    //NSURL* hhe5h = [NSURL fileURLWithPath:@"file:/var/mobile/Applications/EC4E028E-1373-4CF3-8C0B-1FE725F3F247/ChuckNorrisFacts.app/punch1.wav"];
    //NSURL* sdcegre = [NSURL fileURLWithPath:@"file://var/mobile/Applications/EC4E028E-1373-4CF3-8C0B-1FE725F3F247/ChuckNorrisFacts.app/punch1.wav"];
    //NSURL* uikthdr = [NSURL fileURLWithPath:@"file:///var/mobile/Applications/EC4E028E-1373-4CF3-8C0B-1FE725F3F247/ChuckNorrisFacts.app/punch1.wav"];
    
    //BOOL erbergb = [ergweg checkResourceIsReachableAndReturnError:&error];
    //BOOL trnkner = [hhe5h checkResourceIsReachableAndReturnError:&error];
    //BOOL kbfefhb = [sdcegre checkResourceIsReachableAndReturnError:&error];
    //BOOL kndsnbf = [uikthdr checkResourceIsReachableAndReturnError:&error];

    //[NSURL fileURLWithPath:@""]

    //if (erbergb || trnkner || kbfefhb || kndsnbf)
    //{
    //    NSLog(@"eargfaewrv");
    //}
    
    //BOOL soundFileIsReachable = [soundUrl checkResourceIsReachableAndReturnError:&error];
    
    //if (soundFileIsReachable == NO)
    //    NSLog(@"audio file not reachable: %@", [error localizedDescription]);
    
    //audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error: &error];
    
    //if (!audioPlayer)
    //    NSLog(@"Could not create audio effect player: %@", [error localizedDescription]);
    
    //[audioPlayer prepareToPlay];
	
	
	#if DEBUG
	[characterCountLabel setHidden:NO];
	[makeTextSmall setHidden:NO];
	[makeTextMedium setHidden:NO];
	[makeTextLarge setHidden:NO];
	#else
	[characterCountLabel setHidden:YES];
	[makeTextSmall setHidden:YES];
	[makeTextMedium setHidden:YES];
	[makeTextLarge setHidden:YES];    
	#endif
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
	NSLog(@"unloading random view");
	
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	NSLog(@"random view will appear");
	
	// TODO load data
	
	// application delegate
	//ChuckNorrisFactsAppDelegate *app = (ChuckNorrisFactsAppDelegate*)[UIApplication sharedApplication].delegate;
	
	// local copy of data
	//data = app.data;
    //data = nil;
	
	// initial random fact
	[self randomize:self];
    
    // take care of the helper hint bubble thing
    
	#if DEBUG
    displyRandomHelp = YES;
	#else
    displyRandomHelp = [[NSUserDefaults standardUserDefaults] boolForKey:@"displyRandomHelp"];
	#endif
	
	NSLog(@"display random help: %@", (displyRandomHelp ? @"yes" : @"no"));
    
    [[self.view viewWithTag:1] setHidden:!displyRandomHelp];
}

- (void)viewDidAppear:(BOOL)animated
{
	NSLog(@"random view did appear");
	
    // make item zero not a favorite, just for testing ...
    //[DataManager getFactWithId:0].IsFavorite = NO;
    [[DataManager sharedManager] persistData];
    
	//
}

- (void)viewWillDisappear:(BOOL)animated
{
	NSLog(@"random view will dissapear");
	
	//
}

- (void)viewDidDisappear:(BOOL)animated
{
	NSLog(@"random view did dissapear");
	
	//
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"view was touched");
    
    if (displyRandomHelp == YES)
    {
        NSLog(@"hiding random help and disabling for future");
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"displyRandomHelp"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // hide the helper view
		UIView *image = [self.view viewWithTag:1];
		
		// begin animation
		[UIView beginAnimations:nil context:NULL]; // animate the following:
		
		// move to new location
		CGRect o = [image frame];
		CGRect n = CGRectMake(o.origin.x, o.origin.y - 30, o.size.width, o.size.height);
		[image setFrame:n];
		
		// make invisible
		//[image setHidden:YES];
		[image setAlpha:0.0f];
		
		// commit animation
		[UIView setAnimationDuration:0.5];
		[UIView commitAnimations];
    }
    
    [self randomize:self];
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Randomization

-(IBAction)randomize:(id)sender
{
	//random();
	//NSInteger erfer = [DataManager numberOfFacts];
	
    int generated = (random() % [DataManager numberOfFacts]);
	
	NSLog(@"generated number: %d", generated);

    fact = [DataManager getFactWithId:generated];
	
	[label setText:fact.Text];

	// TODO set text size
	
	NSUInteger factLength = [fact.Text length];

	NSString *factLengthString = [NSString stringWithFormat: @"%d", factLength];
	
	[characterCountLabel setText:factLengthString];
	
	if (factLength < 100)
		[self makeTextLarge];

	if (factLength > 100 && factLength < 250)
		[self makeTextMedium];
	
	if (factLength > 250)
		[self makeTextSmall];
	
	//[audioPlayer play];
}

#pragma mark -
#pragma mark Some Dev Stuff

-(IBAction)makeTextSmall
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
	[label setFont:[UIFont fontWithName:@"Arial" size:17.0f]];
}

-(IBAction)makeTextMedium
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
	[label setFont:[UIFont fontWithName:@"Arial" size:20.0f]];
}

-(IBAction)makeTextLarge
{
	NSLog(@"%@ %s", [NSThread currentThread], __FUNCTION__);
	
	[label setFont:[UIFont fontWithName:@"Arial" size:25.0f]];
}

@end