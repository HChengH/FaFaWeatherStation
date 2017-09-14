//
//  weatherMainTableViewModel.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-22.
//  Copyright © 2017 翯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weatherMainTableViewModel : NSObject
@property NSString *temp;
@property NSString *city;
@property NSString *aqi;
@property NSDictionary *nowData;
@property NSArray *allDays;
@end
