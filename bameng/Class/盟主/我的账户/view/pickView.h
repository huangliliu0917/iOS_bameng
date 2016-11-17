//
//  pickView.h
//  bameng
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol pickViewDelegate <NSObject>

/*
 *
 100
 101
 103 取消
 */
- (void)pickViewOption:(NSInteger)item;


@end


@interface pickView : UIView
+ (instancetype)pickViewShare;

@property(nonatomic,weak) id <pickViewDelegate> delegate;






@end
