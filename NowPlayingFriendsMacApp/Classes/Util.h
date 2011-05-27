//
//  Util.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iTunes.h"


@interface Util : NSObject {
@private
  iTunesApplication *iTunes;
}

@property (nonatomic, retain) iTunesApplication *iTunes;


+ (iTunesTrack *)getCurrentTrack;

@end