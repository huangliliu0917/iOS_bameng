//
//  CommonNetWorkTool.h
//  bameng
//
//  Created by 罗海波 on 2016/12/29.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewInfoParame.h"
#import "BMInfomationModel.h"


@interface CommonNetWorkTool : NSObject



/**获取站内信*/
+ (void)CommonNetWorkToolGetInfo:(NewInfoParame *)model Success:(void (^)(NSArray<BMInfomationModel *> * arrays))success;

@end
