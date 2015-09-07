//
//  ViewController.m
//  handsup
//
//  Created by Alfred Yang on 7/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate* app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app.mainController = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"HandsUp"]) {
    
    } else if ([segue.identifier isEqualToString:@"CatchUp"]) {
        
    }
}

- (IBAction)rigthBtnSelected {
    [self performSegueWithIdentifier:@"HandsUp" sender:nil];
}

- (IBAction)leftBtnSelected {
    [self performSegueWithIdentifier:@"CatchUp" sender:nil];
}
@end
