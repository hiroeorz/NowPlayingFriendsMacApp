//
//  FriendsGetter.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterClient.h"
#import "TwitterClient+NowPlaying.h"


@interface FriendsGetter : NSObject {
@private
  NSPanel *panel;
}

@property(nonatomic, retain) NSPanel *panel;


- (void)setNotification;
- (void)getSongTimelineWhenTrackChanged;

- (NSPanel *)createUserPanelWithPositionX:(float)x positionY:(float)y
				    width:(float)width height:(float)height
				    alpha:(float)alpha
				    tweet:(NSDictionary *)tweet;

@end
