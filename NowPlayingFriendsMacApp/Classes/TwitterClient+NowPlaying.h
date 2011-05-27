//
//  TwitterClient.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterClient.h"


#define kTweetTemplate @"♪ #NowPlaying \"[st]\" by \"[ar]\" on album \"[al]\" ♬"
#define kNowPlayingTags @"nowplaying OR nowlistening OR twitmusic OR BGM";


@class iTunesApplication;


@interface TwitterClient (NowPlaying) {
    
}

- (NSString *)tweetString:(iTunesApplication *)iTunes;

@end
