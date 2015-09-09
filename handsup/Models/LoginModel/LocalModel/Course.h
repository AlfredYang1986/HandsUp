//
//  Course.h
//  
//
//  Created by Alfred Yang on 9/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSString * course_name;
@property (nonatomic, retain) NSString * course_id;
@property (nonatomic, retain) NSNumber * course_grade;
@property (nonatomic, retain) NSManagedObject *who;

@end
