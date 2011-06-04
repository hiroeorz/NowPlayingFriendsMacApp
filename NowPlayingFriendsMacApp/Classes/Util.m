//
//  Util.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Util.h"
#import "FriendCell.h"


@implementation Util

@synthesize iTunes;

- (id)init {
  self = [super init];
  
  if (self) {
    iTunes = [[SBApplication 
		applicationWithBundleIdentifier:@"com.apple.iTunes"] retain];
  }
    
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark
#pragma Class Methods

/*
 * @brief iTunesオブジェクトを返す。
 */
+ (iTunesApplication *)iTunes {
  iTunesApplication *iTunesApp = [SBApplication 
				   applicationWithBundleIdentifier:@"com.apple.iTunes"];
  return iTunesApp;
}

/*
 * @brief 現在再生中の曲のトラックオブジェクトを返す。
 * @example
 *  iTunesTrack *track = [Util getCurrentTrack];
 *  NSString *songTitle = [track name];
 *  NSString *albumTitle = [track album];
 *  NSString *artistName = [track artist];
 */
+ (iTunesTrack *)getCurrentTrack {

  iTunesApplication *iTunesApp = [SBApplication 
				   applicationWithBundleIdentifier:@"com.apple.iTunes"];

  return iTunesApp.currentTrack;
}

/*
 * @brief 与えられた時間、カレントスレッドを停止する。
 */
+ (void)sleep:(float)sec {

  NSDate *date = [[NSDate alloc] init];
  NSDate *nextStartDate = [[NSDate alloc] initWithTimeInterval:sec 
					  sinceDate:date];
  [NSThread sleepUntilDate: nextStartDate];

}

/*
 * @brief iTunesプレーヤが再生中ならYESを返す。
 */
+ (BOOL)iTunesIsPlaying {
  
  iTunesEPlS newPlayState = [[self iTunes] playerState];

  if (newPlayState == iTunesEPlSPlaying) { return YES; } 
  else                                   { return NO;  }
}

/*
 * @brief 与えられた文字列を与えられた幅で表示した場合の高さを返す。
 */
+ (float)heightForString:(NSString *)myString 
		    font:(NSFont *)myFont
		   width:(float)myWidth {

 NSTextStorage *textStorage = [[NSTextStorage alloc] 
				 initWithString:myString];
 NSTextContainer *textContainer = [[NSTextContainer alloc] 
				    initWithContainerSize:
				      NSMakeSize(myWidth, FLT_MAX)];
 
 NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
 [layoutManager addTextContainer:textContainer];
 [textStorage addLayoutManager:layoutManager];
 [textStorage addAttribute:NSFontAttributeName value:myFont
      range:NSMakeRange(0, [textStorage length])];
 [textContainer setLineFragmentPadding:0.0];

 (void) [layoutManager glyphRangeForTextContainer:textContainer];
 return [layoutManager
   usedRectForTextContainer:textContainer].size.height;
}

/**
 * @brief Tweetデータからポストされた日付を返す。
 */
+ (NSDate *)tweetDate:(NSDictionary *)data {

  NSString *dateString = [data objectForKey:@"created_at"];
  NSDate *date = [NSDate dateWithNaturalLanguageString:dateString];

  return date;
}

/**
 * @brief Tweetデータから現在までの経過時間を返す。
 */
+ (NSInteger)secondSinceNow:(NSDictionary *)data {

  NSDate *tweetDate = [Util tweetDate:data];
  NSInteger intervalSec = abs([tweetDate timeIntervalSinceNow]);

  return intervalSec;
}


+ (NSString *)passedTimeString:(NSDictionary *)tweet {

  NSInteger intervalSec = [Util secondSinceNow:tweet];
  NSString *passedString = nil;

  if (intervalSec < 60) {
    passedString = [[NSString alloc] initWithFormat:@"%ds", intervalSec];
  } else if (intervalSec >= 60 && intervalSec < (60 * 60)) {
    passedString = [[NSString alloc] initWithFormat:@"%dm", (intervalSec / 60)];
  } else if (intervalSec >= (60 * 60) && intervalSec < (60 * 60 * 24)) {
    passedString = [[NSString alloc] initWithFormat:@"%dh", (intervalSec / (60 * 60))];
  } else if (intervalSec >= (60 * 60 * 24) && 
	     intervalSec < (60 * 60 * 24 * 30)){
    passedString = [[NSString alloc] initWithFormat:@"%dd", (intervalSec / (60 * 60 * 24))];    
  } else {
    passedString = [[NSString alloc] initWithFormat:@"%dmo", (intervalSec / (60 * 60 * 24 * 30))];    

  }

  return passedString;
}

/**
 * @brief HTMLエスケープされた文字列を通常の文字列に戻した文字列を返す。
 */
+ (NSString *)stringByUnescapedString:(NSString *)str {

  NSDictionary *escapeDictionary = 
    [[NSDictionary alloc] initWithObjectsAndKeys:
			    @"\"", @"&quot;",
			    @">", @"&gt;",
			    @"<", @"&lt;",
			    @"&", @"&amp;",
			  nil];

  NSString *newString = [[[NSString alloc] initWithString:str] autorelease];

  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  for (NSString *key in [escapeDictionary keyEnumerator]) {
    NSString *value = [escapeDictionary objectForKey:key];
    newString = [newString stringByReplacingOccurrencesOfString:key
			   withString:value];
  }

  NSString *replaced = [[NSString alloc] initWithString:newString];
  [pool release];

  [escapeDictionary release];
  return [replaced autorelease];
}

@end
