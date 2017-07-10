//
//  todayView.m
//  WOMAI single view
//
//  Created by 翯 on 2017-06-19.
//  Copyright © 2017 翯. All rights reserved.
//

#import "todayView.h"
@interface todayView() <UITextFieldDelegate>
@property NSString *windlevel;
@property NSString *lowTem;
@property NSString *highTem;
@property NSString *type;
@property NSString *windDir;
@property NSString *date;
@property NSString *temp;


@property temperatureView *tempLabel;
@property dateView *dateLabel;
@property FaFaAnimation *mainAnimate;
@property todayCellViewController *dayCell;
@property searchBar *searchBar;


@end

@implementation todayView

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.searchBar = [[searchBar alloc]initWithFrame:CGRectMake(self.frame.size.width/37.5f, self.frame.size.width/53.5714f, self.frame.size.width-2*(self.frame.size.width/37.5f), (self.frame.size.width/15.0f))];
        self.searchBar.delegate = self;
        
        self.tempLabel = [[temperatureView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2-(self.frame.size.height/13), self.frame.size.width/2, self.frame.size.width/2-(self.frame.size.height/27.95f))];
        
        self.dateLabel = [[dateView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 40, self.frame.size.width/2, self.frame.size.width/2)];
        
        self.dayCell = [[todayCellViewController alloc]initWithFrame:CGRectMake(0, (self.frame.size.height - self.frame.size.width/4 - (self.frame.size.height/56)), self.frame.size.width, self.frame.size.width/4)];
        
        // mainAnimate view should start right after dateLabel and end right before
        //    dayCell to provide max space for the animation
        float y =self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height;
        
        self.mainAnimate = [[FaFaAnimation alloc]initWithFrame:CGRectMake(self.frame.size.width/2, y, self.frame.size.width/2, (self.dayCell.frame.origin.y - (self.dateLabel.frame.origin.y+self.dateLabel.frame.size.height)))];
        
        UIImageView *background= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
        background.image = [UIImage imageNamed:@"background3"];
        [self addSubview:background];
        
        [self addSubview:self.tempLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.mainAnimate];
        [self addSubview:self.dayCell];
        
    }
    return self;
}

-(void) setModelandData:(NSDictionary *)data andTemp:(NSString *)temp andAqi:(NSString *) aqi andDate:(NSArray *)allday{
    //    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 200)];
    
    self.windlevel = [data valueForKey:@"fengli"];
    self.lowTem = [data valueForKey:@"low"];
    self.highTem = [data valueForKey:@"high"];
    self.type = [data valueForKey:@"type"];
    self.windDir = [data valueForKey:@"fengxiang"];
    self.date = [data valueForKey:@"date"];
    self.temp = temp;
    
    [self.tempLabel setModel:self.temp andType:self.type andAqi:aqi];
    [self.dateLabel setModel:aqi];
    [self.mainAnimate setModel];
    
    
//    NSDictionary *today = allday[0];
    NSMutableDictionary *today = [[NSMutableDictionary alloc]initWithDictionary:allday[0]];
    [today setValue:@"今天" forKey:@"date"];
    
    NSMutableDictionary *tomorrow = [[NSMutableDictionary alloc]initWithDictionary:allday[1]];
    [tomorrow setValue:@"明天" forKey:@"date"];
    
    [self.dayCell setModel:today and:tomorrow];
    [self addSubview:self.searchBar];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *searchCity = textField.text;
    [self.searchBar resignFirstResponder];
    [self.myDelegate requestWithNewCity:searchCity];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchBar resignFirstResponder];
}

//-(void) updateData:(NSDictionary *)data andTemp:(NSString *)temp andAqi:(NSString *)aqi{
//    
//}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
