//
//  ImageGetter.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageGetter : NSOperation {
@private
  NSMutableData *imageData;
  NSString *url;
  id imageView;
}

@property (nonatomic, retain) NSMutableData *imageData;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) id imageView;


- (void)startDownloadingImage:(NSString *)aUrl 
		  toImageView:(id)aImageView;

@end
