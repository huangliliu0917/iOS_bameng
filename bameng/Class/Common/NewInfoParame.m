//
//  NewInfoParame.m
//  bameng
//
//  Created by 罗海波 on 2016/12/29.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "NewInfoParame.h"

@implementation NewInfoParame


+(instancetype)NewInfoParameWithDict:(NSMutableDictionary *)dict{
    NewInfoParame * parame = [[self alloc] init];
    parame.pageIndex = [[dict objectForKey:@"pageIndex"] longValue];
    parame.pageSize = [[dict objectForKey:@"pageSize"] longValue];
    parame.type = [[dict objectForKey:@"type"] intValue];
    parame.isSend = [[dict objectForKey:@"isSend"] intValue];
    return parame;
}
@end
