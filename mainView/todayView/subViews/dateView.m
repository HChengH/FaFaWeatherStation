//
//  dateView.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import "dateView.h"
@interface dateView()
@property UILabel *airQuality;
@property UILabel *date;
@property UILabel *note;
@property UILabel *status;
@end

@implementation dateView

//const char **p[12];



-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.date = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 + (self.frame.size.width/9.375f), self.frame.size.width, (self.frame.size.width/3.125))];
        self.date.textAlignment = NSTextAlignmentCenter;
        self.date.font = [UIFont systemFontOfSize:(self.frame.size.width/12.5f)];
        
        self.airQuality = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/18.75f, self.frame.size.height/2 - (self.frame.size.width/6.25f), self.frame.size.width-(self.frame.size.width/9.375f), (self.frame.size.width/3.75f))];
        self.airQuality.textAlignment = NSTextAlignmentCenter;
        self.airQuality.font = [UIFont systemFontOfSize:(self.frame.size.width/9.375f)];
        
        [self addSubview:self.date];
        [self addSubview:self.airQuality];
    }
    return self;
}

-(NSString *)getDate{
    NSDate *now = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat =@"M月dd日";
    NSString *dateString = [format stringFromDate:now];
    return dateString;
}
-(NSString *)getNongli{
    NSDate *now = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    format.dateFormat =@"MM-dd";
    NSString *dateString = [format stringFromDate:now];
    NSDate *nonli = [format dateFromString:dateString];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:nonli];
    
    NSLog(@"%zd_%zd_%zd",localeComp.year,localeComp.month,localeComp.day);

    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"农历%@%@",m_str,d_str];
    
    return chineseCal_str;
}
-(void)setAqiLevel:(NSString *)aqi{
    if(!self.airQuality.text){
        [self setAqiLevelLabel];
    }
    
    NSInteger aqiValue = [aqi integerValue];
    float level = aqiValue/50.0 ;
    int result = ceil(level);
    NSString *levelString;
    UIColor *levelColor;
    NSRange length;
    
    const float x_position_ratio1 = self.frame.size.width/4.6875f;
    const float x_position_ratio2 = self.frame.size.width/18.75f;
    
    const float y_offset_ratio = self.frame.size.width/6.25f;
    
    const float width_ratio = self.frame.size.width/2.34375f;
    const float width_ratio2 = self.frame.size.width/9.375f;
    
    const float height_ratio = self.frame.size.width/3.75f;
    
    
    switch (result) {
        case 1:
            levelString = @"空气:优";
            levelColor  = [UIColor greenColor];
            length = NSMakeRange(3, 1);
            self.airQuality.frame = CGRectMake(x_position_ratio1, self.frame.size.height/2 - y_offset_ratio, self.frame.size.width-width_ratio, height_ratio);
            break;
        case 2:
            levelString = @"空气:良";
            levelColor  = [UIColor yellowColor];
            length = NSMakeRange(3, 1);
            self.airQuality.frame = CGRectMake(x_position_ratio1, self.frame.size.height/2 - y_offset_ratio, self.frame.size.width-width_ratio, height_ratio);
            break;
        case 3:
            levelString = @"空气:轻度污染";
            levelColor  = [UIColor orangeColor];
            length = NSMakeRange(3, 4);
            self.airQuality.frame = CGRectMake(x_position_ratio2, self.frame.size.height/2 - y_offset_ratio, self.frame.size.width-width_ratio2, height_ratio);
            break;
        case 4:
            levelString = @"空气:中度污染";
            levelColor  = [UIColor redColor];
            length = NSMakeRange(3, 4);
            self.airQuality.frame = CGRectMake(x_position_ratio2, self.frame.size.height/2 - y_offset_ratio, self.frame.size.width-width_ratio2, height_ratio);
            break;
        case 5:
            levelString = @"空气:重度污染";
            levelColor  = [UIColor purpleColor];
            length = NSMakeRange(3, 4);
            self.airQuality.frame = CGRectMake(x_position_ratio2, self.frame.size.height/2 - y_offset_ratio, self.frame.size.width-width_ratio2, height_ratio);
            break;
        case 6:
            levelString = @"空气:严重污染";
            levelColor  = [UIColor brownColor];
            length = NSMakeRange(3, 4);
            self.airQuality.frame = CGRectMake(x_position_ratio2, self.frame.size.height/2 - y_offset_ratio, self.frame.size.width-width_ratio2, height_ratio);
            break;
        default:
            levelString = @"";
            levelColor = [UIColor clearColor];
            length = NSMakeRange(0, 0);
            break;
    }
    NSMutableAttributedString *chineseLevel = [[NSMutableAttributedString alloc]initWithString:levelString];;
    [chineseLevel addAttribute:NSForegroundColorAttributeName value:levelColor range:length];
    
    self.airQuality.attributedText = chineseLevel;
}
-(void)setAqiLevelLabel{
    self.airQuality.layer.cornerRadius = self.frame.size.width/7.5f;
    self.airQuality.layer.masksToBounds = YES;
    self.airQuality.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5];
}
-(void)setModel:(NSString *)aqi{
    // self.backgroundColor = [UIColor lightGrayColor];
    self.date.text = [NSString stringWithFormat:@"%@", [self getDate]];
    [self setAqiLevel:aqi];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
