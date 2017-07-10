//
//  loadingAnimationView.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-21.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadingAnimationView : UIView
-(void)setModelwithSize:(CGFloat)size;
-(void)endAnimation;
-(void)startAnimation;
@end
