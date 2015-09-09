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

@interface CurrentToken (ContextOpt)

+ (LoginToken*)enumCurrentLoginUserInContext:(NSManagedObjectContext*)context;
+ (LoginToken*)changeCurrentLoginUser:(LoginToken*)lgt inContext:(NSManagedObjectContext*)context;
@end
