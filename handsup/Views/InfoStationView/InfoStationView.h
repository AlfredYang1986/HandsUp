//
//  InfoStationView.h
//  handsup
//
//  Created by Alfred Yang on 8/09/2015.
//  Copyright (c) 2015 BlackMirror. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoStationView : UIView

@property (nonatomic, weak) IBOutlet UISearchBar * searchBar;
@property (weak, nonatomic) IBOutlet UITableView *queryView;
@end
