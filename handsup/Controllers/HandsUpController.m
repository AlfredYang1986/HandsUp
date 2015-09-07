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
#import "ViewController.h"

@interface HandsUpController ()

@end

@implementation HandsUpController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.handsUpController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"backFromHands"]) {
//    }
}


- (IBAction)backBtnSelected {
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [UIView transitionFromView:self.view toView:app.mainController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

@end
