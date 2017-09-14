//
//  searchBar.m
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-29.
//  Copyright © 2017 翯. All rights reserved.
//

#import "searchBar.h"

@implementation searchBar

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
//        self.searchBar = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        self.borderStyle = UITextBorderStyleNone;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = self.frame.size.width/28.4f;
        
        self.backgroundColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.5f];
        self.placeholder = @"输入城市名关键词查找天气";
        self.textAlignment = NSTextAlignmentCenter;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.clearsOnBeginEditing = YES;
        self.returnKeyType = UIReturnKeySearch;
        self.enabled = YES;
        
//        self.delegate = self;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
