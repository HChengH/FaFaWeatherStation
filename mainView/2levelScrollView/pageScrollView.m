//
//  pageScrollView.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-07-05.
//  Copyright © 2017 翯. All rights reserved.
//

#import "pageScrollView.h"
#import "weatherMainTableViewModel.h"
@interface pageScrollView()
@end

@implementation pageScrollView

-(id)initWithFrame:(CGRect)frame andOffset:(int)maxoffset{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.headerView = [[todayView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/2)];
        self.headerView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height/2 +maxoffset);
        self.headerView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.weatherController = [[weatherMainTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        
        self.weatherController.tableView.frame = CGRectMake(0, self.frame.size.height/2, self.frame.size.width, self.frame.size.height/2);
        
        [self addSubview:self.headerView];
        [self addSubview:self.weatherController.tableView];
    }
    return self;
}

-(void)setModel:(weatherMainTableViewModel *)data{
    [self.headerView setModelandData:data.nowData andTemp:data.temp andAqi:data.aqi andDate:data.allDays];
    [self.weatherController setModel:data.allDays];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
