//
//  location.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-22.
//  Copyright © 2017 翯. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol requestWeather <NSObject>
-(void)requestWeather:(NSString *)location;
@end

@interface location : NSObject
@property (nonatomic, weak) id<requestWeather> mydelegate;
-(void)requestLocation;
-(void)getCurrentLocation;
@end
