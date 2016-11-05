//
//  UserModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/3.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, strong) NSString *CreateTime;
@property (nonatomic, strong) NSString *CustomerAmount;
@property (nonatomic, assign) NSInteger IsActive;
@property (nonatomic, strong) NSString *LevelName;
@property (nonatomic, strong) NSString *LoginName;
@property (nonatomic, strong) NSNumber *MengBeans;
@property (nonatomic, strong) NSNumber *MengBeansLocked;
@property (nonatomic, assign) NSInteger MerchantID;
@property (nonatomic, strong) NSString *NickName;
@property (nonatomic, assign) NSInteger OrderSuccessAmount;
@property (nonatomic, strong) NSString *RealName;
@property (nonatomic, strong) NSNumber *Score;
@property (nonatomic, strong) NSNumber *ScoreLocked;
@property (nonatomic, strong) NSString *ShopCity;
@property (nonatomic, assign) NSInteger ShopId;
@property (nonatomic, strong) NSString *ShopName;
@property (nonatomic, strong) NSString *ShopProv;
@property (nonatomic, strong) NSString *UserHeadImg;
@property (nonatomic, strong) NSString *UserId;
@property (nonatomic, assign) NSInteger UserIdentity;
@property (nonatomic, strong) NSString *UserMobile;
@property (nonatomic, strong) NSString *token;

@end
