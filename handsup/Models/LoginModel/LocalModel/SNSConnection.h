//
//  SNSConnection.h
//  
//
//  Created by Alfred Yang on 10/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LoginToken;

@interface SNSConnection : NSManagedObject

@property (nonatomic, retain) NSString * provider_auth_token;
@property (nonatomic, retain) NSString * provider_name;
@property (nonatomic, retain) NSString * provider_open_id;
@property (nonatomic, retain) NSString * provider_refresh_token;
@property (nonatomic, retain) LoginToken *who;

@end
