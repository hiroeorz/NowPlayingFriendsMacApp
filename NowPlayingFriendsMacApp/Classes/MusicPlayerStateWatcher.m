//
//  MusicPlayerStateWatcher.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MusicPlayerStateWatcher.h"

#import "MusicPlayerController.h"
#import "iTunes.h"


#define kMusicPlayerStateWatchInterval 1.01f;


@interface MusicPlayerStateWatcher (Local) 
- (void)checkVolumeChanged:(MusicPlayerController *)musicPlayer;
- (void)checkRepeatModeChanged:(MusicPlayerController *)musicPlayer;
- (void)checkShuffleModeChanged:(MusicPlayerController *)musicPlayer;
- (void)sleep:(float)sec;
@end

@implementation MusicPlayerStateWatcher

@synthesize notificationCenter;
@synthesize volumeNotification;
@synthesize repeatModeNotification;

- (id)init {
  self = [super init];

  if (self) {
    volume = -1;
    repeatMode = -1;
    shuffleMode = -1;

    notificationCenter = [NSNotificationCenter defaultCenter];
    volumeNotification = [[NSNotification notificationWithName:kiTunesVolumeChanged 
					  object:self] retain];
    repeatModeNotification = [[NSNotification 
				notificationWithName:kiTunesRepeatModeChanged 
				object:self] retain];
    shuffleModeNotification = [[NSNotification 
				 notificationWithName:kiTunesShuffleModeChanged 
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
    [self checkVolumeChanged:musicPlayer];
    [self checkRepeatModeChanged:musicPlayer];
    [self checkShuffleModeChanged:musicPlayer];

    float checkInterval = kMusicPlayerStateWatchInterval;
    [self sleep:checkInterval];
    [pool release];
  }

}

- (void)checkVolumeChanged:(MusicPlayerController *)musicPlayer {
  
  if (musicPlayer.iTunes.soundVolume != volume) {
    NSLog(@"volume changed! (%d -> %d)", 
	  volume, musicPlayer.iTunes.soundVolume);
    volume = musicPlayer.iTunes.soundVolume;
    [notificationCenter postNotification:volumeNotification];
  }
}

- (void)checkRepeatModeChanged:(MusicPlayerController *)musicPlayer {
  
  iTunesPlaylist *playlist = [musicPlayer.iTunes currentPlaylist];
  NSInteger newRepeatMode = playlist.songRepeat;
  

  NSLog(@"repeat %d -> %d", newRepeatMode, repeatMode);

  if (newRepeatMode != repeatMode) {
    NSLog(@"repeatMode changed! (%d -> %d)", repeatMode, newRepeatMode);
    repeatMode = newRepeatMode;
    [notificationCenter postNotification:repeatModeNotification];
  }
}

- (void)checkShuffleModeChanged:(MusicPlayerController *)musicPlayer {
  
  iTunesPlaylist *playlist = [musicPlayer.iTunes currentPlaylist];
  NSInteger newShuffleMode = playlist.shuffle;

  NSLog(@"shuffle %d -> %d", newShuffleMode, shuffleMode);

  if (newShuffleMode != shuffleMode) {
    NSLog(@"shuffleMode changed! (%d -> %d)", shuffleMode, newShuffleMode);
    shuffleMode = newShuffleMode;
    [notificationCenter postNotification:shuffleModeNotification];
  }
}

- (void)sleep:(float)sec {

  NSDate *date = [[NSDate alloc] init];
  NSDate *nextStartDate = [[NSDate alloc] initWithTimeInterval:sec 
					  sinceDate:date];
  [NSThread sleepUntilDate: nextStartDate];

}

@end
