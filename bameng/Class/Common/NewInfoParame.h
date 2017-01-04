//
//  NewInfoParame.h
//  bameng
//
//  Created by 罗海波 on 2016/12/29.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewInfoParame : NSObject


@property(nonatomic,assign) long pageIndex;
@property(nonatomic,assign) long pageSize;

/**1 发送消息  2接受消息*/
@property(nonatomic,assign) int type;
/**1 发送消息  0 接受消息*/
@property(nonatomic,assign) int isSend;


+(instancetype)NewInfoParameWithDict:(NSMutableDictionary *)dict;

@end
