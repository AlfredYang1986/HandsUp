//
//  Course.h
//  
//
//  Created by Alfred Yang on 10/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LoginToken;

@interface Course : NSManagedObject

@property (nonatomic, retain) NSNumber * course_grade;
@property (nonatomic, retain) NSString * course_id;
@property (nonatomic, retain) NSString * course_name;
@property (nonatomic, retain) LoginToken *who;

@end
