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

#pragma mark -- PROFILE
#define PROFILE_HOST_DOMAIN                 [HOST_DOMAIN stringByAppendingString:@"profile/"]
#define PROFILE_UPDATE                      [PROFILE_HOST_DOMAIN stringByAppendingString:@"updateUserProfile"]
#define PROFILE_QUERY                       [PROFILE_HOST_DOMAIN stringByAppendingString:@"queryUserProfile"]

#define mark -- HANDSUP
#define HANDSUP_DOMAIN                      [HOST_DOMAIN stringByAppendingString:@"handsup/"]
#define HANDSUP_QUERY                       [HANDSUP_DOMAIN stringByAppendingString:@"queryHandsUpEvents"]
#define HANDSUP_POST                        [HANDSUP_DOMAIN stringByAppendingString:@"postHandsUpEvent"]

#pragma mark -- FILE (UPLOAD AND DOWNLOAD)
#define FILE_HOST_DOMAIN                    [HOST_DOMAIN stringByAppendingString:@"file/"]
#define FILE_UPLOAD                         [FILE_HOST_DOMAIN stringByAppendingString:@"uploadFile"]

#pragma mark -- database
#define LOCALDB_LOGIN                       @"loginData.sqlite"
#define LOCALDB_HANDSUP                     @"handsup.sqlite"
