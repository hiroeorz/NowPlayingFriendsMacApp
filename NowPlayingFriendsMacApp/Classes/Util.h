//
//  Util.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunes.h"


@interface Util : NSObject {
@private
  iTunesApplication *iTunes;
}

@property (nonatomic, retain) iTunesApplication *iTunes;


+ (iTunesTrack *)getCurrentTrack;
+ (void)sleep:(float)sec;
+ (iTunesApplication *)iTunes;
+ (BOOL)iTunesIsPlaying;

+ (float)heightForString:(NSString *)myString 
		    font:(NSFont *)myFont
		   width:(float)myWidth;

+ (NSDate *)tweetDate:(NSDictionary *)data;
+ (NSInteger)secondSinceNow:(NSDictionary *)data;
+ (NSString *)passedTimeString:(NSDictionary *)tweet;

@end
