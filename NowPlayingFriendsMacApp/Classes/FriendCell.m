//
//  FriendCell.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendCell.h"

#import "Util.h"


@interface FriendCell (Local)
- (void)setTweetFieldForFrame:(NSRect)cellFrame inView:(NSView*)controlView;
- (void)setNameFieldForFrame:(NSRect)cellFrame inView:(NSView*)controlView;
@end


@implementation FriendCell

@synthesize tweet;

- (void)dealloc {
  [super dealloc];
}

- (id)initWithTweet:(NSDictionary *)aTweet {

  self = [super init];
  if (self != nil) { tweet = aTweet; }
  return self;
}

/**
 * @brief セルの内容の描画時に呼ばれる。
 */
- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView*)controlView {
  
  [self setTweetFieldForFrame:cellFrame inView:controlView];
  [self setNameFieldForFrame:cellFrame inView:controlView];
  [super drawInteriorWithFrame:cellFrame inView:controlView];
}

/**
 * @brief セルにツイート本文のフィールドをセットする。
 */
- (void)setTweetFieldForFrame:(NSRect)cellFrame inView:(NSView*)controlView {

  NSString *tweetText = [tweet objectForKey:@"text"];
  NSTextField *tweetField = [[NSTextField alloc] 
			      initWithFrame:cellFrame];

  tweetField.backgroundColor = [NSColor blackColor];
  [tweetField setEditable:NO];
  [tweetField setBordered:NO];
  [tweetField setStringValue:tweetText];
  [controlView addSubview:tweetField];
}

/**
 * @brief セルに送信もとユーザ名のフィールドをセットする。
 */
- (void)setNameFieldForFrame:(NSRect)cellFrame inView:(NSView*)controlView {

  NSString *tweetText = [tweet objectForKey:@"text"];
  NSString *name = [tweet objectForKey:@"from_user"];
  NSFont *font = [NSFont systemFontOfSize:11];

  float x = cellFrame.origin.x;
  float y = cellFrame.origin.y;
  float height = [Util heightForString:tweetText
		       font:font
		       width:249.0f];

  NSTextField *nameField = [[NSTextField alloc] 
			     initWithFrame:
			       NSMakeRect(x + 1.0f, 
					  y + height + 5.0f,
					  249.0f, 20.0f)];

  nameField.backgroundColor = [NSColor blackColor];
  [nameField setEditable:NO];
  [nameField setBordered:NO];
  [nameField setStringValue:((tweet == nil) ? @"" : name)];
  [controlView addSubview:nameField];
}

@end
