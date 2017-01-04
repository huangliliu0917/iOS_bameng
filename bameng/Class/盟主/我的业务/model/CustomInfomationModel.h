//
//  CustomInfomationModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/9.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomInfomationModel : NSObject



/**
 Addr = fbm;
 BelongOne = 211858;
 BelongOneName = "\U98ce\U5149";
 BelongOneShopId = 0;
 BelongTwo = 211857;
 BelongTwoName = "\U6ee8\U76db\U5206\U5e97\U95e8\U4e3b1";
 CreateTime = "2016-12-06 11:50:56";
 DataImg = "http://bmadmin.51flashmall.com";
 ID = 76;
 InShop = 0;
 IsDel = 0;
 Mobile = 13222222222;
 Name = "ghj ";
 Remark = Can;
 ShopId = 4;
 ShopName = "\U6ee8\U76db\U8def\U5206\U5e97";
 Status = 1;
 isSave = 0;
 */
@property (nonatomic, strong) NSString *Addr;
@property (nonatomic, strong) NSNumber *BelongOne;
@property (nonatomic, strong) NSString *BelongOneName;
@property (nonatomic, strong) NSNumber *BelongTwo;
@property (nonatomic, strong) NSNumber *BelongOneShopId;
@property (nonatomic, strong) NSString *BelongTwoName;
@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *DataImg;
@property (nonatomic, assign) BOOL InShop;
@property (nonatomic, assign) BOOL IsDel;
@property (nonatomic, strong) NSString *Mobile;
@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Remark;
@property (nonatomic, strong) NSNumber *ShopId;
@property (nonatomic, strong) NSString *ShopName;
@property (nonatomic, assign) NSInteger Status;
@property (nonatomic, assign) int isSave;

@end
