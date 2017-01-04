//
//  WorkModel.h
//  bameng
//
//  Created by 罗海波 on 2017/1/3.
//  Copyright © 2017年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkModel : NSObject

@property(nonatomic,assign) id ID;
@property(nonatomic,copy) NSString * reportTitle;
@property(nonatomic,copy) NSString * reportUrl;
@property(nonatomic,copy) NSString *  time;

@end
