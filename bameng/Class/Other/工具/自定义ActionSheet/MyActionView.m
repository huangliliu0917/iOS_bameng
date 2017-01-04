//
//  MyActionView.m
//  bameng
//
//  Created by 罗海波 on 2016/12/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyActionView.h"
#import "AddUserInfo.h"
#define WINDOW_COLOR     [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.25f

@interface MyActionView()<AddUserInfoDelegate>

@property(nonatomic,strong) UIView * backGroundView;

@end


@implementation MyActionView



- (instancetype)init{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        [self AddOption];
    }
    
    return self;
}




- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

#pragma mark - CreatButtonAndTitle method

- (void)AddOption{

    //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 140)];
    //    self.backGroundView.backgroundColor = [UIColor redColor];
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    [self addSubview:self.backGroundView];
    
    
    AddUserInfo * us = [AddUserInfo AddUserInfoShare];
    us.delegate = self;
    [self.backGroundView addSubview:us];
    
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-140, [UIScreen mainScreen].bounds.size.width, 140)];
    } completion:^(BOOL finished) {
    }];
}





- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        
        
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
//        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tappedBackGroundView
{
    //
}



- (void)AddUserInfoDelegate:(int)item{
    [self tappedCancel];
    if (item>0) {
        if ([self.delegate respondsToSelector:@selector(MyActionViewDelegate:)]) {
            [self.delegate MyActionViewDelegate:item];
        }
    }
    
}

@end
