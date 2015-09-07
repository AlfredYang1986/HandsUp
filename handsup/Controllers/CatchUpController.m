//
//  CatchUpController.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "CatchUpController.h"
#import "AppDelegate.h"
#import "ViewController.h"

@interface CatchUpController ()

@end

@implementation CatchUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.catchUpController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"backFromCatch"]) {
//    }
}

- (IBAction)backBtnSelected {
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [UIView transitionFromView:self.view toView:app.mainController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}
@end
