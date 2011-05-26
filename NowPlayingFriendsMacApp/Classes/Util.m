//
//  Util.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"


@implementation Util

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
#pragma Class Methods

+ (NSPanel *)createUserPanelWithPositionX:(float)x positionY:(float)y
				    width:(float)width height:(float)height
				    alpha:(float)alpha {

  NSPanel* panel = [[NSPanel alloc]
		     initWithContentRect: NSMakeRect(x, y, width, height)
		     styleMask: (NSClosableWindowMask | NSTitledWindowMask | NSTexturedBackgroundWindowMask )
		     backing: NSBackingStoreBuffered
		     defer: YES];
  
  panel.backgroundColor = [NSColor blackColor];
  panel.alphaValue = alpha;
  [panel setMovable:YES];

  NSView *view = [[NSView alloc] 
		   initWithFrame:NSMakeRect(0.0f, 0.0f, 320.0f, 100.0f)];

  NSButton *button = [[NSButton alloc] 
			initWithFrame:NSMakeRect(10.0f, 30.0f, 60.0f, 60.0f)];
  NSImage *image = [NSImage imageNamed:@"friends2_wide305.png"];
  [image setSize:NSMakeSize(60.0f, 60.0f)];
  [button setImage:image];

  [view addSubview:button];
  [panel setContentView:view];

  return panel;
}

@end
