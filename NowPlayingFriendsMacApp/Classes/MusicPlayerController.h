//
//  MusicPlayerController.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/23.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class iTunesApplication;
@class NowPlayingFriendsMacAppAppDelegate;

@interface MusicPlayerController : NSObject {
@private
  NSButton *albumSelectButton;
  NSSegmentedControl *musicSegmentedControl;
  NSSegmentedControl *repeatSegmentedControl;
  NSSegmentedControl *shuffleSegmentedControl;
  NSSlider *positionSlider;
  NSSlider *volumeSlider;
  iTunesApplication *iTunes;
  NSTextField *albumTitleTextField;
  NSTextField *artistNameTextField;
}

@property (nonatomic, retain) IBOutlet NSTextField *albumTitleTextField;
@property (nonatomic, retain) IBOutlet NSTextField *artistNameTextField;
@property (nonatomic, retain) IBOutlet NSButton *albumSelectButton;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *musicSegmentedControl;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *repeatSegmentedControl;
@property (nonatomic, retain) IBOutlet NSSegmentedControl *shuffleSegmentedControl;
@property (nonatomic, retain) IBOutlet NSSlider *positionSlider;
@property (nonatomic, retain) IBOutlet NSSlider *volumeSlider;
@property (nonatomic, retain) iTunesApplication *iTunes;
@property (nonatomic, retain, readonly) NowPlayingFriendsMacAppAppDelegate *appDelegate;

- (IBAction)backTrack:(id)sender;
- (IBAction)fastForward:(id)sender;
- (IBAction)togglePlayStop:(id)sender;
- (IBAction)nextTrack:(id)sender;

- (void)updateViewsWhenStateChange;

@end
