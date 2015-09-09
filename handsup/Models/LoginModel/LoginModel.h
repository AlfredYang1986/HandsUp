//
//  LoginModel.h
//  handsup
//
//  Created by Alfred Yang on 9/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
// SDKs
#import "WeiboSDK.h"
//#import "WXApi.h"
//#import "TencentOAuth.h"

@class WeiboUser;
@class AppDelegate;
@class CurrentToken;
@class LoginToken;

@interface LoginModel : NSObject <WeiboSDKDelegate>

@property (nonatomic, strong) UIManagedDocument* doc;
@property (nonatomic, weak) AppDelegate * delegate;
@property (nonatomic, strong, readonly, getter=queryCurrentUser) LoginToken* current_user;

- (id)initWithAppDelegate:(AppDelegate*)app;

- (void)loginWithWeibo;

- (BOOL)hasLogin;
- (LoginToken*)queryCurrentUser;
@end
