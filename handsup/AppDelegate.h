//
//  AppDelegate.h
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class HandsUpController;
@class CatchUpController;
@class InfoStationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) ViewController* mainController;
@property (nonatomic, strong) HandsUpController* handsUpController;
@property (nonatomic, strong) CatchUpController* catchUpController;
@property (nonatomic, strong) InfoStationController* infoStationController;
/**
 * for notification
 */
@property (strong, nonatomic) NSString *apns_token;

@property (strong, nonatomic) UIWindow *window;
@end

