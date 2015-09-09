//
//  ModelDefines.h
//  YYBabyAndMother
//
//  Created by Alfred Yang on 10/01/2015.
//  Copyright (c) 2015 YY. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark -- HOST DOMAIN
//#define HOST_DOMAIN                     @"http://www.altlys.com:9000/"
#define HOST_DOMAIN                     @"http://192.168.1.104:9000/"

#pragma mark -- AUTH
#define AUTH_HOST_DOMAIN                    [HOST_DOMAIN stringByAppendingString:@"auth/"]
#define AUTH_WITH_SNS                       [AUTH_HOST_DOMAIN stringByAppendingString:@"authWithSNS"]

#pragma mark -- database
#define LOCALDB_LOGIN                       @"loginData.sqlite"
