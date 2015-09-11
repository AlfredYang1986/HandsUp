//
//  HandsUpCreateController.m
//  handsup
//
//  Created by Alfred Yang on 9/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "HandsUpCreateController.h"
#import "AppDelegate.h"
#import "HandsUpModel.h"
#import "LoginModel.h"
#import "LoginToken.h"

@interface HandsUpCreateController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *dataPick;
@property (weak, nonatomic) IBOutlet UITextField *titleField;

@end

@implementation HandsUpCreateController

@synthesize dataPick = _dataPick;
@synthesize titleField = _titleField;
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneBtnSelected)];
   
    _dataPick.datePickerMode = UIDatePickerModeDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)doneBtnSelected {
    NSNumber* date = [NSNumber numberWithLongLong:[_dataPick.date timeIntervalSince1970] * 1000];
    NSString* title = _titleField.text;
    
    if (title != nil && title.length > 0) {
        AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
        NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
        [dic setObject:date forKey:@"date"];
        [dic setObject:title forKey:@"title"];
        [_delegate createHandsUpEventResult:[app.hm user:[app.lm getCurrentUserID] withToken:[app.lm getCurrentAuthToken] postHandsUpEvent:[dic copy]]];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        UIAlertView* view = [[UIAlertView alloc]initWithTitle:@"error" message:@"title cannot be empty" delegate:nil cancelButtonTitle:@"I know" otherButtonTitles:nil];
        [view show];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
