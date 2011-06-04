//
//  AutoTweetController.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TwitterClient+NowPlaying.h"
#import "TwitterClient.h"
#import "iTunes.h"


@interface AutoTweetController : NSObject {
@private
  NSSegmentedControl *autoTweetSegmentedControl;
}

@property (nonatomic, retain) IBOutlet NSSegmentedControl *autoTweetSegmentedControl;


- (void)setNotification;
- (void)sendAutoTweetAfterTimelag;
- (void)sendAutoTweetWithYouTubeLink;
- (void)sendAutoTweetWithYouTubeResult:(NSArray *)youTubeLinks;
- (void)sendAutoTweetWithLinks:(NSArray *)addLinks;


@end
