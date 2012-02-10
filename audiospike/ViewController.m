//
//  ViewController.m
//  audiospike
//
//  Created by Jay R Wren on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPVolumeView.h>

@implementation ViewController
@synthesize mpVolumeViewParentView;
@synthesize titleLabel;
@synthesize pauseButton;
@synthesize volumeSlider;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
AVPlayer *player;

-(void)playStream{
        
    NSURL *url = [NSURL URLWithString:@"http://66.180.202.151:8000/live"];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
                  
    [playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];
    [playerItem addObserver:self forKeyPath:@"timedMetadata" options:0 context:nil];
    player = [AVPlayer playerWithPlayerItem:playerItem];
                  
    [player play];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self playStream];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(volumeChanged:)
     name:@"AVSystemController_SystemVolumeDidChangeNotification"
     object:nil];
    
    mpVolumeViewParentView.backgroundColor = [UIColor clearColor];
    
    MPVolumeView *myVolumeView =
    
    [[MPVolumeView alloc] initWithFrame: mpVolumeViewParentView.bounds];
    
    [mpVolumeViewParentView addSubview: myVolumeView];
    

}
- (void)volumeChanged:(NSNotification *)notification
{
    float volume =
    [[[notification userInfo]
      objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]
     floatValue];
    
    volumeSlider.value = volume;
    NSLog(@"volumeChanged:%f", volume);
}


-(void)observeValueForKeyPath:(NSString *)keyPath
ofObject:(id)object
change:(NSDictionary *)change
context:(void *)context
{
    NSLog(@"path: %@", keyPath);
    NSLog(@"tracks:%@ ", player.currentItem.tracks);
    
    for (AVMetadataItem *metaItem in player.currentItem.timedMetadata) {
        NSLog(@"%@ %@",[metaItem commonKey], [metaItem value]);
    }
    if ([player.currentItem.timedMetadata count]>0) {
        AVMetadataItem *metaItem = [player.currentItem.timedMetadata objectAtIndex:0];
        titleLabel.text = (NSString*)[metaItem value];
    }
}

- (void)viewDidUnload
{
    [self setTitleLabel:nil];
    [self setPauseButton:nil];
    [self setVolumeSlider:nil];
    [self setMpVolumeViewParentView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonTouched:(id)sender {
    
    if (player.rate==1.0)
    {
        //[playerItem addObserver:self forKeyPath:@"timedMetadata" options:0 context:nil];
        //[player.currentItem removeObserver:self forKeyPath:@"timedMetadata" context:nil];
        //[player.currentItem removeObserver:self forKeyPath:@"status" context:nil];
        [player pause];
        //player = nil;
        [pauseButton setTitle:@"Play" forState:UIControlStateNormal];
    }
    else
    {
        //[self playStream];
        [player play];
        [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}
@end
