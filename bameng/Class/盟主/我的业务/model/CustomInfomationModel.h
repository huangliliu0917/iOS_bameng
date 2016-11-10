//
//  CustomInfomationModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/9.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomInfomationModel : NSObject

@property (nonatomic, strong) NSString *Addr;
@property (nonatomic, strong) NSNumber *BelongOne;
@property (nonatomic, strong) NSString *BelongOneName;
@property (nonatomic, strong) NSNumber *BelongTwo;
@property (nonatomic, strong) NSString *BelongTwoName;
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, assign) BOOL InShop;
@property (nonatomic, assign) BOOL IsDel;
@property (nonatomic, strong) NSString *Mobile;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Remark;
@property (nonatomic, strong) NSNumber *ShopId;
@property (nonatomic, strong) NSString *ShopName;
@property (nonatomic, assign) NSInteger Status;


@end
