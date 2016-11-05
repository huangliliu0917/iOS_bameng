//
//  VersionModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/4.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionModel : NSObject

@property (nonatomic, strong) NSString *serverVersion;
@property (nonatomic, strong) NSString *updateTip;
@property (nonatomic, strong) NSNumber *updateType;
@property (nonatomic, strong) NSString *updateUrl;

@end
