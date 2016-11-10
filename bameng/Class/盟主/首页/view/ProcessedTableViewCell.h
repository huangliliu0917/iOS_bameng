//
//  ProcessedTableViewCell.h
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomInfomationModel.h"

@interface ProcessedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
//名字 盟友
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
//手机 兑换盟逗
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *review;

@property (nonatomic, assign) NSInteger selectPage;

@property (nonatomic, strong) CustomInfomationModel *customModel;

@property (nonatomic, strong) UserModel *mengyouModel;

@end
