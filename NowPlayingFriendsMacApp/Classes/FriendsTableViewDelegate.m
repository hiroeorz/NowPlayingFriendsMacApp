//
//  FriendsTableViewDelegate.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendsTableViewDelegate.h"

#import "Util.h"


@implementation FriendsTableViewDelegate

@synthesize tweets;
@synthesize friendsTableView;

- (id)init {

  self = [super init];

  if (self) {
    NSNotificationCenter *notificationCenter = 
      [NSNotificationCenter defaultCenter];

    [notificationCenter addObserver:self 
			selector:@selector(refreshTable)
			name:kiTunesTrackChanged object:nil];
    self.tweets = nil;
  }
    
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark

- (void)refreshTable {
  TwitterClient *client = [[TwitterClient alloc] init];
  iTunesTrack *currentTrack = [Util getCurrentTrack];
  NSString *songTitle = [currentTrack name];
  NSString *artistName = [currentTrack artist];
  NSString *tags = kNowPlayingTags;

  self.tweets = [client getSearchTimeLine:songTitle, 
			artistName, tags, nil];
  NSLog(@"tweets: %@", tweets);

  [friendsTableView reloadData];
}

#pragma mark
#pragma TableView Data Source Methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  return [tweets count];
}

- (id)tableView:(NSTableView *)aTableView
    objectValueForTableColumn:(NSTableColumn *)aTableColumn
    row:(NSInteger)rowIndex {

  NSLog(@"identifer: %@", [aTableColumn identifier]);
  NSDictionary *tweet = [tweets objectAtIndex:rowIndex];

  if ([[aTableColumn identifier] isEqualToString:@"TweetTextIdentifier"]) {
    NSString *tweetText = [tweet objectForKey:@"text"];
    return tweetText;
  }

  return @"";
}


#pragma mark
#pragma TableView Delegate Methods


@end
