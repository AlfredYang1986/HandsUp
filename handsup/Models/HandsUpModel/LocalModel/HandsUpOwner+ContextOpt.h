//
//  HandsUpOwner+ContextOpt.h
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HandsUpEvent.h"
#import "HandsUpOwner.h"

@interface HandsUpOwner (ContextOpt)

+ (void)refreshEventsWithUserID:(NSString*)user_id withData:(NSArray*)data inContext:(NSManagedObjectContext*)context;
+ (NSArray*)enumEventsWithUserID:(NSString*)user_id inContext:(NSManagedObjectContext*)context;
@end
