//
//  HandsUpCreateController.h
//  handsup
//
//  Created by Alfred Yang on 9/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HandsUpCreateProtocol <NSObject>

- (void)createHandsUpEventResult:(BOOL)success;
@end

@interface HandsUpCreateController : UIViewController

@property (nonatomic, weak) id<HandsUpCreateProtocol> delegate;
@end
