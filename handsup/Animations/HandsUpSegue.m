//
//  HandsUpSegue.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "HandsUpSegue.h"

@implementation HandsUpSegue

-(void)perform {
//    UIViewController * svc = self.sourceViewController;
//    UIViewController * dvc = self.destinationViewController;
//    [svc.view addSubview:dvc.view];
//    [dvc.view setFrame:svc.view.frame];
//    [dvc.view setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
//    [dvc.view setAlpha:0.0];
////    [UIView animateWithDuration:1.0
////                     animations:^{
////                         [dvc.view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
////                         [dvc.view setAlpha:1.0];
////                     }
////                     completion:^(BOOL finished) {
////                         //                         [dvc.view removeFromSuperview];
////                     }];
//    
//    [UIView transitionWithView:svc.navigationController.view duration:0.6
//                       options:UIViewAnimationOptionTransitionFlipFromRight
//                    animations:^{
//                            [svc.navigationController pushViewController:dvc animated:NO];
//                        }
//                    completion:NULL];
    
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    [UIView transitionFromView:src.view toView:dst.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        [src.navigationController pushViewController:dst animated:NO];
    }];
    
//    [UIView transitionFromView:src.navigationItem.titleView toView:dst.navigationItem.titleView duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
//        [src.navigationController pushViewController:dst animated:NO];
//    } ];
}
@end
