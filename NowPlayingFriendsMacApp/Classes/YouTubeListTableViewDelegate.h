//
//  YouTubeListTableViewDelegate.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/06/04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YouTubeListTableViewDelegate : NSObject
<NSTableViewDataSource, NSTableViewDelegate> {

@private
  NSArray *youtubeList;
  NSTableView *youtubeTableView;    
}

@property (nonatomic, retain) IBOutlet NSTableView *youtubeTableView;
@property (nonatomic, retain) NSArray *youtubeList;

- (void)refreshTableCallFromMainThread;
- (void)refreshTable;
- (void)refreshTable:(NSArray *)searchResults;

@end
