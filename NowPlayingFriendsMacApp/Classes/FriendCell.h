//
//  FriendCell.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


@interface FriendCell : NSActionCell {
@private
  NSDictionary *tweet;
}


@property (nonatomic, copy) NSDictionary *tweet;


- (id)initWithTweet:(NSDictionary *)aTweet;

@end
