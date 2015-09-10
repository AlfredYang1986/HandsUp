//
//  LoginModel.m
//  handsup
//
//  Created by Alfred Yang on 9/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "LoginModel.h"
#import "AppDelegate.h"
#import "ModelDefines.h"

#import "CurrentToken.h"
#import "LoginModel.h"
#import "CurrentToken+ContextOpt.h"

#import "WeiboUser.h"

#import "RemoteInstance.h"
#import "TmpFileStorageModel.h"

@interface LoginModel () {

}

@property (strong, nonatomic) LoginToken* current_user;

/**
 * for weibo login
 */
@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@end

@implementation LoginModel

@synthesize doc = _doc;
@synthesize delegate = _delegate;

@synthesize current_user = _current_user;

- (void)enumDataFromLocalDB:(UIManagedDocument*)document {
    dispatch_queue_t aq = dispatch_queue_create("load_data", NULL);
   
    dispatch_async(aq, ^(void){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [document.managedObjectContext performBlock:^(void){
                
                // Weibo sdk init
                [WeiboSDK enableDebugMode:YES];
                [WeiboSDK registerApp:@"331561407"];

                [[NSNotificationCenter defaultCenter] postNotificationName:@"app ready" object:nil];
            }];
        });
    });
}

- (id)initWithAppDelegate:(AppDelegate *)app {
    self = [super init];
    _delegate = app;
    /**
     * get authorised user array in the local database
     */
    NSString* docs=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL* url =[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:LOCALDB_LOGIN]];
    _doc = (UIManagedDocument*)[[UIManagedDocument alloc]initWithFileURL:url];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:[url path] isDirectory:NO]) {
        [_doc saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            [self enumDataFromLocalDB:_doc];
        }];
    } else if (_doc.documentState == UIDocumentStateClosed) {
        [_doc openWithCompletionHandler:^(BOOL success){
            [self enumDataFromLocalDB:_doc];
        }];
    } else {
        
    }

    return self;
}

- (NSString*)getCurrentAuthToken {
    return self.current_user.auth_token;
}

- (NSString*)getCurrentUserID {
    return self.current_user.user_id;
}

- (BOOL)hasLogin {
    return self.current_user != nil;
}

- (LoginToken*)queryCurrentUser {
    return [CurrentToken enumCurrentLoginUserInContext:_doc.managedObjectContext];
}

#pragma mark -- weibo call back
- (void)loginWithWeibo {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = @"http://192.168.0.101";
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)loginSuccessWithWeiboAsUser:(NSString*)weibo_user_id withToken:(NSString*)weibo_token {
    NSLog(@"wei bo login success");
    NSLog(@"login as user: %@", weibo_user_id);
    NSLog(@"login with token: %@", weibo_token);
    /**
     *  1. get user email in weibo profle
     */
    [WBHttpRequest requestForUserProfile:weibo_user_id withAccessToken:weibo_token andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        NSLog(@"begin get user info from weibo");
        NSString *title = nil;
        UIAlertView *alert = nil;
        
        if (error) {
            title = NSLocalizedString(@"请求异常", nil);
            alert = [[UIAlertView alloc] initWithTitle:title
                                               message:[NSString stringWithFormat:@"%@",error]
                                              delegate:nil
                                     cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                     otherButtonTitles:nil];
            [alert show];
        } else {
           /**
            *  2. sent user screen name to server and create auth_token
            */
            WeiboUser* user = (WeiboUser*)result;
            NSString* screen_name = user.screenName;
            NSLog(@"user name is %@", screen_name);
            
            /**
             *  3. save auth_toke and weibo user profile in local DB
             */
            _current_user = [self sendAuthProvidersName:@"weibo" andProvideUserId:weibo_user_id andProvideToken:weibo_token];
            NSLog(@"new user token %@", _current_user.auth_token);
            NSLog(@"new user id %@", _current_user.user_id);
            
            /**
             * 3.1 user image
             */
            dispatch_queue_t aq = dispatch_queue_create("weibo profile img queue", nil);
            dispatch_async(aq, ^{
                NSData* data = [RemoteInstance remoteDownDataFromUrl:[NSURL URLWithString:user.profileImageUrl]];
                UIImage* img = [UIImage imageWithData:data];
                if (img) {
                    NSString* img_name = [TmpFileStorageModel generateFileName];
                    [TmpFileStorageModel saveToTmpDirWithImage:img withName:img_name];
                    
                    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
                    [dic setValue:[self getCurrentAuthToken] forKey:@"auth_token"];
                    [dic setValue:[self getCurrentUserID] forKey:@"user_id"];
                    [dic setValue:img_name forKey:@"screen_photo"];
                    [dic setValue:screen_name forKey:@"screen_name"];
                    [self updateUserProfile:[dic copy]];
                    
                    dispatch_queue_t post_queue = dispatch_queue_create("post queue", nil);
                    dispatch_async(post_queue, ^(void){
                        [RemoteInstance uploadPicture:img withName:img_name toUrl:[NSURL URLWithString:FILE_UPLOAD] callBack:^(BOOL successs, NSString *message) {
                            if (successs) {
                                NSLog(@"post image success");
                            } else {
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                                [alert show];
                            }
                        }];
                    });
                }
            });
      
            /**
             *  4. push notification to the controller
             *      and controller to refresh the view
             */
            [_doc.managedObjectContext save:nil];
            NSLog(@"end get user info from weibo");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SNS login success" object:nil];
        }
    }];
}

