//
//  OrderInfoModel.h
//  bameng
//
//  Created by lhb on 16/11/21.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfoModel : NSObject
/**手机号*/
@property(nonatomic,strong) NSString * mobile;

@property(nonatomic,strong) NSDecimalNumber * money;

@property(nonatomic,strong) NSString * orderId;

@property(nonatomic,strong) NSString * pictureUrl;

@property(nonatomic,assign) int status;

@property(nonatomic,strong) NSString * statusName;

@property(nonatomic,strong) NSString * remark;
@property(nonatomic,strong) NSString * userName;
@property(nonatomic,strong) NSString * note;
@property(nonatomic,assign) long ID;

@end
