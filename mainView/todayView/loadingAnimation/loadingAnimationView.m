//
//  loadingAnimationView.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-21.
//  Copyright © 2017 翯. All rights reserved.
//

#import "loadingAnimationView.h"
@interface loadingAnimationView()
@property (nonatomic, strong)UIImageView *gifImageView;
@end

@implementation loadingAnimationView

-(void)setModelwithSize:(CGFloat)size{
    self.gifImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, size, size)];
    self.gifImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    self.gifImageView.layer.masksToBounds = YES;
    self.gifImageView.layer.cornerRadius = size/2;
    
    [self addSubview:self.gifImageView];
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i=0; i < 6; ++i) {
        [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"FaFaloading%d",i]]];
    }
    self.gifImageView.animationImages = images;
    self.gifImageView.animationDuration = 0.65;
    self.gifImageView.animationRepeatCount = NSUIntegerMax;
    [self.gifImageView startAnimating];
}

-(void)endAnimation{
    [self.gifImageView stopAnimating];
}

-(void)startAnimation{
    [self.gifImageView startAnimating];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
