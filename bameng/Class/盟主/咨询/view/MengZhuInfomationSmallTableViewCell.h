//
//  MengZhuInfomationSmallTableViewCell.h
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMInfomationModel.h"

@interface MengZhuInfomationSmallTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *cover;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *intro;
@property (strong, nonatomic) IBOutlet UILabel *browseAmout;
@property (strong, nonatomic) IBOutlet UILabel *time;

@property (nonatomic, strong) BMInfomationModel *model;
@end
