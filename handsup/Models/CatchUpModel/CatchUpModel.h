//
//  CatchUpModel.h
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AppDelegate;

typedef void(^queryEventsFinishBlock)(BOOL success, NSArray* result, NSString* error);

@interface CatchUpModel : NSObject
@property (nonatomic, strong) UIManagedDocument* doc;
@property (nonatomic, strong) NSArray* queryData;
@property (nonatomic, weak) AppDelegate* delegate;

- (id)initWithAppDelegate:(AppDelegate *)app;

- (void)queryCatchUpEventAsyncWithUserID:(NSString*)user_id andAuthToken:(NSString*)auth_token AndBlock:(queryEventsFinishBlock)block;
- (NSArray*)enumAllCatchUpEventWithUserID:(NSString*)user_id;

- (BOOL)user:(NSString*)user_id withToken:(NSString*)auth_token catchUpEvent:(NSString*)event_id;
@end
