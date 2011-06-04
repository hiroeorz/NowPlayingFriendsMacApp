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

@synthesize profileImageView;
@synthesize nameField;
@synthesize tweet;
@synthesize tweetField;
@synthesize imageGetter;

- (void)dealloc {
  [super dealloc];
}

- (id)initWithTweet:(NSDictionary *)aTweet {

  self = [super init];
  if (self != nil) { 
    self.tweet = aTweet; 
    imageGetter = [[ImageGetter alloc] init];
  }
  return self;
}

- (id)copyWithZone:(NSZone *)zone {

  FriendCell *newCell = [[FriendCell allocWithZone:zone] initWithTweet:tweet];
  newCell.tweetField = nil;
  newCell.nameField = nil;
  newCell.profileImageView = nil;
  newCell.imageGetter = nil;
  return newCell;
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
  float x = cellFrame.origin.x + kProfileImageMargin;
  float y = cellFrame.origin.y + kProfileImageMargin;

  if (profileImageView == nil) {
    NSRect frame = NSMakeRect(x, y, kProfileImageSize, kProfileImageSize);
    self.profileImageView = [[NSImageView alloc] initWithFrame:frame];
    [controlView addSubview:profileImageView];
  } else {
    [profileImageView setFrameOrigin:NSMakePoint(x, y)];
  }
  
  profileImageView.image = nil;
  //[profileImageView display];
  
  [imageGetter cancelDownloading];
  [imageGetter startDownloadingImage:iconURL toImageView:profileImageView];
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

  if (tweetField == nil) {
    NSRect frame = NSMakeRect(x + imageSizeWithMargin,  y, 
			      tweetFieldWidth, tweetFieldHeight);
    self.tweetField = [[NSTextField alloc] initWithFrame:frame];
    tweetField.backgroundColor = [NSColor blackColor];
    [tweetField setEditable:NO];
    [tweetField setBordered:NO];
    [controlView addSubview:tweetField];
  } else {
    [tweetField setFrameOrigin:NSMakePoint(x + imageSizeWithMargin,  y)];
    [tweetField setFrameSize:NSMakeSize(tweetFieldWidth, tweetFieldHeight)];
  }
  [tweetField setStringValue:tweetText];
  [tweetField display];


  if (nameField == nil) {
    NSRect nameFieldFrame = NSMakeRect(x + imageSizeWithMargin, 
				       y + tweetFieldHeight + 5.0f,
				       tweetFieldWidth, 
				       kNamePlateHeight);
    self.nameField = [[NSTextField alloc] initWithFrame:nameFieldFrame];
    nameField.backgroundColor = [NSColor blackColor];
    [nameField setEditable:NO];
    [nameField setBordered:NO];
    [controlView addSubview:nameField];
  } else {
    [nameField setFrameOrigin:NSMakePoint(x + imageSizeWithMargin, 
					  y + tweetFieldHeight + 5.0f)];
  }
  [nameField setStringValue:((tweet == nil) ? @"" : name)];
  [nameField display];
}

@end
