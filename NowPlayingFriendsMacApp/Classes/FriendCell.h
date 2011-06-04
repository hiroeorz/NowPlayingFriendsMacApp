//
//  FriendCell.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


#define kProfileImageSize 35.0f
#define kProfileImageMargin 5.0f
#define kNamePlateHeight 20.0f


@class ImageGetter;


@interface FriendCell : NSActionCell {
@private
  ImageGetter *imageGetter;
  NSDictionary *tweet;
  NSImageView *profileImageView;
  NSTextField *nameField;
  NSTextField *tweetField;
}


@property (nonatomic, copy) NSDictionary *tweet;
@property (nonatomic, retain) ImageGetter *imageGetter;
@property (nonatomic, retain) NSImageView *profileImageView;
@property (nonatomic, retain) NSTextField *nameField;
@property (nonatomic, retain) NSTextField *tweetField;


- (id)initWithTweet:(NSDictionary *)aTweet;
- (float)tweetFieldHeight:(NSString *)tweetText width:(float)width;
- (void)setProfileImageForFrame:(NSRect)cellFrame inView:(NSView*)controlView;

@end
