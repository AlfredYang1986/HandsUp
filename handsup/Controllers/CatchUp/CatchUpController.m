//
//  CatchUpController.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "CatchUpController.h"
#import "AppDelegate.h"
#import "HandsUpController.h"
#import "CatchUpView.h"

#import "LoginModel.h"
#import "CatchUpModel.h"

#import "CatchUpEvent.h"

@interface CatchUpController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic, readonly) CatchUpView* mainView;
@property (weak, nonatomic, readonly) UITableView* queryView;
@end

@implementation CatchUpController {
    UIPanGestureRecognizer* pan;
    CGPoint ori;
    
    NSArray* queryData;
}

@synthesize mainView = _mainView;
@synthesize queryView = _queryView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.catchUpController = self;
  
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CatchUpView" owner:self options:nil];
    _mainView = [nib objectAtIndex:0];
    _mainView.frame = CGRectMake(0, 20, width, height - 20);
    [self.view addSubview:_mainView];
    
    _queryView = _mainView.queryView;
    _queryView.delegate = self;
    _queryView.dataSource = self;
    
    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [_mainView addGestureRecognizer:pan];
   
    if ([app.lm hasLogin]) {
        queryData = [app.cm enumAllCatchUpEventWithUserID:[app.lm getCurrentUserID]];
        
        [app.cm queryCatchUpEventAsyncWithUserID:[app.lm getCurrentUserID] andAuthToken:[app.lm getCurrentAuthToken] AndBlock:^(BOOL success, NSArray *result, NSString *error) {
            queryData = [app.cm enumAllCatchUpEventWithUserID:[app.lm getCurrentUserID]];
            [_queryView reloadData];
        }];
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogedIn:) name:@"SNS login success" object:nil];
}

- (void)userLogedIn:(NSNotification*)notification {
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    queryData = [app.cm enumAllCatchUpEventWithUserID:[app.lm getCurrentUserID]];
        
    [app.cm queryCatchUpEventAsyncWithUserID:[app.lm getCurrentUserID] andAuthToken:[app.lm getCurrentAuthToken] AndBlock:^(BOOL success, NSArray *result, NSString *error) {
        queryData = [app.cm enumAllCatchUpEventWithUserID:[app.lm getCurrentUserID]];
        [_queryView reloadData];
    }];
}

- (void)dealloc {
    [_mainView removeGestureRecognizer:pan];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    [UIView transitionFromView:self.view toView:app.handsUpController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
//        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

- (void)handlePan:(UIPanGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        ori = [gesture translationInView:self.view];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint p = [gesture translationInView:self.view];
        if (ori.x - p.x > 100) {
            NSLog(@"right");
            [self backBtnSelected];
        }
    }
}

#pragma mark -- table view delegate

#pragma mark -- table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return queryData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    }
   
    CatchUpEvent* event = [queryData objectAtIndex:indexPath.row];
    cell.textLabel.text = event.title;
    
    return cell;
}

@end
