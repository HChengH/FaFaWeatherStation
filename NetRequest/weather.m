//
//  weather.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-22.
//  Copyright © 2017 翯. All rights reserved.
//

#import "weather.h"
#import "AFNetworking.h"

@interface weather()
@property NSString *rawWeatherURL;
@property NSDictionary *location;
@property NSDictionary *data;
@property NSDictionary *result;
@property AFHTTPSessionManager *manager;
@end

@implementation weather
-(id)initWithLocation:(NSString *)l{
    if(self = [super init]){
        self.rawWeatherURL = @"http://wthrcdn.etouch.cn/weather_mini";
        self.location = [NSDictionary dictionaryWithObjectsAndKeys:l, @"city", nil];
        self.manager = [AFHTTPSessionManager manager];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"image/jpeg",@"text/plain", nil];
    }
    return self;
}

-(void)requestWeather{
    [self.manager GET:self.rawWeatherURL parameters:self.location progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = [responseObject valueForKey:@"data"];
        
        weatherMainTableViewModel *model = [[weatherMainTableViewModel alloc]init];
        model.temp = [data valueForKey:@"wendu"];
        model.city = [data valueForKey:@"city"];
        model.aqi = [data valueForKey:@"aqi"];
        model.nowData = [data valueForKey:@"forecast"][0];
        model.allDays = [data valueForKey:@"forecast"];
        [self.mydelegate updateFields:model];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        sleep(2);   //re-connect
        self.result = nil;
        NSLog(@"错误");
    }];
}
@end
