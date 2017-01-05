//
//  MessageRedPoint.h
//  bameng
//
//  Created by 罗海波 on 2017/1/5.
//  Copyright © 2017年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageRedPoint : NSObject

@property(nonatomic,assign) int businessRemind;
@property(nonatomic,assign) int messageCount;
@property(nonatomic,assign) int messagePullCount;
@property(nonatomic,assign) int messagePushCount ;


- (void)MessageRedWithDict:(NSDictionary *)dict;

@end
