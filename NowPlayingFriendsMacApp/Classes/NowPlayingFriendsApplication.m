//
//  NowPlayingFriendsApplication.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NowPlayingFriendsApplication.h"


@implementation NowPlayingFriendsApplication

@synthesize window;
@synthesize authWindow;
@synthesize tweetWindow;

- (id)init {
  self = [super init];

  if (self) {
  }
  
  return self;
}

- (void)dealloc {
  [super dealloc];
}

- (void)awakeFromNib {
}

@end
