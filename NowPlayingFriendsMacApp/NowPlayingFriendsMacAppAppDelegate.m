//
//  NowPlayingFriendsMacAppAppDelegate.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NowPlayingFriendsMacAppAppDelegate.h"

#import "AutoTweetController.h"
#import "FriendsGetter.h"
#import "TwitterClient.h"
#import "Util.h"
#import "iTunes.h"


@implementation NowPlayingFriendsMacAppAppDelegate

@synthesize window;
@synthesize friendsGetter;
@synthesize autoTweetController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

  self.friendsGetter = [[FriendsGetter alloc] init];
  [friendsGetter setNotification];
  [friendsGetter getSongTimelineWhenTrackChanged];

  self.autoTweetController = [[AutoTweetController alloc] init];
  [autoTweetController setNotification];
}

@end
