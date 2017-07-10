//
//  weatherTableViewCell.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import "weatherTableViewCell.h"

@interface weatherTableViewCell()
@property UILabel *temp;
@property UILabel *date;
@property UILabel *type;
@property UILabel *wind;
@property UIImageView *typeImage;
@property UIImageView *background;
@end

@implementation weatherTableViewCell

-(id) initWithStyle:(UITableViewCellStyle) par reuseIdentifier:(nullable NSString *)reuse andHeight:(CGFloat)height{
    if(self = [super initWithStyle:par reuseIdentifier:reuse]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.5f];
        
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height);
        self.date = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/4.0f, height)];
        
        self.temp = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/4.0f, 0, self.frame.size.width/4.0f *2, height)];
        
        self.type = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/4.0f *3, 0, self.frame.size.width/4.0f, height/3.0f)];
        
        self.wind = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/3.0f *2, height/3.0f *2, self.frame.size.width/3.0f, height/3.0f)];
        
        self.typeImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/4.0f *3, height/3.0f, self.frame.size.width/4.0f, height/3.0f)];
        
        self.background = [[UIImageView alloc]initWithFrame:self.frame];
        
        self.date.textAlignment = NSTextAlignmentCenter;
        self.temp.textAlignment = NSTextAlignmentCenter;
        self.type.textAlignment = NSTextAlignmentCenter;
        self.wind.textAlignment = NSTextAlignmentCenter;
        
        self.date.textColor = [UIColor whiteColor];
        self.temp.textColor = [UIColor whiteColor];
        self.type.textColor = [UIColor whiteColor];
        self.wind.textColor = [UIColor whiteColor];
        
        self.date.font = [UIFont systemFontOfSize:self.frame.size.width/18.75f];
        self.temp.font = [UIFont systemFontOfSize:self.frame.size.width/12.5f];
        
        self.typeImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:self.background];
        [self addSubview:self.date];
        [self addSubview:self.type];
        [self addSubview:self.temp];
        [self addSubview:self.wind];
        [self addSubview:self.typeImage];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(NSDictionary *)dic{
    NSString *low = [dic valueForKey:@"low"];
    low = [low substringFromIndex:2];
    NSString *high = [dic valueForKey:@"high"];
    high = [high substringFromIndex:2];
    self.temp.text = [NSString stringWithFormat:@"%@/%@", low, high];
    
    NSString *date = [dic valueForKey:@"date"];
    date = [date substringWithRange:NSMakeRange(date.length-3, 3)];
    self.date.text = date;
    
    self.type.text = [dic valueForKey:@"type"];
    NSString *wind = [NSString stringWithFormat:@"%@ %@", [dic valueForKey:@"fengxiang"], [dic valueForKey:@"fengli"]];
    self.wind.text = wind;
    
    // make a model for this method
    if([self.type.text isEqualToString: @"多云"]){
        self.typeImage.image = [UIImage imageNamed:@"cloudy"];
        self.background.image = [UIImage imageNamed:@"cloudyBackground"];
    }
    else if([self.type.text isEqualToString:@"晴"]){
        self.typeImage.image = [UIImage imageNamed:@"sunny"];
        self.background.image = [UIImage imageNamed:@"sunnyBackground"];
    }
    else if([self.type.text isEqualToString:@"雷阵雨"]){
        self.typeImage.image = [UIImage imageNamed:@"thunderShower"];
        self.background.image = [UIImage imageNamed:@"rainBackground"];
    }
    else if([self.type.text isEqualToString:@"阴"]){
        self.typeImage.image = [UIImage imageNamed:@"overcast"];
        self.background.image = [UIImage imageNamed:@"overcastBackground"];
    }
    else if([self.type.text isEqualToString:@"中到大雨"] ||
            [self.type.text isEqualToString:@"大雨"]){
        self.typeImage.image = [UIImage imageNamed:@"heavyRain"];
        self.background.image = [UIImage imageNamed:@"rainBackground"];
    }
    else if([self.type.text isEqualToString:@"小雨"]){
        self.typeImage.image = [UIImage imageNamed:@"lightRain"];
        self.background.image = [UIImage imageNamed:@"rainBackground"];
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
