//
//  dayView.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-26.
//  Copyright © 2017 翯. All rights reserved.
//

#import "dayView.h"
@interface dayView()
@property UILabel *date;
@property UILabel *type;
@property UILabel *temp;
@property UIImageView *typeImage;
@end

@implementation dayView

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        // The following ratios if use for different devices with different resolution
        const float ratioFor5 = self.frame.size.width/37.3f;
        const float ratioFor25 = self.frame.size.width/7.46f;
        const float ratioFor17_5 = self.frame.size.width/10.657f;
        //const float ratioFor10 = self.frame.size.width/18.65f;
        const float ratioForFontSize = self.frame.size.width/10.361f;
        
        self.date = [[UILabel alloc]initWithFrame:CGRectMake(ratioFor5, 0, self.frame.size.width/2-ratioFor25-ratioFor5, self.frame.size.height/2)];
        
        self.type = [[UILabel alloc]initWithFrame:CGRectMake(ratioFor5, self.frame.size.height/2, self.frame.size.width/2-ratioFor5-ratioFor17_5, self.frame.size.height/2)];
        
        self.temp = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-ratioFor25, 0, self.frame.size.width/2+ratioFor25 - ratioFor5, self.frame.size.height/2)];
        
        self.typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-ratioFor17_5, self.frame.size.height/2-ratioFor5, self.frame.size.width/2-ratioFor5+ratioFor17_5, self.frame.size.height/2)];
        
        self.date.textColor = [UIColor whiteColor];
        self.type.textColor = [UIColor whiteColor];
        self.temp.textColor = [UIColor whiteColor];
        
        self.date.textAlignment = NSTextAlignmentLeft;
        self.type.textAlignment = NSTextAlignmentLeft;
        self.temp.textAlignment = NSTextAlignmentLeft;
        
        self.date.font = [UIFont systemFontOfSize:ratioForFontSize];
        self.type.font = [UIFont systemFontOfSize:ratioForFontSize];
        self.temp.font = [UIFont systemFontOfSize:ratioForFontSize];
        
        [self addSubview:self.date];
        [self addSubview:self.type];
        [self addSubview:self.temp];
        [self addSubview:self.typeImage];
    }
    return self;
}

-(void)setModel:(NSDictionary *)model{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    self.date.text = [model valueForKey:@"date"];
    NSString *low = [model valueForKey:@"low"];
    low = [low substringFromIndex:2];
    
    NSString *high = [model valueForKey:@"high"];
    high = [high substringFromIndex:2];
    self.temp.text = [NSString stringWithFormat:@"%@/%@", low, high];
    self.type.text = [model valueForKey:@"type"];
    
    if([self.type.text isEqualToString: @"多云"]){
        self.typeImage.image = [UIImage imageNamed:@"cloudy"];
    }
    else if([self.type.text isEqualToString:@"晴"]){
        self.typeImage.image = [UIImage imageNamed:@"sunny"];
    }
    else if([self.type.text isEqualToString:@"雷阵雨"]){
        self.typeImage.image = [UIImage imageNamed:@"thunderShower"];
    }
    else if([self.type.text isEqualToString:@"阴"]){
        self.typeImage.image = [UIImage imageNamed:@"overcast"];
    }
    else if([self.type.text isEqualToString:@"中到大雨"] ||
            [self.type.text isEqualToString:@"大雨"]||
            [self.type.text isEqualToString:@"阵雨"]||
            [self.type.text isEqualToString:@"中雨"]||
            [self.type.text isEqualToString:@"中到大雨"]){
        self.typeImage.image = [UIImage imageNamed:@"heavyRain"];
    }
    else if([self.type.text isEqualToString:@"小雨"]||
            [self.type.text isEqualToString:@"小到中雨"]){
        self.typeImage.image = [UIImage imageNamed:@"lightRain"];
    }
    
    self.typeImage.contentMode = UIViewContentModeScaleAspectFit;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
