//
//  OrderDetailModel.h
//  bameng
//
//  Created by lhb on 16/11/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property(nonatomic,strong) NSString * address;

@property(nonatomic,strong) NSNumber * cashcouponmoney;
@property(nonatomic,strong) NSNumber *  fianlamount;

@property(nonatomic,strong) NSString * mobile;
@property(nonatomic,strong) NSString * note ;
@property(nonatomic,strong) NSString * orderId;
@property(nonatomic,strong) NSString * orderTime;
@property(nonatomic,strong) NSString * pictureUrl;
@property(nonatomic,strong) NSString * remark;
@property(nonatomic,assign) int  status;
@property(nonatomic,strong) NSString * successUrl;
@property(nonatomic,strong) NSString * userName;
@end


