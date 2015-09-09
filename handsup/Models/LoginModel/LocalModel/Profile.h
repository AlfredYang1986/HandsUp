//
//  Profile.h
//  
//
//  Created by Alfred Yang on 9/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Profile : NSManagedObject

@property (nonatomic, retain) NSString * school;
@property (nonatomic, retain) NSString * decipline;
@property (nonatomic, retain) NSNumber * years;
@property (nonatomic, retain) NSManagedObject *who;

@end