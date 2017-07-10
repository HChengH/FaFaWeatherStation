//
//  weatherMainTableViewController.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "todayView.h"
#import "weatherTableViewCell.h"
#import "weatherMainTableViewModel.h"

@protocol notifyScroll <NSObject>
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
@end

@interface weatherMainTableViewController : UITableViewController
@property (nonatomic, weak) id<notifyScroll> mydelegate;
-(void)setModel:(NSArray *)alldays;
@end
