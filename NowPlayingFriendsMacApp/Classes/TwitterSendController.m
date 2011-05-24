//
//  TwitterSendController.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterSendController.h"

#import "TwitterClient.h"
#import "YouTubeClient.h"
#import "iTunes.h"
#import "MusicPlayerController.h"


@interface TwitterSendController (Local)
- (void)ticket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)ticket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error;
@end


@implementation TwitterSendController

@synthesize tweetEditField;

- (id)init
{
  self = [super init];

  if (self) {
  }
    
  return self;
}

- (void)dealloc
{
  [super dealloc];
}

#pragma mark
#pragma IBOutlet Methods

- (IBAction)sendTweet:(id)sender {

  TwitterClient *client = [[TwitterClient alloc] init];
  NSString *message = [tweetEditField stringValue];

  [client updateStatus:message inReplyToStatusId:nil delegate:self];
}

- (IBAction)addYouTubeLink:(id)sender {
  
  MusicPlayerController *musicPlayer = [[MusicPlayerController alloc] init];
  NSString *songTitle = [musicPlayer.iTunes.currentTrack name];
  NSString *albumTitle = [musicPlayer.iTunes.currentTrack album];
  NSString *artistName = [musicPlayer.iTunes.currentTrack artist];

  YouTubeClient *youTube = [[YouTubeClient alloc] init];
  [youTube searchWithTitle:songTitle artist:artistName 
	   delegate:self action:@selector(addYouTubeLinkAfterYouTubeSearch:)
	   count:1]; 
}

#pragma mark

- (void)addYouTubeLinkAfterYouTubeSearch:(NSArray *)searchResults {

  NSString *linkUrl = nil;
  NSString *tweet = [tweetEditField stringValue];

  if ([searchResults count] > 0) {
    NSDictionary *dic = [searchResults objectAtIndex:0];
    linkUrl = [dic objectForKey:@"linkUrl"];
  }

  if (linkUrl != nil) {
    tweet = [[NSString alloc] initWithFormat:@"%@ %@", tweet, linkUrl];
    [tweetEditField setStringValue:tweet];
  } else {
    NSLog(@"YouTube link is not exist.");
  }
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

@end
