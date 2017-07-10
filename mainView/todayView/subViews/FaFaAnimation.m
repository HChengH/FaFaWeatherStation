//
//  FaFaAnimation.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import "FaFaAnimation.h"
@interface FaFaAnimation()
@property UIImageView *gifImageView;
@end

@implementation FaFaAnimation
-(id) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
//        UIImageView *gifImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        gifImageView.center = self.center;
//        self.gifImageView = gifImageView;
//        [self addSubview:self.gifImageView];
    }
    return self;
}

-(void)setModel{
//    self.gifImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
//    self.gifImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
//    
//    [self addSubview:self.gifImageView];
//    
//    NSMutableArray *images = [NSMutableArray array];
//    for (int i=0; i < 6; ++i) {
//        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i]]];
//    }
//    self.gifImageView.animationImages = images;
//    self.gifImageView.animationDuration = 0.5;
//    self.gifImageView.animationRepeatCount = NSUIntegerMax;
//    [self.gifImageView startAnimating];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
