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

+ (LoginToken*)createAndUpdateTokenWithUserID:(NSString*)user_id andAttr:(NSDictionary*)attr inContext:(NSManagedObjectContext*)context {

    LoginToken* tmp = [self enumUserWithUserID:user_id InContext:context];

    if (tmp == nil) {
        tmp = [NSEntityDescription insertNewObjectForEntityForName:@"LoginToken" inManagedObjectContext:context];
        tmp.user_id = user_id;
    }
   
    tmp.auth_token = [attr objectForKey:@"auth_token"];
    

    
    return tmp;
}

+ (LoginToken*)enumUserWithUserID:(NSString*)user_id InContext:(NSManagedObjectContext*)context {
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"LoginToken"];
    request.predicate = [NSPredicate predicateWithFormat:@"user_id=%@", user_id];
    
    NSError* error = nil;
    NSArray* matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || matches.count > 1) {
        NSLog(@"should have one and only one current user");
        return nil;
    } else if (matches.count == 1) {
        return [matches lastObject];
    } else {
        NSLog(@"nothing need to be delected");
        return nil;
    }
}

+ (SNSConnection*)createAndUpdataSNSWithUserID:(NSString*)user_id andAttr:(NSDictionary*)sns inContext:(NSManagedObjectContext*)context {

    LoginToken* tmp = [self enumUserWithUserID:user_id InContext:context];
  
    if (tmp == nil) {
        return nil;
    }
    
    NSString* provider_name = [sns objectForKey:@"provider_name"];
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"provider_name=%@", provider_name];
    NSArray* arr = [tmp.connectWith.allObjects filteredArrayUsingPredicate:pred];
   
    SNSConnection* s = nil;
    if (arr.count == 0) {
        s = [NSEntityDescription insertNewObjectForEntityForName:@"SNSConnection" inManagedObjectContext:context];
        s.who = tmp;
        [tmp addConnectWithObject:s];
    } else {
        s = [arr firstObject];
    }
    
    // TODO: add sns to new sns
    if ([sns.allKeys containsObject:@"provider_name"]) {
        s.provider_name = [sns objectForKey:@"provider_name"];
    } else if ([sns.allKeys containsObject:@"provider_refresh_token"]) {
        s.provider_refresh_token = [sns objectForKey:@"provider_refresh_token"];
    } else if ([sns.allKeys containsObject:@"provider_open_id"]) {
        s.provider_open_id = [sns objectForKey:@"provider_open_id"];
    } else if ([sns.allKeys containsObject:@"provider_auth_token"]) {
        s.provider_auth_token = [sns objectForKey:@"provider_auth_token"];
    }
    
    return s;
}

+ (Profile*)createAndUpdateProfileWithUserID:(NSString*)user_id andAttr:(NSDictionary*)attr inContext:(NSManagedObjectContext*)context {
    
    LoginToken* tmp = [self enumUserWithUserID:user_id InContext:context];
  
    if (tmp == nil) {
        return nil;
    }
   
    Profile* p = tmp.profile;
    if (p == nil) {
        p = [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:context];
        p.who = tmp;
        tmp.profile = p;
    }
    
    NSDictionary* user_profile = [attr objectForKey:@"profile"];
    if ([user_profile.allKeys containsObject:@"screen_name"]) {
        p.screen_name = [user_profile objectForKey:@"screen_name"];
    } else if ([user_profile.allKeys containsObject:@"screen_photo"]) {
        p.screen_photo = [user_profile objectForKey:@"screen_photo"];
    } else if ([user_profile.allKeys containsObject:@"school"]) {
        p.school = [user_profile objectForKey:@"school"];
    } else if ([user_profile.allKeys containsObject:@"deciplline"]) {
        p.decipline = [user_profile objectForKey:@"decipline"];
    }
    return p;
}
@end
