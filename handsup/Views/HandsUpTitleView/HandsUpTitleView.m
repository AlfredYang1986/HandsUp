//
//  HandsUpTitleView.m
//  handsup
//
//  Created by Alfred Yang on 8/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "HandsUpTitleView.h"

@interface HandsUpTitleView ()
@property (weak, nonatomic) IBOutlet UIButton *funcBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;

@end

@implementation HandsUpTitleView

@synthesize funcBtn = _funcBtn;
@synthesize plusBtn = _plusBtn;

@synthesize delegate = _delegate;

+ (CGFloat)perferredHeight {
    return 115;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"HandsUpBoundle" ofType :@"bundle"];
    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString* filepath = [resourceBundle pathForResource:@"Plus_Big" ofType:@"png"];
    [_plusBtn setBackgroundImage:[UIImage imageNamed:filepath] forState:UIControlStateNormal];
    _plusBtn.layer.borderColor = [UIColor blueColor].CGColor;
    _plusBtn.layer.borderWidth = 1.f;
    _plusBtn.layer.cornerRadius = 25.f;
    _plusBtn.clipsToBounds = YES;
    
    [_plusBtn addTarget:self action:@selector(plusBtnTouchUp) forControlEvents:UIControlEventTouchUpInside];
    
    NSString* funcPath =[resourceBundle pathForResource:@"Setting" ofType:@"png"];
    [_funcBtn setBackgroundImage:[UIImage imageNamed:funcPath] forState:UIControlStateNormal];

    [_funcBtn addTarget:self action:@selector(settingBtnTouchUp) forControlEvents:UIControlEventTouchUpInside];
}

- (void)plusBtnTouchUp {
    [_delegate plusBtnSelected];
}

- (void)settingBtnTouchUp {
    [_delegate settingBtnSelected];
}
@end
