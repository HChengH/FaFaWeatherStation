//
//  todayCellViewController.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-26.
//  Copyright © 2017 翯. All rights reserved.
//

#import "todayCellViewController.h"

@interface todayCellViewController ()
@property dayView *today;
@property dayView *tomorrow;
@end

@implementation todayCellViewController

-(id) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.today = [[dayView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/2-1, self.frame.size.height)];
        self.tomorrow = [[dayView alloc]initWithFrame:CGRectMake(self.frame.size.width/2+1, 0, self.frame.size.width/2-1, self.frame.size.height)];
      
        [self addSubview:self.today];
        [self addSubview:self.tomorrow];
    }
    return self;
}

-(void)setModel:(NSDictionary *)today and:(NSDictionary *)tomorrow{
    [self.today setModel:today];
    [self.tomorrow setModel:tomorrow];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
