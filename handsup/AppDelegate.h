//
//  AppDelegate.h
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class HandsUpController;
@class CatchUpController;
@class InfoStationController;

@class LoginModel;
@class HandsUpModel;
@class CatchUpModel;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) MainViewController* mainController;
@property (nonatomic, strong) HandsUpController* handsUpController;
@property (nonatomic, strong) CatchUpController* catchUpController;
@property (nonatomic, strong) InfoStationController* infoStationController;
/**
 * for notification
 */
@property (strong, nonatomic) NSString *apns_token;

@property (strong, nonatomic) LoginModel* lm;
@property (strong, nonatomic) HandsUpModel* hm;
@property (strong, nonatomic) CatchUpModel* cm;

@property (strong, nonatomic) UIWindow *window;
@end

