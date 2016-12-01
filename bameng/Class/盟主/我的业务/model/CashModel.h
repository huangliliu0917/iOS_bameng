//
//  CashModel.h
//  bameng
//
//  Created by lhb on 16/11/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CashModel : NSObject
@property(nonatomic,assign) long ID;
@property(nonatomic,strong) NSString * due;
@property(nonatomic,strong) NSNumber * money;
@property(nonatomic,strong) NSString * name;

@property(nonatomic,strong) NSString *url;

@end
