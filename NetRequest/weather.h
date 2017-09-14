//
//  weather.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-22.
//  Copyright © 2017 翯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weatherMainTableViewModel.h"

@protocol updateFields <NSObject>
-(void)updateFields:(weatherMainTableViewModel *)model;
//-(void)requestCancel;
@end

@interface weather : NSObject

@property NSInteger *tag;
@property (nonatomic, weak) id<updateFields>mydelegate;
-(id)initWithLocation:(NSString *)l;
-(void)requestWeather;
@end
