//
//  HandsUpTitleView.h
//  handsup
//
//  Created by Alfred Yang on 8/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HandsUpTitleViewProtocol <NSObject>

- (void)settingBtnSelected;
- (void)plusBtnSelected;
@end

@interface HandsUpTitleView : UIView

@property (nonatomic, weak) id<HandsUpTitleViewProtocol> delegate;

+ (CGFloat)perferredHeight;
@end
