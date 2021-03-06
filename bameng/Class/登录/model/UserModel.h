//
//  UserModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/3.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject


@property (nonatomic, strong) NSNumber * BelongOne;
@property (nonatomic, strong) NSString * BelongOneUserName;

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

/**1 盟主  0 盟友*/
@property (nonatomic, assign) NSInteger UserIdentity;
@property (nonatomic, strong) NSString *UserMobile;
/**性别*/
@property (nonatomic, strong) NSString * UserGender;
/**城市*/
@property (nonatomic, strong) NSString * UserCity;
@property (nonatomic, strong) NSString *token;

/**1 总店  2 分店*/
@property (nonatomic, assign)  int ShopType;
/**待结算盟豆*/
@property (nonatomic, strong) NSNumber * TempMengBeans;

/**我的二维码*/
@property (nonatomic, strong) NSString *  myqrcodeUrl;

/**分享二维码*/
@property (nonatomic, strong) NSString *  myShareQrcodeUrl;
+ (instancetype) GetUserModel;

+ (void)SaveUserModel:(UserModel *)user;
@end
