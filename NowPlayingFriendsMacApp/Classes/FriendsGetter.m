//
//  FriendsGetter.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendsGetter.h"

#import "ImageGetter.h"
#import "TwitterClient.h"
#import "Util.h"
#import "iTunes.h"
#import "iTunesStatuses.h"


@interface FriendsGetter (Local)
- (void)getSongTimelineWhenTrackChangedDetail;
@end


@implementation FriendsGetter

@synthesize panel;

- (id)init {
  self = [super init];
  if (self) {
  }
  
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark

/*
 * @brief 曲が切り替わったら検索APIからタイムラインを取得するように登録する。
 */
- (void)setNotification {

  NSNotificationCenter *notificationCenter = 
    [NSNotificationCenter defaultCenter];
  
  [notificationCenter 
    addObserver:self 
    selector:@selector(getSongTimelineWhenTrackChanged)
    name:kiTunesTrackChanged object:nil];
}

/*
 * @brief getSongTimelineWhenTrackChangedDetailを強制的にメインスレッドで実行
 */
- (void)getSongTimelineWhenTrackChanged {

  [self performSelectorOnMainThread:
	  @selector(getSongTimelineWhenTrackChangedDetail)
	withObject:nil
	waitUntilDone:YES];
}

/*
 * @brief APIから同じ曲を聴いている人を検索して新規のウインドウで表示する。
 */
- (void)getSongTimelineWhenTrackChangedDetail {

  TwitterClient *client = [[TwitterClient alloc] init];

  iTunesTrack *currentTrack = [Util getCurrentTrack];
  NSString *songTitle = [currentTrack name];
  NSString *artistName = [currentTrack artist];

  NSString *tags = kNowPlayingTags;
  NSArray *searchResult = [client getSearchTimeLine:songTitle, 
				  artistName, tags, nil];
  NSLog(@"searchResult: %@", searchResult);

  if ([searchResult count] > 0) {
    NSDictionary *tweet = [searchResult objectAtIndex:0];
    
    self.panel = [self createUserPanelWithPositionX:2.0f positionY:2.0f
		       width:340.0f height:100.0f
		       alpha:0.85f
		       tweet:tweet];
    [panel orderFront:self];
  } else {
    NSLog(@"search result is not exist.");
    if (panel != nil) { [panel close]; self.panel = nil; }
  }
}

/*
 * @brief 受け取ったツイートから同じ曲を聴いている人を表示するウインドウを生成する
 */
- (NSPanel *)createUserPanelWithPositionX:(float)x positionY:(float)y
				    width:(float)width height:(float)height
				    alpha:(float)alpha
				    tweet:(NSDictionary *)tweet {

  if (panel != nil) { [panel close]; self.panel = nil; }

  NSPanel *newPanel = [[NSPanel alloc]
			initWithContentRect: NSMakeRect(x, y, width, height)
			styleMask: (NSClosableWindowMask | NSTitledWindowMask | NSTexturedBackgroundWindowMask )
			backing: NSBackingStoreBuffered
			defer: YES];
  
  newPanel.backgroundColor = [NSColor blackColor];
  newPanel.alphaValue = alpha;
  newPanel.hidesOnDeactivate = NO;
  [newPanel setMovable:YES];
  [newPanel setFloatingPanel:YES];

  NSView *view = [[NSView alloc] 
		   initWithFrame:NSMakeRect(0.0f, 0.0f, 340.0f, 100.0f)];

  NSButton *button = [[NSButton alloc] 
			initWithFrame:NSMakeRect(10.0f, 30.0f, 60.0f, 60.0f)];

  [view addSubview:button];
  ImageGetter *imageGetter = [[ImageGetter alloc] init];
  [imageGetter startDownloadingImage:[tweet objectForKey:@"profile_image_url"]
	       toImageView:button];


  NSTextField *tweetField = [[NSTextField alloc] 
			      initWithFrame:NSMakeRect(75.0f, 15.0f, 255.0f, 75.0f)];
  tweetField.backgroundColor = [NSColor blackColor];
  [tweetField setEditable:NO];
  [tweetField setBordered:NO];
  [tweetField setStringValue:[tweet objectForKey:@"text"]];

  [view addSubview:tweetField];
  [newPanel setContentView:view];

  return newPanel;
}

@end
