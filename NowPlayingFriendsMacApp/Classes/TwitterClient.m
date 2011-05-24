//
//  TwitterClient.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterClient.h"
#import "TwitterClient+NowPlaying.h"

#import "JSON/JSON.h"
#import "OAuthConsumer/OAConsumer.h"
#import "OAuthConsumer/OADataFetcher.h"
#import "OAuthConsumer/OAMutableURLRequest.h"
#import "OAuthConsumer/OARequestParameter.h"


#define kTokenFilePath [NSHomeDirectory() stringByAppendingPathComponent:@".now_playinf_friends.token"];


@implementation TwitterClient

- (id)init
{
  self = [super init];

  if (self) {}
  
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark -
#pragma Update Status Methods

- (void)updateStatus:(NSString *)message
   inReplyToStatusId:(NSNumber *)replayToStatusId
	    delegate:(id)aDelegate {

  [self updateStatus:message
	inReplyToStatusId:replayToStatusId
	withArtwork:NO
	delegate:aDelegate];
}

- (void)updateStatus:(NSString *)message
   inReplyToStatusId:(NSNumber *)replayToStatusId
	 withArtwork:(BOOL)withArtwork
	    delegate:(id)aDelegate {
  
  if (![self oAuthTokenExist]) { return; }

  if (withArtwork) { 
  }

  NSURL *baseUrl = [NSURL URLWithString:kUpdateStatusURL];
  OAMutableURLRequest *request = [self authenticatedRequest:baseUrl];

  CFStringRef ignoreString = CFSTR(";,/?:@&=+$#");
  NSString *paramsStr = (NSString *)CFURLCreateStringByAddingPercentEscapes(  
						       kCFAllocatorDefault,
						       (CFStringRef)message,
						       NULL,
                                                       ignoreString,
                                                       kCFStringEncodingUTF8);
  NSMutableString *bodyString = 
    [NSMutableString stringWithFormat:@"status=%@", paramsStr];

  if (replayToStatusId != nil) {
    NSMutableString *replyParameter = [[NSMutableString alloc] 
				     initWithString:@"&in_reply_to_status_id="];
    [replyParameter appendString:[replayToStatusId stringValue]];
    [bodyString appendString:replyParameter];
  }

  [request setHTTPBody:[bodyString dataUsingEncoding:NSUTF8StringEncoding]];

  OADataFetcher *fetcher = [[OADataFetcher alloc] init];
  [fetcher fetchDataWithRequest:request
	   delegate:aDelegate
	   didFinishSelector:@selector(ticket:didFinishWithData:)
	   didFailSelector:@selector(ticket:didFailWithError:)];
}

#pragma mark -
#pragma Get AccessToken Methods

/**
 * @brief ユーザ名とパスワードからユーザのアクセストークンを取得する。
 */
- (void)getAccessTokenWithUsername:(NSString *)username 
			  password:(NSString *)password
			  delegate:(id)delegate {
  NSURL *url = 
    [NSURL URLWithString:kOAuthTokenUrl];

  OAConsumer *consumer = [[OAConsumer alloc] initWithKey:kConsumerKey
					     secret:kConsumerSecret];
  OAMutableURLRequest 
    *request = [[OAMutableURLRequest alloc] initWithURL:url
					    consumer:consumer
					    token:nil
					    realm:nil
					    signatureProvider:nil];
  [consumer release];

  // 新たに付加するパラメータ
  NSMutableArray *xAuthParameters = [NSMutableArray arrayWithCapacity:3];
  [xAuthParameters addObject:[OARequestParameter 
			       requestParameterWithName:@"x_auth_mode" 
			       value:@"client_auth"]];

  [xAuthParameters addObject:[OARequestParameter 
			       requestParameterWithName:@"x_auth_username" 
			       value:username]];

  [xAuthParameters addObject:[OARequestParameter 
			       requestParameterWithName:@"x_auth_password" 
			       value:password]];

  // 順番が大事！
  [request setHTTPMethod:@"POST"];
  [request setParameters:xAuthParameters];

  OADataFetcher *fetcher = [[OADataFetcher alloc] init];
  
  [fetcher fetchDataWithRequest:request
	   delegate:delegate
	   didFinishSelector:@selector(ticket:didFinishWithData:)
	   didFailSelector:@selector(ticket:didFailWithError:)];
}

- (BOOL)oAuthTokenExist {

  NSDictionary *token = [self oAuthToken];
  return (token != nil);
}

- (void)saveToken:(NSDictionary *)token {
  
  NSString *path = kTokenFilePath;
  [token writeToFile:path atomically:YES];
}

- (NSDictionary *)oAuthToken {
    
  NSString *path = kTokenFilePath;
  NSDictionary *token = [[NSDictionary alloc] initWithContentsOfFile:path];
  return token;
}

/**
 * @brief 認証情報を埋めこんだRequestオブジェクトを生成する。
 */
- (id)authenticatedRequest:(NSURL *)url {

  if (![self oAuthTokenExist]) {
    NSMutableURLRequest *notAuthencticatedRequest = 
      [NSMutableURLRequest requestWithURL:url];

    return notAuthencticatedRequest;
  }

  OAConsumer *consumer = [[OAConsumer alloc] initWithKey:kConsumerKey
					     secret:kConsumerSecret];
  NSDictionary *token = [self oAuthToken];

  OAToken *accessToken =
    [[OAToken alloc] initWithKey:[token objectForKey:@"oauth_token"]
		      secret:[token objectForKey:@"oauth_token_secret"]];
  
  OAMutableURLRequest *request = 
    [[OAMutableURLRequest alloc] initWithURL:url
				 consumer:consumer
				 token:accessToken
				 realm:nil
				 signatureProvider:nil];
  [request autorelease];
  [request setHTTPMethod:@"POST"];

  return request;
}

@end
