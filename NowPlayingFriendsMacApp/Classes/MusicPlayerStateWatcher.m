//
//  MusicPlayerStateWatcher.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicPlayerStateWatcher.h"

#import "MusicPlayerController.h"
#import "Util.h"
#import "iTunes.h"


#define kMusicPlayerStateWatchInterval 0.03f;


@interface MusicPlayerStateWatcher (Local) 
- (void)checkPlayStateChanged:(MusicPlayerController *)musicPlayer;
- (void)checkTrackChanged:(MusicPlayerController *)musicPlayer;
- (void)checkVolumeChanged:(MusicPlayerController *)musicPlayer;
- (void)checkRepeatModeChanged:(MusicPlayerController *)musicPlayer;
- (void)checkShuffleModeChanged:(MusicPlayerController *)musicPlayer;
- (void)checkPositionChanged:(MusicPlayerController *)musicPlayer;
- (void)sleep:(float)sec;
@end

@implementation MusicPlayerStateWatcher

@synthesize notificationCenter;
@synthesize volumeNotification;
@synthesize repeatModeNotification;
@synthesize shuffleModeNotification;
@synthesize positionNotification;
@synthesize trackChnangedNotification;
@synthesize playStateChangedNotification;

- (id)init {
  self = [super init];

  if (self) {
    volume = -1;
    repeatMode = -1;
    shuffleMode = -1;
    position = -1;
    playState = 0;

    notificationCenter = [NSNotificationCenter defaultCenter];
    volumeNotification = [[NSNotification notificationWithName:kiTunesVolumeChanged 
					  object:self] retain];
    repeatModeNotification = [[NSNotification 
				notificationWithName:kiTunesRepeatModeChanged 
				object:self] retain];
    shuffleModeNotification = [[NSNotification 
				 notificationWithName:kiTunesShuffleModeChanged 
				 object:self] retain];
    positionNotification = [[NSNotification 
			      notificationWithName:kiTunesPositionChanged 
			      object:self] retain];
    trackChnangedNotification = [[NSNotification 
				   notificationWithName:kiTunesTrackChanged 
				   object:self] retain];
    playStateChangedNotification = [[NSNotification 
				   notificationWithName:kiTunesPlayStateChanged 
				   object:self] retain];
  }
    
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark
#pragma Watching Methods

- (void)startWatching:(MusicPlayerController *)musicPlayer {

  while(YES) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [self checkPlayStateChanged:musicPlayer];
    [self checkTrackChanged:musicPlayer];
    [self checkVolumeChanged:musicPlayer];
    [self checkRepeatModeChanged:musicPlayer];
    [self checkShuffleModeChanged:musicPlayer];
    [self checkPositionChanged:musicPlayer];

    float checkInterval = kMusicPlayerStateWatchInterval;
    [Util sleep:checkInterval];
    [pool release];
  }

}

- (void)checkPlayStateChanged:(MusicPlayerController *)musicPlayer {
  
  iTunesEPlS newPlayState = [musicPlayer.iTunes playerState];

  if (newPlayState != playState) {
    playState = newPlayState;
    [notificationCenter postNotification:playStateChangedNotification];
  }
}

- (void)checkTrackChanged:(MusicPlayerController *)musicPlayer {
  
  NSInteger newTrackId = musicPlayer.iTunes.currentTrack.databaseID;

  if (newTrackId != trackId) {
    trackId = newTrackId;
    [notificationCenter postNotification:trackChnangedNotification];
  }
}

- (void)checkVolumeChanged:(MusicPlayerController *)musicPlayer {
  
  if (musicPlayer.iTunes.soundVolume != volume) {
    volume = musicPlayer.iTunes.soundVolume;
    [notificationCenter postNotification:volumeNotification];
  }
}

- (void)checkRepeatModeChanged:(MusicPlayerController *)musicPlayer {
  
  iTunesPlaylist *playlist = [musicPlayer.iTunes currentPlaylist];
  NSInteger newRepeatMode = playlist.songRepeat;
  

  if (newRepeatMode != repeatMode) {
    repeatMode = newRepeatMode;
    [notificationCenter postNotification:repeatModeNotification];
  }
}

- (void)checkShuffleModeChanged:(MusicPlayerController *)musicPlayer {
  
  iTunesPlaylist *playlist = [musicPlayer.iTunes currentPlaylist];
  NSInteger newShuffleMode = playlist.shuffle;

  if (newShuffleMode != shuffleMode) {
    shuffleMode = newShuffleMode;
    [notificationCenter postNotification:shuffleModeNotification];
  }
}

- (void)checkPositionChanged:(MusicPlayerController *)musicPlayer {
  
  NSInteger newPosition = [musicPlayer.iTunes playerPosition];

  if (newPosition != position) {
    position = newPosition;
    [notificationCenter postNotification:positionNotification];
  }
}

@end
