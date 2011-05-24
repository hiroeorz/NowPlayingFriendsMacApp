//
//  TwitterAuthenticateController.h
//  NowPlayingFriendsMacApp
//
//  Created by Hiroe Shin on 11/05/24.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class OAServiceTicket;


@interface TwitterAuthenticateController : NSObject {
@private
  NSTextField *userNameField;
  NSTextField *passwordField;
}

@property (nonatomic, retain) IBOutlet NSTextField *userNameField;
@property (nonatomic, retain) IBOutlet NSTextField *passwordField;

- (IBAction)authenticate:(id)sender;

@end
