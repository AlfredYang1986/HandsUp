//
//  Info.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "InfoSegue.h"

@implementation InfoSegue
-(void)perform {
    
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    [UIView transitionFromView:src.view toView:dst.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        [src.navigationController pushViewController:dst animated:NO];
    }];
}
@end
