//
//  DuiHuanModel.h
//  bameng
//
//  Created by lhb on 16/11/23.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DuiHuanModel : NSObject

@property(nonatomic,assign) long ID;
@property(nonatomic,strong) NSString * headimg;
@property(nonatomic,strong) NSNumber * money;

@property(nonatomic,strong) NSString * name;
@property(nonatomic,assign) int status;
@property(nonatomic,strong) NSString * time;


@end


