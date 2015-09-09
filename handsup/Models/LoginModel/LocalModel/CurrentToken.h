//
//  CurrentToken.h
//  
//
//  Created by Alfred Yang on 9/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface CurrentToken : NSManagedObject

@property (nonatomic, retain) NSManagedObject *who;

@end
