//
//  todayView.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "temperatureView.h"
#import "dateView.h"
#import "FaFaAnimation.h"
#import "todayCellViewController.h"
#import "searchBar.h"

@protocol searchCity <NSObject>
-(void)requestWithNewCity:(NSString *)city;
@end

@interface todayView : UIScrollView
@property (nonatomic, weak) id<searchCity> myDelegate;
-(void)setModelandData:(NSDictionary *)data andTemp:(NSString *)temp andAqi:(NSString *)aqi andDate:(NSArray *)allday;
-(id)initWithFrame:(CGRect)frame;
//-(void) updateData:(NSDictionary *)data andTemp:(NSString *)temp andAqi:(NSString *)aqi andDate:(NSArray *)allday;
@end
