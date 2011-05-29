//
//  FriendsTableViewDelegate.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendsTableViewDelegate.h"

#import "Util.h"
#import "FriendCell.h"


#define kFriendCellRowHeight 60.0f


@interface FriendsTableViewDelegate (Local)
- (void)setImageCellAttributes;
- (void)setTweetCellAttributes;
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
  [self setImageCellAttributes];
  [self setTweetCellAttributes];
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

  self.tweets = [client getSearchTimeLine:songTitle, 
			artistName, tags, nil];
  //NSLog(@"tweets: %@", tweets);

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
- (id)tableView:(NSTableView *)aTableView
    objectValueForTableColumn:(NSTableColumn *)aTableColumn
    row:(NSInteger)rowIndex {

  NSDictionary *tweet = [tweets objectAtIndex:rowIndex];

  if ([[aTableColumn identifier] isEqualToString:@"TweetTextIdentifier"]) {
    
    FriendCell *cell = [[FriendCell alloc] initWithTweet:tweet];
    //[cell setTwitterInformations];
    return cell;

  } else if ([[aTableColumn identifier] isEqualToString:@"IconImageIdentifier"]) {
    NSString *iconURLStr = [tweet objectForKey:@"profile_image_url"];
    NSURL *iconURL = [[NSURL alloc] initWithString:iconURLStr];
    NSImage *iconImage = [[NSImage alloc] initWithContentsOfURL:iconURL];
    return iconImage;
  }

  return @"";
}

/*
 * @brief テーブルの各行の高さを返す。
 */
- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {

  NSDictionary *tweet = [tweets objectAtIndex:row];
  NSString *tweetText = [tweet objectForKey:@"text"];
  NSFont *font = [NSFont systemFontOfSize:11];

  float height = [Util heightForString:tweetText
		       font:font
		       width:249.0f];

  float namePateHeight = 20.0f;
  height = height + namePateHeight + 6.0f;

  float imageHeight = kFriendCellRowHeight;
  return (height <= imageHeight) ? imageHeight : height;
}

#pragma mark
#pragma TableView Delegate Methods


#pragma mark
#pragma Local Methods

/*
 * @brief ツイッタープロフィール画像セルの為の設定。
 */
- (void)setImageCellAttributes {

  NSTableColumn* imageColumn =
    [friendsTableView tableColumnWithIdentifier:@"IconImageIdentifier"];

  NSImageCell *imageCell = [[NSImageCell alloc] initImageCell:nil];
  [imageCell setImageAlignment:NSImageAlignTopLeft];
  [imageCell setImageScaling:NSImageScaleProportionallyUpOrDown];
  [imageColumn setDataCell:imageCell];

}

/*
 * @brief ツイッター本文表示用セルの設定。
 */
- (void)setTweetCellAttributes {

  NSTableColumn* tweetColumn =
    [friendsTableView tableColumnWithIdentifier:@"TweetTextIdentifier"];

  FriendCell *friendCell = [[FriendCell alloc] init];
  [tweetColumn setDataCell:friendCell];
}


@end
