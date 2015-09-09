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

@end

@implementation ViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appIsReady:) name:@"app ready" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLogedIn:) name:@"login success" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MainSegue"]) {
    
    }
}

- (void)appIsReady:(NSNotification*)notification {
    [self performSegueWithIdentifier:@"MainSegue" sender:nil];
}

- (void)userLogedIn:(NSNotification*)notification {
    
}
@end
