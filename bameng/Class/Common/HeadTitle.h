//
//  HeadTitle.h
//  bameng
//
//  Created by 罗海波 on 2017/1/5.
//  Copyright © 2017年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HeadTitleDelegate <NSObject>

- (void) HeadTitleDelegateWith:(int)item;


@end

@interface HeadTitle : UIView


+ (instancetype) HeadTitleCreate;


@property(nonatomic,strong) UIView * slideView;

@property (weak, nonatomic) IBOutlet UIView *secondredView;
@property (weak, nonatomic) IBOutlet UIView *firstRedView;
@property(nonatomic,weak) id <HeadTitleDelegate>  delegate;

- (void)slideviewToWithItem:(int) item;
@end
