//
//  CatchUpEvent.h
//  
//
//  Created by Alfred Yang on 11/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CatchUpOwner;

@interface CatchUpEvent : NSManagedObject

@property (nonatomic, retain) NSString * event_id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * founder_id;
@property (nonatomic, retain) CatchUpOwner *whoQuery;

@end
