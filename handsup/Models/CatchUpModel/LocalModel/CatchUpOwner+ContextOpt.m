//
//  CatchUpOwner+ContextOpt.m
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "CatchUpOwner+ContextOpt.h"

@implementation CatchUpOwner (ContextOpt)

+ (CatchUpOwner*)enumCatchOwnerWithUserID:(NSString*)user_id inContext:(NSManagedObjectContext*)context {
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"CatchUpOwner"];
    
    NSError* error = nil;
    NSArray* matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || matches.count > 1) {
        NSLog(@"should have one and only one current user");
        return nil;
    } else if (matches.count == 1) {
        CatchUpOwner* tmp = [matches lastObject];
//        if ([tmp.who.user_id isEqualToString:lgt.user_id]) {
//            tmp.last_login_data = [NSDate date];
//            tmp.status = [NSNumber numberWithInt:1]; // 1 => online
//        } else {
//            tmp.who = lgt;
//            tmp.status = [NSNumber numberWithInt:1]; // 1 => online
//        }
//        [context save:nil];
        return tmp;
    } else {
        NSLog(@"nothing need to be delected");
        CatchUpOwner* tmp = [NSEntityDescription insertNewObjectForEntityForName:@"CatchUpOwner" inManagedObjectContext:context];
//        tmp.last_login_data = [NSDate date];
//        tmp.who = lgt;
//        tmp.status = [NSNumber numberWithInt:1]; // 1 => online
//        [context save:nil];
        return tmp;
    }
}

+ (void)refreshEventsWithUserID:(NSString*)user_id withData:(NSArray*)data inContext:(NSManagedObjectContext*)context {
    
    CatchUpOwner* tmp = [self enumCatchOwnerWithUserID:user_id inContext:context];
    
    if (tmp == nil) {
        return;
    }
   
    /**
     * delete all existing
     */
    while (tmp.events.count > 0) {
        CatchUpEvent* iter = tmp.events.anyObject;
        [tmp removeEventsObject:iter];
        [context deleteObject:iter];
    }
    
    /**
     * add new ones
     */
    for (NSDictionary* dic in data) {
        CatchUpEvent* event = [NSEntityDescription insertNewObjectForEntityForName:@"CatchUpEvent" inManagedObjectContext:context];
//        event.date
        event.title = [dic objectForKey:@"title"];
        event.detail = [dic objectForKey:@"detail"];
        event.founder_id = [dic objectForKey:@"founder_id"];
        event.event_id = [dic objectForKey:@"event_id"];
        
        [tmp addEventsObject:event];
        event.whoQuery = tmp;
    }
}

+ (NSArray*)enumEventsWithUserID:(NSString*)user_id inContext:(NSManagedObjectContext*)context {
    CatchUpOwner* tmp = [self enumCatchOwnerWithUserID:user_id inContext:context];
    
    if (tmp == nil) {
        return nil;
    }
    
    return tmp.events.allObjects;
}
@end
