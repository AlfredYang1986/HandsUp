//
//  InfoStationMySchool.h
//  handsup
//
//  Created by Alfred Yang on 8/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InfoStationMySchool : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* queryData;
@end
