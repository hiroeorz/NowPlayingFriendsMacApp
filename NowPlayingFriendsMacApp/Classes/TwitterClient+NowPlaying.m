//
//  TwitterClient.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterClient+NowPlaying.h"

#import "iTunes.h"


@implementation TwitterClient (NowPlaying)

- (NSString *)tweetString:(iTunesApplication *)iTunes {

  NSString *template = kTweetTemplate;
  NSString *songTitle = [iTunes.currentTrack name];
  NSString *artistName = [iTunes.currentTrack artist];
  NSString *albumName = [iTunes.currentTrack album];
  NSString *tweet;

  tweet = [template stringByReplacingOccurrencesOfString:@"[st]"
		    withString:songTitle];

  tweet = [tweet stringByReplacingOccurrencesOfString:@"[al]"
		    withString:albumName];

  tweet = [tweet stringByReplacingOccurrencesOfString:@"[ar]"
		 withString:artistName];

  return tweet;
}

@end
