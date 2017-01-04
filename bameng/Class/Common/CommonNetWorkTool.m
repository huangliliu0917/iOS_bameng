//
//  CommonNetWorkTool.m
//  bameng
//
//  Created by 罗海波 on 2016/12/29.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CommonNetWorkTool.h"

@implementation CommonNetWorkTool

/**获取站内信*/
+ (void)CommonNetWorkToolGetInfo:(NewInfoParame *)model Success:(void (^)(NSArray<BMInfomationModel *> * arrays))success{
    NSMutableDictionary *parme = [model mj_keyValues];
    [HTMyContainAFN AFN:@"article/maillist" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray * data = [BMInfomationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            if (data.count) {
               success(data);
            }
            
            
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        
    }];
       
    
}


@end
