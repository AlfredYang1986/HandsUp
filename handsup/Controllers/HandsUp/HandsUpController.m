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

#import "HandsUpTitleView.h"
#import "AppDelegate.h"
#import "LoginModel.h"
#import "handsUpModel.h"
#import "LoginController.h"

#import "HandsUpEvent.h"
#import "HandsUpCreateController.h"

@interface HandsUpController () <UITableViewDataSource, UITableViewDelegate, HandsUpTitleViewProtocol, HandsUpCreateProtocol> {

}

@property (strong, nonatomic, readonly) HandsUpTitleView *titleContainer;
@property (strong, nonatomic, readonly) UITableView* queryView;
@property (strong, nonatomic, readonly) UIButton* refreshBtn;
@end

@implementation HandsUpController {
    UIPanGestureRecognizer* pan;
    CGPoint ori;
    
    NSArray* myEvents;
    NSArray* queryEvents;
}

@synthesize titleContainer = _titleContainer;
@synthesize queryView = _queryView;
@synthesize refreshBtn = _refreshBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.handsUpController = self;
   
    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
   
    /**
     * create title view
     */
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HandsUpTitleView" owner:self options:nil];
    _titleContainer = [nib objectAtIndex:0];
    _titleContainer.delegate = self;
  
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _titleContainer.frame = CGRectMake(0, 20, width, [HandsUpTitleView perferredHeight]);
    [self.view addSubview:_titleContainer];
    
    /**
     * create table view
     */
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat offset = 20 + [HandsUpTitleView perferredHeight] + 8;
    _queryView = [[UITableView alloc]initWithFrame:CGRectMake(0, offset, width, height - offset - 49)];
    _queryView.delegate = self;
    _queryView.dataSource = self;
    [self.view addSubview:_queryView];
    
    /**
     * create bottom button
     */
    offset = height - 49;
    CGFloat btn_width = 30;
    _refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(width - 30 - 16, offset + 8, btn_width, btn_width)];
    
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"HandsUpBoundle" ofType :@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString* filepath = [resourceBundle pathForResource:@"Refresh" ofType:@"png"];
    [_refreshBtn setBackgroundImage:[UIImage imageNamed:filepath] forState:UIControlStateNormal];
    [self.view addSubview:_refreshBtn];
    
    [self.view addGestureRecognizer:pan];
   
    if ([app.lm hasLogin]) {
        myEvents = [app.hm enumMyEventsLocalWithUserID:[app.lm getCurrentUserID]];
        queryEvents = [app.hm enumOtherEventsLocalWithUserID:[app.lm getCurrentUserID]];
        
        [app.hm queryHandsUpEventAsyncWithUserID:[app.lm getCurrentUserID] andAuthToken:[app.lm getCurrentAuthToken] AndBlock:^(BOOL success, NSArray *result, NSString *error) {
            AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
            myEvents = [app.hm enumMyEventsLocalWithUserID:[app.lm getCurrentUserID]];
            queryEvents = [app.hm enumOtherEventsLocalWithUserID:[app.lm getCurrentUserID]];
            [_queryView reloadData];
        }];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogedIn:) name:@"SNS login success" object:nil];
}

- (void)userLogedIn:(NSNotification*)notification {
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    myEvents = [app.hm enumMyEventsLocalWithUserID:[app.lm getCurrentUserID]];
    queryEvents = [app.hm enumOtherEventsLocalWithUserID:[app.lm getCurrentUserID]];
    
    [app.hm queryHandsUpEventAsyncWithUserID:[app.lm getCurrentUserID] andAuthToken:[app.lm getCurrentAuthToken] AndBlock:^(BOOL success, NSArray *result, NSString *error) {
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        myEvents = [app.hm enumMyEventsLocalWithUserID:[app.lm getCurrentUserID]];
        queryEvents = [app.hm enumOtherEventsLocalWithUserID:[app.lm getCurrentUserID]];
        [_queryView reloadData];
    }];   
}

- (void)dealloc {
    [self.view removeGestureRecognizer:pan];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

}

- (void)viewDidDisappear:(BOOL)animated {

}

- (void)viewDidLayoutSubviews {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
   
    if (self.view.frame.size.height != height) {
        _titleContainer.frame = CGRectMake(0, 20 + height, width, [HandsUpTitleView perferredHeight]);
        CGFloat offset = 20 + [HandsUpTitleView perferredHeight] + 8;
        _queryView.frame = CGRectMake(0, offset + height, width, height - offset - 49);
        offset = height - 49;
        CGFloat btn_width = 30;
        _refreshBtn.frame =CGRectMake(width - 30 - 16, offset + 8 + height, btn_width, btn_width);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Info"]) {
    
    } else if ([segue.identifier isEqualToString:@"CatchUp"]) {
        
    } else if ([segue.identifier isEqualToString:@"HandsUpCreate"]) {
        ((HandsUpCreateController*)segue.destinationViewController).delegate = self;
    }
}
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
        } else if (p.x - ori.x > 100) {
            NSLog(@"left");
            [self leftBtnSelected];
        } else if (ori.x - p.x > 100) {
            NSLog(@"right");
            [self rigthBtnSelected];
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

#pragma mark -- table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)return @"我的";
    else return @"其它";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

#pragma mark -- table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return myEvents.count;
    } else {
        return queryEvents.count;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    }
   
   
    HandsUpEvent* tmp = nil;
    if (indexPath.section == 0) {
        tmp = [myEvents objectAtIndex:indexPath.row];
    } else {
        tmp = [queryEvents objectAtIndex:indexPath.row];
    }

    cell.textLabel.text = tmp.title;
    
    return cell;
}

#pragma mark -- handsup title view delegate
- (void)settingBtnSelected {
    
}

- (void)plusBtnSelected {
   
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (app.lm.hasLogin) {
        [self performSegueWithIdentifier:@"HandsUpCreate" sender:nil];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        LoginController* lc = [storyboard instantiateViewControllerWithIdentifier:@"LoginController"];
        [self presentViewController:lc animated:YES completion: ^(void){
            lc.parent = self;
        }];
    }
    
}

#pragma mark -- create handsup protocol
- (void)createHandsUpEventResult:(BOOL)success {
    if (success) {
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        myEvents = [app.hm enumMyEventsLocalWithUserID:[app.lm getCurrentUserID]];
        queryEvents = [app.hm enumOtherEventsLocalWithUserID:[app.lm getCurrentUserID]];
        [_queryView reloadData];
    }
}
@end
