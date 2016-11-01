//
//  HomeHeadView.h
//  bameng
//
//  Created by 刘琛 on 16/10/21.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleBannerView.h"


@interface HomeHeadView : UIView<CircleBannerViewDelegate>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *circulateHeight;

@property (strong, nonatomic) IBOutlet UIView *circulateView;

@property (strong, nonatomic) IBOutlet UIView *zhanghu;
@property (strong, nonatomic) IBOutlet UIView *neworder;
@property (strong, nonatomic) IBOutlet UIView *custom;
@property (strong, nonatomic) IBOutlet UIView *coalition;
@property (strong, nonatomic) IBOutlet UIView *exchange;
@property (strong, nonatomic) IBOutlet UIView *reward;
@property (strong, nonatomic) IBOutlet UIView *moreNews;



@end
