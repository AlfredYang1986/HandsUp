//
//  HandsUpController.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "HandsUpController.h"
#import "AppDelegate.h"
#import "HandsUpSegue.h"
#import "MainViewController.h"
#import "INTUAnimationEngine.h"

@interface HandsUpController () {

}
@property (weak, nonatomic) IBOutlet UIButton *right_btn;
@property (weak, nonatomic) IBOutlet UIButton *left_btn;
@property (weak, nonatomic) IBOutlet UILabel *handsLabel;

@end

@implementation HandsUpController {
    UIPanGestureRecognizer* pan;
    CGPoint ori;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.handsUpController = self;
   
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    self.view.frame = CGRectMake(0, 0, width, height);

    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
//    [self.view removeFromSuperview];;
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.infoStationController = nil;
    app.catchUpController = nil;

    [self.view addGestureRecognizer:pan];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.view removeGestureRecognizer:pan];
}

- (void)viewDidLayoutSubviews {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
   
    if (self.view.frame.size.height != height) {
        _handsLabel.center = CGPointMake(_handsLabel.center.x, _handsLabel.center.y + height / 2);
        _right_btn.center = CGPointMake(_right_btn.center.x, _left_btn.center.y + height / 2);
        _left_btn.center = CGPointMake(_left_btn.center.x, _left_btn.center.y + height / 2);
    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"Info"]) {
//    
//    } else if ([segue.identifier isEqualToString:@"CatchUp"]) {
//        
//    }
//}
//
- (IBAction)rigthBtnSelected {
    [self performSegueWithIdentifier:@"Info" sender:nil];
}

- (IBAction)leftBtnSelected {
    [self performSegueWithIdentifier:@"CatchUp" sender:nil];
}

- (void)handlePan:(UIPanGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        ori = [gesture translationInView:self.view];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint p = [gesture translationInView:self.view];
        if (p.y - ori.y > 100) {
            [self backToMainController];
//            [self performSegueWithIdentifier:@"HandsSegue" sender:nil];
        }
    }
}

- (void)backToMainController {
   
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UINavigationController* nav = self.navigationController;
    UIViewController* src = self;
    MainViewController* dst = app.mainController;
    
    static const CGFloat kAnimationDuration = 0.5; // in seconds
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGRect rc_1 = CGRectMake(0, -height, width, height * 2);
    CGRect rc_2 = CGRectMake(0, 0, width, height);
    CGRect rc_3 = CGRectMake(0, 0, width, height * 2);

    src.view.frame = rc_1;
    dst.view.frame = rc_2;
    dst.isSegueBack = YES;

    [src.view addSubview:dst.view];

    [INTUAnimationEngine animateWithDuration:kAnimationDuration
                                       delay:0.0
                                      easing:INTUEaseInOutQuadratic
                                     options:INTUAnimationOptionNone
                                  animations:^(CGFloat progress) {
                                       src.view.frame = INTUInterpolateCGRect(rc_1, rc_3, progress);
                                       // NSLog(@"Progress: %.2f", progress);
                                   }
                                 completion:^(BOOL finished) {
                                     NSLog(@"%@", finished ? @"Animation Completed" : @"Animation Canceled");
                                     [dst.view removeFromSuperview];
                                     [nav popToRootViewControllerAnimated:NO];
                                     [nav pushViewController:dst animated:NO];
                                 }];
}
@end
