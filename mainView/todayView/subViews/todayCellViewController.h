//
//  todayCellViewController.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-26.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dayView.h"

@interface todayCellViewController : UIView
-(void)setModel:(NSDictionary *)today and:(NSDictionary *)tomorrow;
@end
