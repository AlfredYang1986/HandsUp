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

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *queryView;
@property (weak, nonatomic) IBOutlet UIView *titleContainer;
//@property (weak, nonatomic) IBOutlet UIButton *handsUpBtn;
@property (strong, nonatomic) UIButton *handsUpBtn;
@property (weak, nonatomic) IBOutlet UIImageView *titleImg;
@end

@implementation MainViewController {
    UIPanGestureRecognizer* pan;
    CGPoint ori;
    
    NSArray* titles;
}

@synthesize titleContainer = _titleContainer;
@synthesize queryView = _queryView;
@synthesize handsUpBtn = _handsUpBtn;
@synthesize isSegueBack = _isSegueBack;
@synthesize titleImg = _titleImg;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.mainController = self;
    
    pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:pan];
    
    [self.navigationController setNavigationBarHidden:YES];
    _queryView.scrollEnabled = NO;
    _queryView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    titles = @[@"一块去", @"学校/老师", @"院系/课程", @"", @"Schedule", @"Add a Photo", @"Yo"];
   
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"HandsUpBoundle" ofType :@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString* filepath = [resourceBundle pathForResource:@"Globe" ofType:@"png"];
    _titleImg.image = [UIImage imageNamed:filepath];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _handsUpBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, height - 30 - 8, width - 16, 30)];
    _handsUpBtn.layer.borderColor = [UIColor blueColor].CGColor;
    _handsUpBtn.layer.borderWidth = 1.f;
    _handsUpBtn.layer.cornerRadius = 8.f;
    _handsUpBtn.clipsToBounds = YES;
    [_handsUpBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_handsUpBtn setTitle:@"Hands Up" forState:UIControlStateNormal];
 
    [self.view addSubview:_handsUpBtn];
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
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
  
//    _handsUpBtn.frame = CGRectMake(0, height - _handsUpBtn.frame.size.height - 8, width, 30);
    
    if (_isSegueBack == YES) {
        _titleContainer.center = CGPointMake(_titleContainer.center.x, _titleContainer.center.y -  height);
        _queryView.center = CGPointMake(_queryView.center.x, _queryView.center.y -  height);
//        _handsUpBtn.center = CGPointMake(_handsUpBtn.center.x, _handsUpBtn.center.y -  height);
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

#pragma mark -- uitable view delegate
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row != 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) return 22;
    else return 44;
}

#pragma mark -- uitable view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    }

    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"HandsUpBoundle" ofType :@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    if (indexPath.row == 4) {
        NSString* filepath = [resourceBundle pathForResource:@"Time" ofType:@"png"];
        cell.imageView.image = [UIImage imageNamed:filepath];

    } else if (indexPath.row == 5) {
        NSString* filepath = [resourceBundle pathForResource:@"Camera_Small" ofType:@"png"];
        cell.imageView.image = [UIImage imageNamed:filepath];
        
    } else if (indexPath.row == 6) {
        NSString* filepath = [resourceBundle pathForResource:@"Yo" ofType:@"png"];
        cell.imageView.image = [UIImage imageNamed:filepath];
    }
    
    cell.textLabel.text = [titles objectAtIndex:indexPath.row];

    return cell;
}
@end
