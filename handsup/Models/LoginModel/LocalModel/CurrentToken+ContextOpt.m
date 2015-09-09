//
//  Current+ContextOpt.m
//  handsup
//
//  Created by Alfred Yang on 9/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "CurrentToken+ContextOpt.h"

@implementation CurrentToken (ContextOpt)

+ (LoginToken*)enumCurrentLoginUserInContext:(NSManagedObjectContext*)context {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"CurrentToken"];
    
    NSError* error = nil;
    NSArray* matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || matches.count > 1) {
        NSLog(@"should have one and only one current user");
        return nil;
    } else if (matches.count == 1) {
        CurrentToken* tmp = [matches lastObject];
//        if ([tmp.who.user_id isEqualToString:lgt.user_id]) {
//            tmp.last_login_data = [NSDate date];
//            tmp.status = [NSNumber numberWithInt:1]; // 1 => online
//        } else {
//            tmp.who = lgt;
//            tmp.status = [NSNumber numberWithInt:1]; // 1 => online
//        }
//        [context save:nil];
        return tmp.who;
    } else {
        NSLog(@"nothing need to be delected");
        CurrentToken* tmp = [NSEntityDescription insertNewObjectForEntityForName:@"CurrentToken" inManagedObjectContext:context];
//        tmp.last_login_data = [NSDate date];
//        tmp.who = lgt;
//        tmp.status = [NSNumber numberWithInt:1]; // 1 => online
//        [context save:nil];
        return tmp.who;
    }
}

+ (LoginToken*)changeCurrentLoginUser:(LoginToken*)lgt inContext:(NSManagedObjectContext*)context {
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"CurrentToken"];
    
    NSError* error = nil;
    NSArray* matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || matches.count > 1) {
        NSLog(@"should have one and only one current user");
        return nil;
    } else if (matches.count == 1) {
        CurrentToken* tmp = [matches lastObject];
        if ([tmp.who.user_id isEqualToString:lgt.user_id]) {
//            tmp.last_login_data = [NSDate date];
//            tmp.status = [NSNumber numberWithInt:1]; // 1 => online
        } else {
            tmp.who = lgt;
//            tmp.status = [NSNumber numberWithInt:1]; // 1 => online
        }
        [context save:nil];
        return tmp.who;
    } else {
        NSLog(@"nothing need to be delected");
        CurrentToken* tmp = [NSEntityDescription insertNewObjectForEntityForName:@"CurrentToken" inManagedObjectContext:context];
//        tmp.last_login_data = [NSDate date];
        tmp.who = lgt;
//        tmp.status = [NSNumber numberWithInt:1]; // 1 => online
        [context save:nil];
        return tmp.who;
    }
}
@end
