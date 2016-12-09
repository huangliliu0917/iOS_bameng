//
//  UntreatedTableViewCell.h
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomInfomationModel.h"
#import "DuiHuanModel.h"
#import "MeYouShenQingModel.h"

@interface UntreatedTableViewCell : UITableViewCell



@property (nonatomic, copy) void (^didSelectCustomInfo)(BOOL isAgree);


@property (nonatomic, strong) CustomInfomationModel *customModel;

@property (nonatomic, strong) DuiHuanModel * exchagemodel;

@property (nonatomic, strong) MeYouShenQingModel * MeYouShenQing;

@property (nonatomic, assign) NSInteger selectPage;
@end
