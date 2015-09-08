//
//  AppDelegate.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "AppDelegate.h"

#import "MainViewController.h"
#import "InfoStationController.h"
#import "HandsUpController.h"
#import "CatchUpController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate

@synthesize mainController = _mainController;
@synthesize handsUpController = _handsUpController;
@synthesize catchUpController = _catchUpController;
@synthesize infoStationController = _infoStationController;

@synthesize apns_token = _apns_token;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**
     * Notification
     */
    //1.创建消息上面要添加的动作(按钮的形式显示出来)
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = @"action";//按钮的标示
    action.title=@"Accept";//按钮的标题
    action.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
    //    action.authenticationRequired = YES;
    //    action.destructive = YES;
    
    UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
    action2.identifier = @"action2";
    action2.title=@"Reject";
    action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
    action.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    action.destructive = YES;
    
    //2.创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";//这组动作的唯一标示,推送通知的时候也是根据这个来区分
    [categorys setActions:@[action,action2] forContext:(UIUserNotificationActionContextMinimal)];
    
    //3.创建UIUserNotificationSettings，并设置消息的显示类类型
    UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notiSettings];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

#pragma mark -- notification callback
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    //    UIUserNotificationSettings *settings = [application currentUserNotificationSettings];
    //    UIUserNotificationType types = [settings types];
    //    //只有5跟7的时候包含了 UIUserNotificationTypeBadge
    //    if (types == 5 || types == 7) {
    //        application.applicationIconBadgeNumber = 0;
    //    }
    //注册远程通知
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    _apns_token = [NSString stringWithFormat:@"%@",(NSString*)deviceToken];
    _apns_token = [_apns_token stringByReplacingOccurrencesOfString:@" " withString:@""];
    _apns_token = [_apns_token lowercaseString];
    _apns_token = [_apns_token substringToIndex:_apns_token.length-1];
    _apns_token = [_apns_token substringFromIndex:1];
    NSLog(@"My token is: %@", _apns_token);
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error {
    NSLog(@"Failed to get token, error: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"didReceiveRemoteNotification : %@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}
@end
