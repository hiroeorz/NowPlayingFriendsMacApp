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
  NSWindow *tweetWindow;
}

@property (assign) IBOutlet NSWindow *tweetWindow;
@property (nonatomic, retain) IBOutlet NSTextField *tweetEditField;


- (IBAction)sendTweet:(id)sender;
- (IBAction)addYouTubeLink:(id)sender;
- (void)addYouTubeLinkAfterYouTubeSearch:(NSArray *)searchResults;
- (IBAction)addITunesStoreSearchTweet:(id)sender;
- (void)addITunesStoreSearchLink:(NSString *)linkUrl;

@end
