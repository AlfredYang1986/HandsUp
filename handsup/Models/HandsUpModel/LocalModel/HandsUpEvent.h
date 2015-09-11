//
//  HandsUpEvent.h
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HandsUpOwner;

@interface HandsUpEvent : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * event_id;
@property (nonatomic, retain) NSString * founder_id;
@property (nonatomic, retain) HandsUpOwner *whoQuery;

@end
