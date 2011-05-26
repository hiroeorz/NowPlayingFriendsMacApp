//
//  NowPlayingFriendsMacAppAppDelegate.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/22.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NowPlayingFriendsMacAppAppDelegate.h"

#import "Util.h"
#import "TwitterClient.h"


@implementation NowPlayingFriendsMacAppAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

  NSPanel *panel = [Util createUserPanelWithPositionX:2.0f positionY:2.0f
			 width:320.0f height:100.0f
			 alpha:0.85f];
  [panel orderFront:self];

  TwitterClient *client = [[TwitterClient alloc] init];
  NSArray *searchResult = [client getSearchTimeLine:@"ELLEGARDEN", nil];
  NSLog(@"searchResult: %@", searchResult);
}

@end
