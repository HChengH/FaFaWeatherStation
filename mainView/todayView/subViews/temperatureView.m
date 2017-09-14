//
//  temperatureView.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import "temperatureView.h"
@interface temperatureView()
@property UILabel *temperature;
@property UILabel *type;
@property UILabel *aqi;
@end

@implementation temperatureView

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.type = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/18.75f, 0, self.frame.size.width/2, self.frame.size.height/3)];
        
        self.temperature = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        self.aqi = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/9.5f, self.frame.size.height/3 *2 +self.frame.size.height/16.75f, self.frame.size.width-self.frame.size.width/4.68f, self.frame.size.height/8.375f)];
        
        self.type.font = [UIFont systemFontOfSize:(self.frame.size.width/8.5f)];
        
        self.temperature.font = [UIFont systemFontOfSize:(self.frame.size.width/2.88f)];
        self.temperature.textAlignment = NSTextAlignmentCenter;
        
        self.aqi.font = [UIFont systemFontOfSize:(self.frame.size.width/12.5f)];
        self.aqi.textAlignment = NSTextAlignmentCenter;
        
        
        [self addSubview:self.type];
        [self addSubview:self.temperature];
        [self addSubview:self.aqi];
    }
    return self;
}

-(void)setAqiLabel{
    self.aqi.layer.masksToBounds = YES;
    self.aqi.layer.cornerRadius = self.frame.size.width/18.75f;
    self.aqi.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5];
}

-(void)setModel:(NSString *)temperature andType:(NSString *)type andAqi:(NSString *)aqi{
    self.temperature.text = [NSString stringWithFormat:@"%@°", temperature];
    self.type.text = type;
    if(!self.aqi.text){
        [self setAqiLabel];
    }
    self.aqi.text = [NSString stringWithFormat:@"污染指数:%@ ", aqi];
    //self.backgroundColor = [UIColor lightGrayColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
