//
//  HandsUpModel.h
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AppDelegate;

typedef void(^queryEventsFinishBlock)(BOOL success, NSArray* result, NSString* error);

@interface HandsUpModel : NSObject

@property (nonatomic, strong) UIManagedDocument* doc;
@property (nonatomic, strong) NSArray* queryData;
@property (nonatomic, weak) AppDelegate* delegate;

- (id)initWithAppDelegate:(AppDelegate *)app;

- (void)queryHandsUpEventAsyncWithUserID:(NSString*)user_id andAuthToken:(NSString*)auth_token AndBlock:(queryEventsFinishBlock)block;
- (NSArray*)enumAllHandsUpEventWithUserID:(NSString*)user_id;
- (NSArray*)enumMyEventsLocalWithUserID:(NSString*)user_id;
- (NSArray*)enumOtherEventsLocalWithUserID:(NSString*)user_id;

- (BOOL)user:(NSString*)user_id withToken:(NSString*)auth_token postHandsUpEvent:(NSDictionary*)attr;

@end
