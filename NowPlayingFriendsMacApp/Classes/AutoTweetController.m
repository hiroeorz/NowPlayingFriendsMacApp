
//
//  AutoTweetController.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AutoTweetController.h"

#import "Util.h"
#import "iTunesStatuses.h"
#import "YouTubeClient.h"


#define kAutoTweetTimelag 10


@interface AutoTweetController (Local)
@end


@implementation AutoTweetController

- (id)init {

  self = [super init];
  
  if (self) {
  }
  
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark

/*
 * @brief 曲が切り替わったら自動ツイートするように修正する。
 */
- (void)setNotification {

  NSNotificationCenter *notificationCenter = 
    [NSNotificationCenter defaultCenter];
  
  [notificationCenter 
    addObserver:self 
    selector:@selector(sendAutoTweetAfterTimelag)
    name:kiTunesTrackChanged object:nil];
}

- (void)sendAutoTweetAfterTimelag {
  
  NSLog(@"iTunes play state: %@", ([Util iTunesIsPlaying] ? @"YES" : @"NO"));

  BOOL *autoTweetSetting = NO;

  if (!autoTweetSetting) { return; }
  if (![Util iTunesIsPlaying]) { return; }

  NSInteger currentTrackID = [Util getCurrentTrack].databaseID;
  [Util sleep:kAutoTweetTimelag];
  NSInteger newCurrentTrackID = [Util getCurrentTrack].databaseID;
  BOOL addYouTubeLinkSetting = YES;

  if (currentTrackID != newCurrentTrackID) { return; }

  if (addYouTubeLinkSetting && [Util iTunesIsPlaying]) {
    [self sendAutoTweetWithYouTubeLink];

    [self performSelectorOnMainThread:
	    @selector(sendAutoTweetWithYouTubeLink)
	  withObject:nil
	  waitUntilDone:NO];
  } else {
    [self sendAutoTweetWithLinks:nil];
  }
}

- (void)sendAutoTweetWithYouTubeLink {
  
  NSLog(@"starting auto tweet with YouTube link...");
  YouTubeClient *youTubeClient = [[YouTubeClient alloc] init];
  iTunesApplication *iTunes = [Util iTunes];
  iTunesTrack *currentTrack = [Util getCurrentTrack];

  [youTubeClient searchWithTitle:[currentTrack name] 
		 artist:[currentTrack artist]
		 delegate:self 
		 action: @selector(sendAutoTweetWithYouTubeResult:) 
		 count:1];

}

- (void)sendAutoTweetWithYouTubeResult:(NSArray *)youTubeLinks {

  NSLog(@"YouTube search result is %@", youTubeLinks);
  NSMutableArray *array = [[NSMutableArray alloc] init];

  for (NSDictionary *dic in youTubeLinks) {
    NSString *link = [dic objectForKey:@"linkUrl"];
    [array addObject:link];
  }

  [self sendAutoTweetWithLinks:array];
}

- (void)sendAutoTweetWithLinks:(NSArray *)addLinks {

  NSLog(@"starting auto tweet...");
  TwitterClient *client = [[TwitterClient alloc] init];
  iTunesApplication *iTunes = [Util iTunes];
  NSMutableString *tweet = [[client tweetString:iTunes] mutableCopy];

  for (NSString *link in addLinks) {
    [tweet appendFormat:@" %@", link];
  }

  [client updateStatus:tweet inReplyToStatusId:nil delegate:self];
}

#pragma mark

- (void)ticket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {

  NSLog(@"didFinishWithData");
  NSString *dataString = [[NSString alloc] 
			   initWithData:data encoding:NSUTF8StringEncoding];
  NSLog(@"data: %@", dataString);
}

- (void)ticket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error {
  NSLog(@"didFailWithError");
}

#pragma mark
#pragma Local Methods


@end
