//
//  TwitterSendController.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterSendController.h"

#import "TwitterClient.h"


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
        // Initialization code here.
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
