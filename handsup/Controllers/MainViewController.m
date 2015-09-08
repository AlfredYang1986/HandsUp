//
//  MainViewController.m
//  handsup
//
//  Created by Alfred Yang on 8/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "HandsUpController.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@end

@implementation MainViewController {
    UIPanGestureRecognizer* pan;
    CGPoint ori;
}

@synthesize titleContainer = _titleContainer;
@synthesize isSegueBack = _isSegueBack;

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
    
    _isSegueBack = NO;
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
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (_isSegueBack == YES) {
        NSLog(@"center: %f , %f", _titleContainer.center.x, _titleContainer.center.y);
        _titleContainer.center = CGPointMake(_titleContainer.center.x, _titleContainer.center.y -  height);
        NSLog(@"center: %f , %f", _titleContainer.center.x, _titleContainer.center.y);
    }
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
