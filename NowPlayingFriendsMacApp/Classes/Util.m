//
//  Util.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"


@implementation Util

@synthesize iTunes;

- (id)init {
  self = [super init];
  
  if (self) {
    iTunes = [[SBApplication 
		applicationWithBundleIdentifier:@"com.apple.iTunes"] retain];
  }
    
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark
#pragma Class Methods

+ (iTunesTrack *)getCurrentTrack {

  iTunesApplication *iTunesApp = [SBApplication 
				   applicationWithBundleIdentifier:@"com.apple.iTunes"];

  return iTunesApp.currentTrack;
}

@end
