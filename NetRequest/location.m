//
//  location.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-22.
//  Copyright © 2017 翯. All rights reserved.
//

#import "location.h"
#import <CoreLocation/CoreLocation.h>

@interface location() <CLLocationManagerDelegate>
@property (nonatomic, strong)CLLocationManager *manager;
@property (nonatomic, strong)CLGeocoder *geoCoder;
@property NSString *location;
@end

@implementation location
-(id)init{
    if(self = [super init]){
        self.manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyBest;
        self.manager.distanceFilter = 1000;
        
        self.geoCoder = [[CLGeocoder alloc]init];
    }
    return self;
}

-(void)requestLocation{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if(status == kCLAuthorizationStatusNotDetermined){
        if([self.manager respondsToSelector:@selector(requestAlwaysAuthorization)]){
            [self.manager requestAlwaysAuthorization];
        }
    }
    [self.manager startUpdatingLocation];
    
}

-(void)reverseGeoCode:(CLLocation *)location{
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error || placemarks.count == 0){
            NSLog(@"无法找到");
        }
        else{
            CLPlacemark *locationMark = placemarks.firstObject;
            NSDictionary *data = locationMark.addressDictionary;
            self.location = locationMark.locality;
            if(!self.location){
                self.location = [data valueForKey:@"State"];
            }
            [self.manager stopUpdatingLocation];
            [self.mydelegate requestWeather:self.location];
        }
    }];
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *currentlocation = [locations lastObject];
    [self reverseGeoCode:currentlocation];
}

-(void)getCurrentLocation{
    [self requestLocation];
}
@end
