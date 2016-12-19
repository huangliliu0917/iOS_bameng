//
//  BassModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/4.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BassModel : NSObject

@property (nonatomic, strong) NSString *aboutUrl;
@property (nonatomic, strong) NSString *agreementUrl;
@property (nonatomic, assign) NSInteger userStatus;
@property (nonatomic, assign) int enableSignIn;
@property (nonatomic, strong) NSString * registerUrl;

+ (instancetype)GetBassModel;

+ (void)BassModelSave:(BassModel *)model;

@end
