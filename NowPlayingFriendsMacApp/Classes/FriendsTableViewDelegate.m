//
//  FriendsTableViewDelegate.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendsTableViewDelegate.h"

#import "Util.h"


#define kFriendCellRowHeight 35.0f
#define kFriendFieldWidth 311.0f
#define kUserNameFieldHeight 20
#define kUserProfileImageWidth 50

@interface FriendsTableViewDelegate (Local)
@end


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

/*
 * @brief ビューの準備が整った時に呼ばれる。
 */
- (void)awakeFromNib {
  [friendsTableView setRowHeight:kFriendCellRowHeight];

  NSTableColumn *tableColumn = [friendsTableView 
				 tableColumnWithIdentifier:@"ProfileImageView"];
  NSImageCell *imageCell = [[NSImageCell alloc] init];
  [imageCell setImageScaling:NSImageScaleProportionallyUpOrDown];
  [imageCell setImageAlignment:NSImageAlignTop];
  [tableColumn setDataCell:imageCell];
}

#pragma mark

/*
 * @brief 現在の曲に関連するタイムラインを再取得してテーブルを再描画する。
 */
- (void)refreshTable {
  TwitterClient *client = [[TwitterClient alloc] init];
  iTunesTrack *currentTrack = [Util getCurrentTrack];

  NSString *songTitle = [currentTrack name];
  NSString *artistName = [currentTrack artist];
  NSString *tags = kNowPlayingTags;

  if (songTitle != nil && ![songTitle isEqualToString:@""]) {
    self.tweets = [client getSearchTimeLine:songTitle, 
			  artistName, tags, nil];
  } else {
    self.tweets = nil;
  }

  [friendsTableView reloadData];
}

#pragma mark
#pragma TableView Data Source Methods

/*
 * @brief テーブルの行数を返す。
 */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  return [tweets count];
}

/*
 * @brief テーブルの内容を返す。
 */
- (id)tableView:(NSTableView *)tableView
    objectValueForTableColumn:(NSTableColumn *)tableColumn
    row:(NSInteger)row {

  NSDictionary *tweet = [tweets objectAtIndex:row];

  if ([[tableColumn identifier] isEqualToString:@"TweetTextIdentifier"]) {
    return [self tweetFieldTextBody:row];
  } else {
    NSURL *url = [[NSURL alloc] initWithString:
				  [tweet objectForKey:@"profile_image_url"]];
    NSImage *profileImage = [[NSImage alloc] initWithContentsOfURL:url];
    return profileImage;
  }

  return @"";
}

/**
 * ツイートの本文に日付や送信元の情報を追加した文字列を返す。
 */
- (NSString *)tweetFieldTextBody:(NSInteger)row {

  NSDictionary *tweet = [tweets objectAtIndex:row];
  NSString *unescapedBody = 
    [Util stringByUnescapedString:[tweet objectForKey:@"text"]];

  NSString *passedTimeString = [Util passedTimeString:tweet];

  return [[NSString alloc] initWithFormat:@"%@\n\n %@  by  %@",
			   unescapedBody,
			   passedTimeString,
			   [tweet objectForKey:@"from_user"]];
}

/*
 * @brief テーブルの各行の高さを返す。
 */
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {

  NSString *tweetTextBody = [self tweetFieldTextBody:row];
  NSFont *font = [NSFont systemFontOfSize:12];
  
  float width = tableView.frame.size.width - kUserProfileImageWidth;
  float height = [Util heightForString:tweetTextBody
		       font:font width:width];
  
  if (height >= kUserProfileImageWidth) {
    return height;
  } else {
    return kUserProfileImageWidth;
  }
}

#pragma mark
#pragma TableView Delegate Methods


#pragma mark
#pragma Local Methods

@end
