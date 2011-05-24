//
//  TwitterSendController.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwitterSendController : NSObject {
@private
  NSTextField *tweetEditField;
}

@property (nonatomic, retain) IBOutlet NSTextField *tweetEditField;


- (IBAction)addYouTubeLink:(id)sender;
- (IBAction)sendTweet:(id)sender;

@end
