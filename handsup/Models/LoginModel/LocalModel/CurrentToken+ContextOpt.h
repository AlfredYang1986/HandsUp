//
//  Current+ContextOpt.h
//  handsup
//
//  Created by Alfred Yang on 9/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CurrentToken.h"
#import "LoginToken.h"
#import "SNSConnection.h"
#import "Profile.h"

@interface CurrentToken (ContextOpt)

+ (LoginToken*)enumCurrentLoginUserInContext:(NSManagedObjectContext*)context;
+ (LoginToken*)changeCurrentLoginUser:(LoginToken*)lgt inContext:(NSManagedObjectContext*)context;

+ (LoginToken*)createAndUpdateTokenWithUserID:(NSString*)user_id andAttr:(NSDictionary*)attr inContext:(NSManagedObjectContext*)context;
+ (LoginToken*)enumUserWithUserID:(NSString*)user_id InContext:(NSManagedObjectContext*)context;
+ (SNSConnection*)createAndUpdataSNSWithUserID:(NSString*)user_id andAttr:(NSDictionary*)sns inContext:(NSManagedObjectContext*)context;

+ (Profile*)createAndUpdateProfileWithUserID:(NSString*)user_id andAttr:(NSDictionary*)attr inContext:(NSManagedObjectContext*)context;
@end
