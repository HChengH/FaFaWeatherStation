//
//  pageScrollViewController.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-07-05.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol updateCity <NSObject>
-(void)updateCity:(NSString *)city;
-(void)didSearchNewCity:(NSString *)newCity;
@end

@interface pageScrollViewController : UIViewController
@property(nonatomic, weak) id<updateCity> mydelegate;
@property NSString *cityName;
-(id)initWithStaticLocation:(NSString *)location;
@end
