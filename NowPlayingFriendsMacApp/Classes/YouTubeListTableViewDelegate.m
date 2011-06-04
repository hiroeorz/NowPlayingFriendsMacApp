//
//  YouTubeListTableViewDelegate.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/06/04.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "YouTubeListTableViewDelegate.h"

#import "Util.h"


#define kYouTubeCellRowHeight 80.0f


@implementation YouTubeListTableViewDelegate

@synthesize youtubeList;
@synthesize youtubeTableView;

- (id)init
{
    self = [super init];
    if (self) {
      youtubeList = nil;
      youtubeTableView = nil;
    }
    
    return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark

/*
 * @brief ビューの準備が整った時に呼ばれる。
 */
- (void)awakeFromNib {
  [youtubeTableView setRowHeight:kYouTubeCellRowHeight];

  NSTableColumn *tableColumn = 
    [youtubeTableView tableColumnWithIdentifier:@"YouTubeThumbnailImage"];

  NSImageCell *imageCell = [[NSImageCell alloc] init];
  [imageCell setImageScaling:NSImageScaleAxesIndependently];

  [imageCell setImageAlignment:NSImageAlignTopLeft];
  [tableColumn setDataCell:imageCell];
}

#pragma mark

/*
 * @brief 引数として渡されたYouTube動画の検索結果でテーブルを再描画する。
 */
- (void)refreshTable:(NSArray *)searchResults {

  self.youtubeList = searchResults;
  [youtubeTableView reloadData];
}

#pragma mark
#pragma TableView Data Source Methods

/*
 * @brief テーブルの行数を返す。
 */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView {
  return [youtubeList count];
}

- (id)tableView:(NSTableView *)tableView
    objectValueForTableColumn:(NSTableColumn *)tableColumn
    row:(NSInteger)row {

  NSDictionary *movie = [youtubeList objectAtIndex:row];

  if ([[tableColumn identifier] isEqualToString:@"YouTubeInformationText"]) {
    return [self movieFieldTextBody:row];
  } else {
    NSURL *url = [[NSURL alloc] initWithString:
				  [movie objectForKey:@"thumbnailUrl"]];
    NSImage *profileImage = [[NSImage alloc] initWithContentsOfURL:url];
    return profileImage;
  }

  return @"";
}

/**
 * YouTube動画の情報を整形した文字列を返す。
 */
- (NSString *)movieFieldTextBody:(NSInteger)row {

  NSDictionary *movie = [youtubeList objectAtIndex:row];
  NSString *title = 
    [Util stringByUnescapedString:[movie objectForKey:@"contentTitle"]];
  NSString *name = 
    [Util stringByUnescapedString:[movie objectForKey:@"name"]];

  return [[NSString alloc] initWithFormat:@"%@\n\n\n  by  %@",
			   title, name];
}

@end
