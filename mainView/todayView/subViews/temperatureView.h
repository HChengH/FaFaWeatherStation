//
//  temperatureView.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface temperatureView : UIView
-(void)setModel:(NSString *)temperature andType:(NSString *)type andAqi:(NSString *)aqi;
@end
