//
//  FriendCell.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FriendCell : NSCell {
@private
  NSDictionary *tweet;
  NSString *fromUser;
  NSRect myCellFrame;
  NSView *myControlView;
}

@property (nonatomic, retain) NSDictionary *tweet;
@property (nonatomic, retain) NSString *fromUser;


- (void)setTwitterInformations;

@end
