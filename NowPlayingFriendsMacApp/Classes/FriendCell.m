//
//  FriendCell.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendCell.h"

#import "ImageGetter.h"
#import "Util.h"


@interface FriendCell (Local)
- (void)setTweetFieldForFrame:(NSRect)cellFrame inView:(NSView*)controlView;
- (void)setProfileImageForFrame:(NSRect)cellFrame inView:(NSView*)controlView;
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
  [self setProfileImageForFrame:cellFrame inView:controlView];
}

- (float)tweetFieldHeight:(NSString *)tweetText width:(float)width {

  NSFont *font = [NSFont systemFontOfSize:11];
  float imageSizeWithMargin = 
    kProfileImageSize + kProfileImageMargin * 2.0f;

  float tweetFieldWidth = width - imageSizeWithMargin;
  float height = [Util heightForString:tweetText
		       font:font
		       width:tweetFieldWidth];

  return height;
}

/**
 * @brief セルにプロフィール画像をセットする。
 */
- (void)setProfileImageForFrame:(NSRect)cellFrame inView:(NSView*)controlView {

  NSString *iconURL = [tweet objectForKey:@"profile_image_url"];
  float x = cellFrame.origin.x;
  float y = cellFrame.origin.y;

  NSRect frame = NSMakeRect(x + kProfileImageMargin, 
			    y + kProfileImageMargin,
			    kProfileImageSize, 
			    kProfileImageSize);

  NSImageView *imageView = [[NSImageView alloc] initWithFrame:frame];
  ImageGetter *getter = [[ImageGetter alloc] init];
  [getter startDownloadingImage:iconURL toImageView:imageView];
  [controlView addSubview:imageView];
}

/**
 * @brief セルにツイート本文のフィールドをセットする。
 */
- (void)setTweetFieldForFrame:(NSRect)cellFrame inView:(NSView*)controlView {

  NSString *tweetText = [tweet objectForKey:@"text"];
  NSString *name = [tweet objectForKey:@"from_user"];

  float imageSizeWithMargin = 
    kProfileImageSize + kProfileImageMargin * 2.0f;

  float x = cellFrame.origin.x;
  float y = cellFrame.origin.y;
  float tweetFieldWidth = cellFrame.size.width - imageSizeWithMargin;
  float tweetFieldHeight = [self tweetFieldHeight:tweetText 
				 width:tweetFieldWidth];

  NSRect frame = NSMakeRect(x + imageSizeWithMargin,  y, 
			    tweetFieldWidth, tweetFieldHeight);

  NSTextField *tweetField = [[NSTextField alloc] 
			      initWithFrame:frame];

  tweetField.backgroundColor = [NSColor blackColor];
  [tweetField setEditable:NO];
  [tweetField setBordered:NO];
  [tweetField setStringValue:tweetText];

  NSRect nameFieldFrame = NSMakeRect(x + imageSizeWithMargin, 
				     y + tweetFieldHeight + 5.0f,
				     tweetFieldWidth, 
				     kNamePlateHeight);

  NSTextField *nameField = [[NSTextField alloc] 
			     initWithFrame:nameFieldFrame];

  nameField.backgroundColor = [NSColor blackColor];
  [nameField setEditable:NO];
  [nameField setBordered:NO];
  [nameField setStringValue:((tweet == nil) ? @"" : name)];

  [controlView addSubview:tweetField];
  [controlView addSubview:nameField];
}

@end
