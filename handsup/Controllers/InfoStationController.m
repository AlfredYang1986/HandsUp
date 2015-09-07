//
//  InfoStationController.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "InfoStationController.h"
#import "AppDelegate.h"
#import "HandsUpController.h"

@interface InfoStationController ()

@end

@implementation InfoStationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.infoStationController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"backFromHands"]) {
//    }
}


- (IBAction)backBtnSelected {
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [UIView transitionFromView:self.view toView:app.handsUpController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}
@end
