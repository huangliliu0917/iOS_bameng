//
//  DuiHuanModel.m
//  bameng
//
//  Created by lhb on 16/11/23.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "DuiHuanModel.h"

@implementation DuiHuanModel

- (void)setTime:(NSString *)time{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:([time doubleValue] / 1000.0)];
    NSString* dateString = [formatter stringFromDate:date];
    _time = dateString;
    
}

@end
