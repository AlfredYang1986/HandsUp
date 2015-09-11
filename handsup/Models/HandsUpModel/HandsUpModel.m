//
//  HandsUpModel.m
//  handsup
//
//  Created by Alfred Yang on 11/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "HandsUpModel.h"
#import "ModelDefines.h"
#import "AppDelegate.h"
#import "RemoteInstance.h"

#import "HandsUpOwner.h"
#import "HandsUpEvent.h"
#import "HandsUpOwner+ContextOpt.h"

@implementation HandsUpModel

@synthesize doc = _doc;
@synthesize delegate = _delegate;
@synthesize queryData = _queryData;

- (void)enumDataFromLocalDB:(UIManagedDocument*)document {
    dispatch_queue_t aq = dispatch_queue_create("load_data", NULL);
   
    dispatch_async(aq, ^(void){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            [document.managedObjectContext performBlock:^(void){
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"app ready" object:nil];
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
    NSURL* url =[NSURL fileURLWithPath:[docs stringByAppendingPathComponent:LOCALDB_HANDSUP]];
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

- (void)queryHandsUpEventAsyncWithUserID:(NSString*)user_id andAuthToken:(NSString*)auth_token AndBlock:(queryEventsFinishBlock)block {
   
    dispatch_queue_t qe = dispatch_queue_create("query event", nil);
    dispatch_async(qe, ^{
        NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
        [dic setObject:user_id forKey:@"user_id"];
        [dic setObject:auth_token forKey:@"auth_token"];
        
        NSError * error = nil;
        NSData* jsonData =[NSJSONSerialization dataWithJSONObject:[dic copy] options:NSJSONWritingPrettyPrinted error:&error];
        
        NSDictionary* result = [RemoteInstance remoteSeverRequestData:jsonData toUrl:[NSURL URLWithString:HANDSUP_QUERY]];
       
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[result objectForKey:@"status"] isEqualToString:@"ok"]) {
                NSArray* reVal = [result objectForKey:@"result"];
                NSLog(@"hands up events are %@", reVal);
                [HandsUpOwner refreshEventsWithUserID:user_id withData:reVal inContext:_doc.managedObjectContext];
                block(YES, reVal, nil);
            } else {
                NSDictionary* reError = [result objectForKey:@"error"];
                NSString* msg = [reError objectForKey:@"message"];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//                [alert show];
                block(NO, nil, msg);
            }
        });
    });
}

- (NSArray*)enumAllHandsUpEventWithUserID:(NSString*)user_id {
    return [HandsUpOwner enumEventsWithUserID:user_id inContext:_doc.managedObjectContext];
}

- (NSArray*)enumMyEventsLocalWithUserID:(NSString*)user_id {
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF.founder_id=%@", user_id];
    return [[self enumAllHandsUpEventWithUserID:user_id] filteredArrayUsingPredicate:pred];
}

- (NSArray*)enumOtherEventsLocalWithUserID:(NSString*)user_id {
    NSPredicate* pred = [NSPredicate predicateWithFormat:@"SELF.founder_id!=%@", user_id];
    return [[self enumAllHandsUpEventWithUserID:user_id] filteredArrayUsingPredicate:pred];
}

- (BOOL)user:(NSString*)user_id withToken:(NSString*)auth_token postHandsUpEvent:(NSDictionary*)attr {
   
    NSMutableDictionary* dic = [attr mutableCopy];
    [dic setObject:user_id forKey:@"user_id"];
    [dic setObject:auth_token forKey:@"auth_token"];
    
    NSError * error = nil;
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:[dic copy] options:NSJSONWritingPrettyPrinted error:&error];
    
    NSDictionary* result = [RemoteInstance remoteSeverRequestData:jsonData toUrl:[NSURL URLWithString:HANDSUP_POST]];
   
    if ([[result objectForKey:@"status"] isEqualToString:@"ok"]) {
        NSArray* reVal = [result objectForKey:@"result"];
        NSLog(@"hands up events are %@", reVal);
        [HandsUpOwner refreshEventsWithUserID:user_id withData:reVal inContext:_doc.managedObjectContext];
        return YES;
    } else {
        NSDictionary* reError = [result objectForKey:@"error"];
        NSString* msg = [reError objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
}
@end
