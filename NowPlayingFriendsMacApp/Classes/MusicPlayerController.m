//
//  MusicPlayerController.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iTunes.h"
#import "MusicPlayerController.h"
#import "../NowPlayingFriendsMacAppAppDelegate.h"


@interface MusicPlayerController (Local)
- (NSInteger)songTimeOfTrack:(iTunesTrack *)track;
- (void)updateShuffleSegmentControl;
- (void)updateRepeatSegmentControl;
@end

@implementation MusicPlayerController

@synthesize albumSelectButton;
@synthesize musicSegmentedControl;
@synthesize positionSlider;
@synthesize repeatSegmentedControl;
@synthesize shuffleSegmentedControl;
@synthesize volumeSlider;
@synthesize iTunes;
@synthesize albumTitleTextField;
@synthesize artistNameTextField;
@dynamic appDelegate;

#pragma mark -
#pragma Initializer

- (id)init {
  self = [super init];

  if (self != nil) {
    iTunes = [SBApplication 
	       applicationWithBundleIdentifier:@"com.apple.iTunes"];
  }
  return self;
}

- (void)dealloc {
  [super dealloc];
}


#pragma mark
#pragma Awake Methods

- (void)awakeFromNib {
  [self updateViewsWhenStateChange];
}

#pragma mark
#pragma IBAction Methods

- (IBAction)backTrack:(id)sender {

  [iTunes backTrack];
  [self updateViewsWhenStateChange];
}

- (IBAction)fastForward:(id)sender {

  [iTunes fastForward];
  [self updateViewsWhenStateChange];
}

- (IBAction)togglePlayStop:(id)sender {

  [iTunes playpause];
  [self updateViewsWhenStateChange];
}

- (IBAction)nextTrack:(id)sender {

  [iTunes nextTrack];
  [self updateViewsWhenStateChange];
}

- (IBAction)setVolume:(id)sender {

  
  [self updateViewsWhenStateChange];
}

#pragma mark
#pragma View Methods

- (void)updateShuffleSegmentControl {

  iTunesPlaylist *playlist = [iTunes currentPlaylist];

  if ([playlist shuffle]) {
    shuffleSegmentedControl.selectedSegment = 1;    
  } else {
    shuffleSegmentedControl.selectedSegment = 0;
  }
}

- (void)updateRepeatSegmentControl {

  iTunesPlaylist *playlist = [iTunes currentPlaylist];
  iTunesERpt currentRepeatMode = [playlist songRepeat];

  switch(currentRepeatMode) {
  case iTunesERptOff: 
    repeatSegmentedControl.selectedSegment = 0;
    break;
  case iTunesERptOne:
    repeatSegmentedControl.selectedSegment = 1;
    break;    
  case iTunesERptAll:
    repeatSegmentedControl.selectedSegment = 2;
    break;        
  }
}

- (void)updateVolumeSlider {
  [volumeSlider setDoubleValue:(double)iTunes.soundVolume];
}

- (void)updatePositionSlider {

  NSInteger songTime = [self songTimeOfTrack:iTunes.currentTrack];
  [positionSlider setMinValue:0];
  [positionSlider setMaxValue:songTime];
  [positionSlider setDoubleValue:(double)iTunes.playerPosition];
}

- (void)updateSongTitle {

  NSString *songTitle = [iTunes.currentTrack name];
  NSString *artistName = [iTunes.currentTrack artist];
  NSString *albumName = [iTunes.currentTrack album];
  albumSelectButton.title = songTitle;
  albumTitleTextField.stringValue = albumName;
  artistNameTextField.stringValue = artistName;
}

- (void)updateViewsWhenStateChange {

  [self updateSongTitle];
  [self updateShuffleSegmentControl];
  [self updateRepeatSegmentControl];
  [self updateVolumeSlider];
  [self updatePositionSlider];
}

#pragma mark
#pragma Local Methods

- (NSInteger)songTimeOfTrack:(iTunesTrack *)track {

  NSString *songTimeStr = track.time;
  NSArray *timePartArray = [songTimeStr componentsSeparatedByString:@":"];
  NSInteger min = [[timePartArray objectAtIndex:0] integerValue];
  NSInteger sec = [[timePartArray objectAtIndex:1] integerValue];
  NSInteger songTime = (min * 60) + sec;
  return songTime;
}

@end
