//
//  ImageGetter.m
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageGetter.h"


@implementation ImageGetter

@synthesize cancelFlag;
@synthesize imageData;
@synthesize imageView;
@synthesize url;

- (id)init {

  self = [super init];

  if (self) {
    imageData = nil;
    url = nil;
    imageView = nil;
  }
    
  return self;
}

- (void)dealloc {
  [super dealloc];
}

#pragma mark
#pragma Image Get Methods

- (void)startDownloadingImage:(NSString *)aUrl 
		  toImageView:(id)aImageView {

  self.imageData = [[NSMutableData alloc] init];
  self.url = aUrl;
  self.imageView = aImageView;

  NSURLRequest *request = 
    [NSURLRequest requestWithURL:[NSURL URLWithString:aUrl]];
  [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -
#pragma NSURLConnection Delegate Methods

- (void)cancelDownloading {
  
  cancelFlag = YES;
  self.imageData = nil;
  [self cancel];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *) data {
  if (cancelFlag) { 
    [self cancel];
    self.imageData = nil;
  }
  [imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  
  NSImage *newImage = [[NSImage alloc] initWithData:imageData];
  [newImage setSize:NSMakeSize(60.0f, 60.0f)];
  [imageView setImage:newImage];

  self.imageData = nil;
}

-(void)connection:(NSURLConnection*)connection 
 didFailWithError:(NSError*)error {

  NSLog(@"Connection Error While getting profile image");

  NSImage *image = [NSImage imageNamed:@"friends2_wide305.png"];
  [image setSize:NSMakeSize(60.0f, 60.0f)];
  [imageView setImage:image];
}


@end
