//
//  SexPick.h
//  bameng
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SexPickDelegate <NSObject>


/*
 *
 1000男
 1002女
 1003取消
 */
- (void)SexPickDelegate:(NSInteger)item;

@end

@interface SexPick : UIView


+ (instancetype)SexPickShare;


@property(nonatomic,weak) id <SexPickDelegate> delegate;


@end
