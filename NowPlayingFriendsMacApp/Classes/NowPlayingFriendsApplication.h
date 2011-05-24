//
//  NowPlayingFriendsApplication.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NowPlayingFriendsApplication : NSApplication {
@private
  NSWindow *window;
  NSWindow *authWindow;
  NSWindow *tweetWindow;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSWindow *authWindow;
@property (assign) IBOutlet NSWindow *tweetWindow;

@end
