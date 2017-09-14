//
//  pageScrollView.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-07-05.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "todayView.h"
#import "weatherMainTableViewController.h"

@interface pageScrollView : UIView
@property todayView *headerView;
@property weatherMainTableViewController *weatherController;
@property int contentSize;
-(id)initWithFrame:(CGRect)frame andOffset:(int)maxoffset;
-(void)setModel:(weatherMainTableViewModel *)data;
@end
