//
//  OrderDetailModel.m
//  bameng
//
//  Created by lhb on 16/11/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "OrderDetailModel.h"

@implementation OrderDetailModel


- (void)setOrderTime:(NSString *)orderTime{
   
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH-mm"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:([orderTime doubleValue] / 1000.0)];
    NSString* dateString = [formatter stringFromDate:date];
    _orderTime = dateString;
   
}

- (NSString *)note{
    
    if (_note.length == 0) {
        return @"无";
    }
    
    return _note;
}
@end
