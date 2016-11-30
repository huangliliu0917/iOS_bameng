//
//  MenDouBeanExchageLists.h
//  bameng
//
//  Created by lhb on 16/11/22.
//  Copyright © 2016年 HT. All rights reserved.
//  盟豆兑换流水

#import <Foundation/Foundation.h>

@interface MenDouBeanExchageLists : NSObject

@property(nonatomic,assign) int ID;
@property(nonatomic,strong) NSNumber *  money;
@property(nonatomic,copy) NSString  * remark;
/**0支出，1收入*/
@property(nonatomic,assign) int status;
@property(nonatomic,copy) NSString  * time;



@end
