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

@interface FriendCell : NSActionCell {
@private
  NSDictionary *tweet;
}


@property (nonatomic, copy) NSDictionary *tweet;


- (id)initWithTweet:(NSDictionary *)aTweet;
- (float)tweetFieldHeight:(NSString *)tweetText width:(float)width;
- (void)setProfileImageForFrame:(NSRect)cellFrame inView:(NSView*)controlView;

@end
