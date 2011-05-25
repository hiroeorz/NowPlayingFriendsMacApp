//
//  MusicPlayerStateWatcher.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#define kiTunesVolumeChanged @"iTunesVolumeChanged"
#define kiTunesRepeatModeChanged @"iTunesRepeatModeChanged"
#define kiTunesShuffleModeChanged @"iTunesShuffleModeChanged"


@class MusicPlayerController;


@interface MusicPlayerStateWatcher : NSObject {
@private
  NSNotificationCenter *notificationCenter;
  NSNotification *volumeNotification;
  NSNotification *repeatModeNotification;
  NSNotification *shuffleModeNotification;
  NSInteger volume;
  NSInteger repeatMode;
  NSInteger shuffleMode;
}

@property (nonatomic, retain) NSNotificationCenter *notificationCenter;
@property (nonatomic, retain) NSNotification *volumeNotification;
@property (nonatomic, retain) NSNotification *repeatModeNotification;
@property (nonatomic, retain) NSNotification *shuffleModeNotification;


- (void)startWatching:(MusicPlayerController *)musicPlayer;

@end
