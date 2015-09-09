//
//  CurrentToken.h
//  
//
//  Created by Alfred Yang on 9/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LoginToken;

@interface CurrentToken : NSManagedObject

@property (nonatomic, retain) LoginToken *who;

@end
