//
//  weatherTableViewCell.h
//  FaFaWeatherStation
//
//  Created by 翯 on 2017-06-20.
//  Copyright © 2017 翯. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weatherTableViewCell : UITableViewCell
-(void)setModel:(NSDictionary *)dic;
-(id) initWithStyle:(UITableViewCellStyle) par reuseIdentifier:(nullable NSString *)reuse andHeight:(CGFloat)height;
@end
