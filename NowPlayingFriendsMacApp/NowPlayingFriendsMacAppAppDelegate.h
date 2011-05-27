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


@interface NowPlayingFriendsMacAppAppDelegate : 
  NSObject <NSApplicationDelegate> {

@private
  NSWindow *window;
  FriendsGetter *friendsGetter;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) FriendsGetter *friendsGetter;

@end
