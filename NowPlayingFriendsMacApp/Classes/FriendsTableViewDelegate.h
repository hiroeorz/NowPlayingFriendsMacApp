//
//  FriendsTableViewDelegate.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterClient.h"
#import "TwitterClient+NowPlaying.h"
#import "iTunes.h"
#import "iTunesStatuses.h"


@interface FriendsTableViewDelegate : NSObject 
<NSTableViewDataSource, NSTableViewDelegate> {

@private
  NSArray *tweets;
  NSTableView *friendsTableView;
}

@property (nonatomic, retain) IBOutlet NSTableView *friendsTableView;
@property (nonatomic, retain) NSArray *tweets;


- (void)refreshTable;

@end