- (LoginToken*)sendAuthProvidersName:(NSString*)provide_name andProvideUserId:(NSString*)provide_user_id andProvideToken:(NSString*)provide_token {
  
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setValue:provide_name forKey:@"provider_name"];
    [dic setValue:provide_user_id forKey:@"provider_open_id"];
    [dic setValue:provide_token forKey:@"provider_auth_token"];

    NSError * error = nil;
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:[dic copy] options:NSJSONWritingPrettyPrinted error:&error];

    NSDictionary* result = [RemoteInstance remoteSeverRequestData:jsonData toUrl:[NSURL URLWithString:AUTH_WITH_SNS]];
    
    if ([[result objectForKey:@"status"] isEqualToString:@"ok"]) {
        NSDictionary* reVal = [result objectForKey:@"result"];
        
        NSString* user_id = (NSString*)[reVal objectForKey:@"user_id"];
        
        LoginToken* tmp = [CurrentToken createAndUpdateTokenWithUserID:user_id andAttr:reVal inContext:_doc.managedObjectContext];
        [CurrentToken createAndUpdataSNSWithUserID:user_id andAttr:[dic copy] inContext:_doc.managedObjectContext];
        [CurrentToken changeCurrentLoginUser:tmp inContext:_doc.managedObjectContext];
       
        return tmp;
    } else {
        NSDictionary* reError = [result objectForKey:@"error"];
        NSString* msg = [reError objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
        return nil;
    }
}

- (BOOL)updateUserProfile:(NSDictionary*)attrs {

    NSError * error = nil;
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:attrs options:NSJSONWritingPrettyPrinted error:&error];
    
    NSDictionary* result = [RemoteInstance remoteSeverRequestData:jsonData toUrl:[NSURL URLWithString:PROFILE_UPDATE]];
    
    if ([[result objectForKey:@"status"] isEqualToString:@"ok"]) {
        NSDictionary* reVal = [result objectForKey:@"result"];
        NSLog(@"user profile is %@", reVal);
        [CurrentToken createAndUpdateProfileWithUserID:[attrs objectForKey:@"user_id"] andAttr:reVal inContext:_doc.managedObjectContext];
        return YES;
    } else {
        NSDictionary* reError = [result objectForKey:@"error"];
        NSString* msg = [reError objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
}

#pragma mark -- weibo delegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        /**
         * auth response
         * if success throw the user id and the token to the login model
         * otherwise show error message
         */
        if (response.statusCode == 0) { // success
            [self loginSuccessWithWeiboAsUser:[(WBAuthorizeResponse *)response userID] withToken:[(WBAuthorizeResponse *)response accessToken]];
        } else {
            NSString *title = @"weibo auth error";
            
            NSString *message = [NSString stringWithFormat: @"some thing wrong, and error code is %ld", (long)response.statusCode];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"cancel"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if ([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
        
        NSString *title = @"推荐结果";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:[NSString stringWithFormat:@"response %@", ((WBSDKAppRecommendResponse*)response)]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }
}
@end
