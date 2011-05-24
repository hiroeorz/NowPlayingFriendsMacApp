//
//  TwitterClient.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterClient+ConsumerKey.h"
#import "OAuthConsumer/OAServiceTicket.h"


#define kVerifyUrl @"https://api.twitter.com/1/account/verify_credentials.json"
#define kOAuthTokenUrl @"https://api.twitter.com/oauth/access_token"
#define kHomeTimelineURL @"https://twitter.com/statuses/home_timeline/%@.json%@"
#define kUserTimelineURL @"https://twitter.com/statuses/user_timeline/%@.json%@"
#define kMenthonsTimelineURL @"https://api.twitter.com/1/statuses/mentions.json%@"
#define kSearchURL @"http://search.twitter.com/search.json?q=%@"
#define kUserInformationURL @"https://api.twitter.com/1/users/show/%@.json"
#define kUpdateStatusURL @"https://twitter.com/statuses/update.json"
#define kOAuthAccetokenFileName @"access_token.plist"
#define kCreateFriendURL @"https://twitter.com/friendships/create/%@.json"
#define kCheckFriendShipURL @"https://api.twitter.com/1/friendships/show.json?target_screen_name=%@"

#define kTwitterFrindsSearchUrl @"https://api.twitter.com/1/statuses/friends.json?screen_name=%@&cursor=%@"


@interface TwitterClient : NSObject {
@private
    
}


- (void)getAccessTokenWithUsername:(NSString *)username 
			  password:(NSString *)password
			  delegate:(id)delegate;


@end
