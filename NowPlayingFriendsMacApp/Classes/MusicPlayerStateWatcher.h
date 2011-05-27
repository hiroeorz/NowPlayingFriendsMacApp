//
//  MusicPlayerStateWatcher.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunes.h"
#import "iTunesStatuses.h"


@class MusicPlayerController;


@interface MusicPlayerStateWatcher : NSObject {
@private
  NSNotificationCenter *notificationCenter;
  NSNotification *volumeNotification;
  NSNotification *repeatModeNotification;
  NSNotification *shuffleModeNotification;
  NSNotification *positionNotification;
  NSNotification *trackChangedNotification;
  NSInteger volume;
  NSInteger repeatMode;
  NSInteger shuffleMode;
  NSInteger position;
  NSInteger trackId;
  iTunesEPlS playState;
}

@property (nonatomic, retain) NSNotificationCenter *notificationCenter;
@property (nonatomic, retain) NSNotification *volumeNotification;
@property (nonatomic, retain) NSNotification *repeatModeNotification;
@property (nonatomic, retain) NSNotification *shuffleModeNotification;
@property (nonatomic, retain) NSNotification *positionNotification;
@property (nonatomic, retain) NSNotification *trackChnangedNotification;
@property (nonatomic, retain) NSNotification *playStateChangedNotification;


- (void)startWatching:(MusicPlayerController *)musicPlayer;

@end
