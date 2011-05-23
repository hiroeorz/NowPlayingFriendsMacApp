//
//  NowPlayingFriendsMacAppAppDelegate.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Classes/iTunes.h"


@interface NowPlayingFriendsMacAppAppDelegate : 
  NSObject <NSApplicationDelegate> {

@private
    NSWindow *window;
}

@property (assign) IBOutlet NSWindow *window;

@end
