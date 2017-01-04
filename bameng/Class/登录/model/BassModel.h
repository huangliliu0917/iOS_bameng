//
//  BassModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/4.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BassModel : NSObject

@property (nonatomic, copy) NSString *aboutUrl;
@property (nonatomic, copy) NSString *agreementUrl;
@property (nonatomic, assign) NSInteger userStatus;
@property (nonatomic, assign) int enableSignIn;
@property (nonatomic, copy) NSString * registerUrl;
@property (nonatomic, copy) NSString * reportUrl;
+ (instancetype)GetBassModel;

+ (void)BassModelSave:(BassModel *)model;

@end
