//
//  FriendCell.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendCell.h"

#import "Util.h"


@implementation FriendCell

@synthesize tweet;
@synthesize fromUser;


- (void)dealloc {
  [super dealloc];
}

- (id)initWithTweet:(NSDictionary *)aTweet {

  self = [super init];

  if (self != nil) {
    self.tweet = [aTweet retain];
    self.fromUser = [tweet objectForKey:@"from_user"];
    [self setStringValue:[tweet objectForKey:@"text"]];
  }

  return self;
}

/*
- (id)copyWithZone:(NSZone*)zone {

  FriendCell *newCell = [[[self class] allocWithZone:zone] init];
  
  newCell.tweet = self.tweet;
  newCell.fromUser = self.fromUser;
  [newCell setStringValue:[self stringValue]];

  return newCell;
}
*/

- (void)setTwitterInformations {

  NSString *tweetText = [self stringValue];
  NSFont *font = [NSFont systemFontOfSize:11];

  float x = myCellFrame.origin.x;
  float y = myCellFrame.origin.y;
  float height = [Util heightForString:tweetText
		       font:font
		       width:249.0f];

  NSTextField *tweetField = [[NSTextField alloc] 
			      initWithFrame:myCellFrame];

  tweetField.backgroundColor = [NSColor blackColor];
  [tweetField setEditable:NO];
  [tweetField setBordered:NO];
  [tweetField setStringValue:tweetText];

  //[myControlView addSubview:tweetField];

  NSTextField *nameField = [[NSTextField alloc] 
			     initWithFrame:
			       NSMakeRect(x + 20.0f, 
					  y + height + 5.0f,
					  249.0f, 20.0f)];

  nameField.backgroundColor = [NSColor blackColor];
  [nameField setEditable:NO];
  [nameField setBordered:NO];

  if (tweet == nil) {
    [nameField setStringValue:@""];
  } else {
    [nameField setStringValue:@"hiroe"];
  }

  [myControlView addSubview:nameField];
}

- (void)drawWithFrame:(NSRect)myCellFrame inView:(NSView *)controlView {
  myCellFrame = myCellFrame;
  myControlView = controlView;
  [super drawWithFrame:myCellFrame inView:controlView];
}

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView*)controlView {
  NSLog(@"helo world2!: %@", tweet);
  NSLog(@"tweet: %@", [tweet objectForKey:@"from_user"]);

    
  NSString *tweetText = [self stringValue];
  NSFont *font = [NSFont systemFontOfSize:11];

  float x = cellFrame.origin.x;
  float y = cellFrame.origin.y;
  float height = [Util heightForString:tweetText
		       font:font
		       width:249.0f];

  NSTextField *tweetField = [[NSTextField alloc] 
			      initWithFrame:cellFrame];

  tweetField.backgroundColor = [NSColor blackColor];
  [tweetField setEditable:NO];
  [tweetField setBordered:NO];
  [tweetField setStringValue:tweetText];

  [controlView addSubview:tweetField];

  NSTextField *nameField = [[NSTextField alloc] 
			     initWithFrame:
			       NSMakeRect(x + 20.0f, 
					  y + height + 5.0f,
					  249.0f, 20.0f)];

  nameField.backgroundColor = [NSColor blackColor];
  [nameField setEditable:NO];
  [nameField setBordered:NO];

  if (tweet == nil) {
    [nameField setStringValue:@""];
  } else {
    [nameField setStringValue:@"hiroe"];
  }

  [controlView addSubview:nameField];
  
  //[super drawInteriorWithFrame:cellFrame inView:controlView];
}

@end
