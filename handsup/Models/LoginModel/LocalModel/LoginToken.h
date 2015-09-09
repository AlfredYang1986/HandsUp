//
//  LoginToken.h
//  
//
//  Created by Alfred Yang on 9/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Course, CurrentToken, Profile, SNSConnection;

@interface LoginToken : NSManagedObject

@property (nonatomic, retain) NSString * screen_name;
@property (nonatomic, retain) NSString * screen_photo;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * auth_token;
@property (nonatomic, retain) NSSet *connectWith;
@property (nonatomic, retain) CurrentToken *current;
@property (nonatomic, retain) Profile *profile;
@property (nonatomic, retain) NSSet *takeCourse;
@end

@interface LoginToken (CoreDataGeneratedAccessors)

- (void)addConnectWithObject:(SNSConnection *)value;
- (void)removeConnectWithObject:(SNSConnection *)value;
- (void)addConnectWith:(NSSet *)values;
- (void)removeConnectWith:(NSSet *)values;

- (void)addTakeCourseObject:(Course *)value;
- (void)removeTakeCourseObject:(Course *)value;
- (void)addTakeCourse:(NSSet *)values;
- (void)removeTakeCourse:(NSSet *)values;

@end
