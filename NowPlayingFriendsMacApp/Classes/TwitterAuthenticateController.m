//
//  TwitterAuthenticateController.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterAuthenticateController.h"

#import "JSON/JSON.h"
#import "TwitterClient.h"
#import "OAuthConsumer/OAConsumer.h"
#import "OAuthConsumer/OADataFetcher.h"
#import "OAuthConsumer/OAMutableURLRequest.h"
#import "OAuthConsumer/OARequestParameter.h"


@interface TwitterAuthenticateController (Local)
- (void)ticket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)ticket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error;
@end


@implementation TwitterAuthenticateController

@synthesize userNameField;
@synthesize passwordField;

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
#pragma IBAction Methods

- (IBAction)authenticate:(id)sender {

  NSString *username = [userNameField stringValue];
  NSString *password = [passwordField stringValue];
  NSLog(@"user input username:%@ password:%@", username, password);

  TwitterClient *client = [[TwitterClient alloc] init];
  [client getAccessTokenWithUsername:username
	  password:password
	  delegate:self];
}

- (void)ticket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data {

  NSLog(@"didFinishWithData");
  NSString *dataString = [[NSString alloc] 
			   initWithData:data encoding:NSUTF8StringEncoding];

  NSLog(@"data: %@", dataString);
  NSRange rangeOfInvalid = [dataString rangeOfString:@"Invalid"];
  NSRange rangeOfOauthToken = [dataString rangeOfString:@"oauth_token"];

  if (rangeOfInvalid.location == NSNotFound && 
      rangeOfOauthToken.location != NSNotFound) {

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    for (NSString *pair in [dataString componentsSeparatedByString:@"&"]) {
      NSArray *keyValue = [pair componentsSeparatedByString:@"="];
      NSLog(@"pair:%@", pair);
      
      [dict setObject:[keyValue objectAtIndex:1] 
	    forKey:[keyValue objectAtIndex:0]];
    }
    
    NSLog(@"result: %@", dict);

    TwitterClient *client = [[TwitterClient alloc] init];
    [client saveToken:dict]; NSLog(@"token data saved.");
  } else {
    NSLog(@"! Authentication failure.");
  }
}

- (void)ticket:(OAServiceTicket *)ticket didFailWithError:(NSError *)error {
  NSLog(@"didFailWithError");
}

@end
