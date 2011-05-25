//
//  MusicPlayerController.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


#define kMaxTweetLength 140
#define kProfileImageDirectory @"profileImages"
#define kYouTubeThumbnailDirectory @"youtubeThumbnails"
#define kProfileImageMaxFileCacheCount 1024
#define kProfileImageMaxMemoryCacheCount 10
#define KNowPlayingTags @"nowplaying OR nowlistening OR twitmusic OR BGM";
#define kNoArtWorkImage @"no_artwork_image.png"

#define kSelectYouTubeTypeTopOfSerach 0
#define kSelectYouTubeTypeSelectFromList 1
#define kSelectYouTubeTypeConfirmation 2

@class iTunesApplication;
@class NowPlayingFriendsMacAppAppDelegate;
@class TwitterSendController;
@class MusicPlayerStateWatcher;


@interface MusicPlayerController : NSObject {
@private
  MusicPlayerStateWatcher *watcher;
  NSButton *albumSelectButton;
  NSImageView *artworkImageView;
  NSNotificationCenter *notificationCenter;
  NSSegmentedControl *musicSegmentedControl;
  NSSegmentedControl *repeatSegmentedControl;
  NSSegmentedControl *shuffleSegmentedControl;
  NSSlider *positionSlider;
  NSSlider *volumeSlider;
  NSTextField *albumTitleTextField;
  NSTextField *artistNameTextField;
  NSTextField *tweetEditField;
  NSWindow *authWindow;
  NSWindow *tweetWindow;
  iTunesApplication *iTunes;
}

@property (assign) IBOutlet NSWindow *authWindow;
@property (assign) IBOutlet NSWindow *tweetWindow;
@property (nonatomic, retain)  MusicPlayerStateWatcher *watcher;
@property (nonatomic, retain) IBOutlet NSButton *albumSelectButton;
@property (nonatomic, retain) IBOutlet NSImageView *artworkImageView;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *musicSegmentedControl;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *repeatSegmentedControl;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *shuffleSegmentedControl;
@property (nonatomic, retain) IBOutlet NSSlider *positionSlider;
@property (nonatomic, retain) IBOutlet NSSlider *volumeSlider;
@property (nonatomic, retain) IBOutlet NSTextField *albumTitleTextField;
@property (nonatomic, retain) IBOutlet NSTextField *artistNameTextField;
@property (nonatomic, retain) IBOutlet NSTextField *tweetEditField;
@property (nonatomic, retain) iTunesApplication *iTunes;
@property (nonatomic, retain, readonly) NSNotificationCenter *notificationCenter;
@property (nonatomic, retain, readonly) NowPlayingFriendsMacAppAppDelegate *appDelegate;



- (IBAction)playerControlButtonClicked:(id)sender;
- (IBAction)backTrack:(id)sender;
- (IBAction)fastForward:(id)sender;
- (IBAction)togglePlayStop:(id)sender;
- (IBAction)nextTrack:(id)sender;

- (IBAction)setVolume:(id)sender;
- (IBAction)setPosition:(id)sender;
- (IBAction)setShuffle:(id)sender;
- (IBAction)setRepeat:(id)sender;

- (void)updateViewsWhenStateChange;

@end
