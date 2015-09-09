//
//  SNSConnection.h
//  
//
//  Created by Alfred Yang on 9/09/2015.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface SNSConnection : NSManagedObject

@property (nonatomic, retain) NSString * providor_screen_name;
@property (nonatomic, retain) NSString * providor_screen_photo;
@property (nonatomic, retain) NSString * providor_name;
@property (nonatomic, retain) NSString * providor_open_id;
@property (nonatomic, retain) NSString * providor_auth_token;
@property (nonatomic, retain) NSString * providor_refresh_token;
@property (nonatomic, retain) NSManagedObject *who;

@end
