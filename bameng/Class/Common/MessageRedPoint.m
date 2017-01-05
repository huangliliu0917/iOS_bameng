//
//  MessageRedPoint.m
//  bameng
//
//  Created by 罗海波 on 2017/1/5.
//  Copyright © 2017年 HT. All rights reserved.
//

#import "MessageRedPoint.h"

@implementation MessageRedPoint


- (instancetype)init{
    
    if (self = [super init]) {
        
        self.businessRemind = 0;
        self.messageCount = 0;
        self.messagePullCount = 0;
        self.messagePushCount = 0;
        
    }
    
    return self;
}

- (void)MessageRedWithDict:(NSDictionary *)dict{
    
    
    self.businessRemind = [dict[@"businessRemind"] intValue];
    self.messageCount = [dict[@"messageCount"] intValue];
    self.messagePullCount = [dict[@"messagePullCount"] intValue];
    self.messagePushCount = [dict[@"messagePushCount"] intValue];

    
}
@end
