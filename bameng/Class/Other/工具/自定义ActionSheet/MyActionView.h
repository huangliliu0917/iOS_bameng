//
//  MyActionView.h
//  bameng
//
//  Created by 罗海波 on 2016/12/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyActionViewDelegate <NSObject>

- (void)MyActionViewDelegate:(int)item;


@end


@interface MyActionView : UIView


- (void)showInView:(UIView *)view;

- (void)tappedCancel;



@property(nonatomic,weak) id <MyActionViewDelegate> delegate;

@end
