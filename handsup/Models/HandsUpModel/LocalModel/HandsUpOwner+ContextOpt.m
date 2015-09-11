//
//  HandsUpOwner+ContextOpt.m
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "HandsUpOwner+ContextOpt.h"

@implementation HandsUpOwner (ContextOpt)

+ (HandsUpOwner*)enumEventOwnerWithUserID:(NSString*)user_id inContext:(NSManagedObjectContext*)context {
    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"HandsUpOwner"];
    
    NSError* error = nil;
    NSArray* matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || matches.count > 1) {
        NSLog(@"should have one and only one current user");
        return nil;
    } else if (matches.count == 1) {
        HandsUpOwner* tmp = [matches lastObject];
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
        HandsUpOwner* tmp = [NSEntityDescription insertNewObjectForEntityForName:@"HandsUpOwner" inManagedObjectContext:context];
//        tmp.last_login_data = [NSDate date];
//        tmp.who = lgt;
//        tmp.status = [NSNumber numberWithInt:1]; // 1 => online
//        [context save:nil];
        return tmp;
    }
}

+ (void)refreshEventsWithUserID:(NSString*)user_id withData:(NSArray*)data inContext:(NSManagedObjectContext*)context {
   
    HandsUpOwner* tmp = [self enumEventOwnerWithUserID:user_id inContext:context];
    
    if (tmp == nil) {
        return;
    }
   
    /**
     * delete all existing
     */
    while (tmp.events.count > 0) {
        HandsUpEvent* iter = tmp.events.anyObject;
        [tmp removeEventsObject:iter];
        [context deleteObject:iter];
    }
    
    /**
     * add new ones
     */
    for (NSDictionary* dic in data) {
        HandsUpEvent* event = [NSEntityDescription insertNewObjectForEntityForName:@"HandsUpEvent" inManagedObjectContext:context];
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
    HandsUpOwner* tmp = [self enumEventOwnerWithUserID:user_id inContext:context];
    
    if (tmp == nil) {
        return nil;
    }
    
    return tmp.events.allObjects;
}
@end
