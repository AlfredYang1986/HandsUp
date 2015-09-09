//
//  LoginController.m
//  handsup
//
//  Created by Alfred Yang on 9/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "LoginController.h"
#import "AppDelegate.h"
#import "LoginModel.h"

@interface LoginController ()
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation LoginController {
    UINavigationController* tmp;
}

@synthesize weiboBtn = _weiboBtn;

@synthesize parent = _parent;
@synthesize containerView = _containerView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    _containerView.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.8];

    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"HandsUpBoundle" ofType :@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    NSString* filepath = [resourceBundle pathForResource:@"weibo" ofType:@"png"];
    [_weiboBtn setBackgroundImage:[UIImage imageNamed:filepath] forState:UIControlStateNormal];
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

- (void)setBackgroudParent:(UIViewController *)parent {
    _parent = parent;
    tmp = _parent.navigationController;
    [tmp popToRootViewControllerAnimated:NO];
    [self.view addSubview:_parent.view];
    _parent.view.frame = self.view.frame;
    [self.view bringSubviewToFront:_containerView];   
}

- (IBAction)loginWithWeibo {
//    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    [app.lm loginWithWeibo];
    [_parent.view removeFromSuperview];
    [tmp pushViewController:_parent animated:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
