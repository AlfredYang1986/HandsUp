//
//  InfoStationMySchool.m
//  handsup
//
//  Created by Alfred Yang on 8/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import "InfoStationMySchool.h"

@implementation InfoStationMySchool

@synthesize queryData = _queryData;

#pragma mark -- table view delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark -- table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"default"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"default"];
    }
    
    cell.textLabel.text = @"alfred";
    
    return cell;
}

@end
