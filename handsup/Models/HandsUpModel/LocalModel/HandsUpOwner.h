//
//  HandsUpOwner.h
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface HandsUpOwner : NSManagedObject

@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSSet *events;
@end

@interface HandsUpOwner (CoreDataGeneratedAccessors)

- (void)addEventsObject:(NSManagedObject *)value;
- (void)removeEventsObject:(NSManagedObject *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
