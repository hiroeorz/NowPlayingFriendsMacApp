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


#define kBackTrack 0
#define kTogglePlayStop 1
#define kNextTrack 2

#define kRepeatModeOff 0;
#define kRepeatModeSong 1;
#define kRepeatModeAlbum 2;


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
@synthesize artworkImageView;
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

- (IBAction)playerControlButtonClicked:(id)sender {
  
  switch ([sender selectedSegment]) {
  case kBackTrack:      [self backTrack:sender];      break;
  case kTogglePlayStop: [self togglePlayStop:sender]; break;
  case kNextTrack:      [self nextTrack:sender];      break;
  }
}

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

#pragma mark
#pragma Music Player Control Methods

- (IBAction)setVolume:(id)sender {

  iTunes.soundVolume = [sender doubleValue];
}

- (IBAction)setPosition:(id)sender {

  iTunes.playerPosition = [sender integerValue];
}

- (IBAction)setShuffle:(id)sender {

  iTunesPlaylist *playlist = [iTunes currentPlaylist];
  BOOL shuffle = ([sender selectedSegment] == 1);
  playlist.shuffle = shuffle;
}

- (IBAction)setRepeat:(id)sender {

  iTunesPlaylist *playlist = [iTunes currentPlaylist];
  NSInteger repeatMode = [sender selectedSegment];

  switch (repeatMode) {
  case 0:
    playlist.songRepeat = iTunesERptOff;
    break;
  case 1:
    playlist.songRepeat = iTunesERptOne;
    break;    
  case 2:
    playlist.songRepeat =  iTunesERptAll;
    break;        
  }
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

  if (songTitle != nil) { albumSelectButton.title = songTitle; }
  if (albumName != nil) { albumTitleTextField.stringValue = albumName; }
  if (artistName != nil) {artistNameTextField.stringValue = artistName; }
}

- (void)updateMusicSegmentControl {

  switch ([iTunes playerState]) {
  case iTunesEPlSPlaying:
    [musicSegmentedControl setImage:[NSImage imageNamed:@"Pause.png"]
			   forSegment:1];
    break;
  case iTunesEPlSStopped:
    [musicSegmentedControl setImage:[NSImage imageNamed:@"Play.png"] 
			   forSegment:1];
    break;
  case iTunesEPlSPaused:
    [musicSegmentedControl setImage:[NSImage imageNamed:@"Play.png"] 
			   forSegment:1];
    break;
  case iTunesEPlSFastForwarding:
    break;
  case iTunesEPlSRewinding:
    break;
  }
}

- (void)updateAlbumArtwork {

  SBElementArray *artworks = [iTunes.currentTrack artworks];
  iTunesArtwork *artwork = [artworks objectAtIndex:0];

  if (artwork != nil) {
    artworkImageView.image = artwork.data;
  } else {
    artworkImageView.image = [NSImage imageNamed:@"friends2_wide305.png"];
  }
}

- (void)updateViewsWhenStateChange {

  [self updateSongTitle];
  [self updateMusicSegmentControl];
  [self updateShuffleSegmentControl];
  [self updateRepeatSegmentControl];
  [self updateVolumeSlider];
  [self updatePositionSlider];
  [self updateAlbumArtwork];
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

#pragma mark
#pragma Toolbar Delegate Methods

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar*)toolbar {
  return [NSArray arrayWithObjects:@"Tweet", nil];
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar*)toolbar {
  return [NSArray arrayWithObjects:@"Tweet", nil];
}


- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar 
     itemForItemIdentifier:(NSString *)itemIdentifier 
 willBeInsertedIntoToolbar:(BOOL)flag {

  NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] 
				 initWithItemIdentifier:itemIdentifier];
 
 if ([itemIdentifier isEqual:@"Tweet"]) {
  [toolbarItem setLabel:@"Tweet"];
  [toolbarItem setImage:[NSImage imageNamed:@"hello"]];
  
  [toolbarItem setTarget:self];
  [toolbarItem setAction:@selector(hello:)];

 } else {
  toolbarItem = nil;
 }
 return toolbarItem;
}

@end