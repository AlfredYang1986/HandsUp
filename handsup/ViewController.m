//
//  ViewController.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "HandsUpController.h"

@interface ViewController () 
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;

@end

@implementation ViewController {
    UIPanGestureRecognizer* pan;
    CGPoint ori;
}

@synthesize mainLabel = _mainLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.mainController = self;
    
    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.handsUpController = nil;
    
    [self.view addGestureRecognizer:pan];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.view removeGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"HandsSegue"]) {
        
    }
}

- (void)viewDidLayoutSubviews {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    _mainLabel.center = CGPointMake(width / 2, height / 2);
}

- (void)handlePan:(UIPanGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        ori = [gesture translationInView:self.view];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint p = [gesture translationInView:self.view];
        if (ori.y - p.y > 100) {
            [self performSegueWithIdentifier:@"HandsSegue" sender:nil];
        }
    }
}
@end
