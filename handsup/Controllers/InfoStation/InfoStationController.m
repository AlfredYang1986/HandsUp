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

#import "InfoStationView.h"
#import "InfoStationMySchool.h"
#import "InfoStationSearchSchool.h"

@interface InfoStationController () <UISearchBarDelegate>

@property (strong, nonatomic) InfoStationView* mainView;
@property (weak, nonatomic) UITableView* queryView;
@property (weak, nonatomic, setter=setCurrentDelegate:) id<UITableViewDelegate, UITableViewDataSource> current_delegate;
@end

@implementation InfoStationController {
    InfoStationMySchool* my_school;
    InfoStationSearchSchool* search_school;

    UIPanGestureRecognizer* pan;
    CGPoint ori;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.infoStationController = self;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"InfoStationView" owner:self options:nil];
    _mainView = [nib objectAtIndex:0];
    _mainView.frame = CGRectMake(0, 20, width, height - 20);
    [self.view addSubview:_mainView];
    
    my_school = [[InfoStationMySchool alloc]init];
    search_school = [[InfoStationSearchSchool alloc]init];
   
    self.current_delegate = my_school;
    
    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [_mainView addGestureRecognizer:pan];
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

- (void)setCurrentDelegate:(id<UITableViewDelegate,UITableViewDataSource>)current_delegate {
    _current_delegate = current_delegate;
    _queryView.delegate = _current_delegate;
    _queryView.dataSource = _current_delegate;
    [_queryView reloadData];
}

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

- (void)handlePan:(UIPanGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        ori = [gesture translationInView:self.view];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint p = [gesture translationInView:self.view];
        if (p.x - ori.x > 100) {
            NSLog(@"left");
            [self backBtnSelected];
        }
    }

}
@end
