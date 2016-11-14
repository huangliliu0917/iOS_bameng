//
//  HomeController.h
//  bameng
//
//  Created by 刘琛 on 16/10/21.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleBannerView.h"
#include "HomeHeadView.h"

@interface HomeController : MyViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;


@end
