//
//  HandsUpSegue.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "HandsUpSegue.h"
#import "INTUAnimationEngine.h"

@implementation HandsUpSegue {
    UIView* animationView;
}

-(void)perform {
   
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    UINavigationController* nav = src.navigationController;

    UIView* src_view = src.view;
    UIView* dst_view = dst.view;
 
    static const CGFloat kAnimationDuration = 0.5; // in seconds
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    CGRect rc_1 = CGRectMake(0, 0, width, height * 2);
    CGRect rc_2 = CGRectMake(0, -height, width, height * 2);
    CGRect rc_3 = CGRectMake(0, height, width, height);
    
    src_view.frame = rc_1;
    dst_view.frame = rc_3;
    
    [src_view addSubview:dst_view];
   
    [INTUAnimationEngine animateWithDuration:kAnimationDuration
                                                          delay:0.0
                                                         easing:INTUEaseInOutQuadratic
                                                        options:INTUAnimationOptionNone
                                                     animations:^(CGFloat progress) {
//                                                         dst_view.frame = INTUInterpolateCGRect(rc_3, rc_1, progress);
                                                         src_view.frame = INTUInterpolateCGRect(rc_1, rc_2, progress);
                                                         
                                                         // NSLog(@"Progress: %.2f", progress);
                                                     }
                                                     completion:^(BOOL finished) {
                                                         NSLog(@"%@", finished ? @"Animation Completed" : @"Animation Canceled");
                                                         [nav popViewControllerAnimated:NO];
                                                         [nav pushViewController:dst animated:NO];
                                                         [dst.view removeFromSuperview];
                                                     }];
}
@end
