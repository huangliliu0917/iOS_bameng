//
//  CustomResourceModel.h
//  bameng
//
//  Created by 罗海波 on 2016/12/30.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomResourceModel : NSObject


@property(nonatomic,copy)NSString * Addr;



@property(nonatomic,copy)NSString * CreateTime;


@property(nonatomic,copy)NSString *  DataImg;


@property(nonatomic,copy)NSString * Mobile;
@property(nonatomic,copy)NSString * Name;
@property(nonatomic,copy)NSString * Remark;

@property(nonatomic,copy)NSString * SubmitName;


@property(nonatomic,assign) int Type;
@property(nonatomic,assign) int UserId;



@end
