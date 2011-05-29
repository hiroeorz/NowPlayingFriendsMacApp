//
//  NowPlayingFriendsMacAppAppDelegate.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Classes/iTunes.h"


@class FriendsGetter;
@class AutoTweetController;


@interface NowPlayingFriendsMacAppAppDelegate : 
  NSObject <NSApplicationDelegate> {

@private
  NSWindow *window;
  FriendsGetter *friendsGetter;
  AutoTweetController *autoTweetController;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) AutoTweetController *autoTweetController;
@property (nonatomic, retain) FriendsGetter *friendsGetter;

@end
