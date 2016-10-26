//  1待结算盟豆  2积分流水
//  DaijiesuanTableViewCell.h
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DaijiesuanTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger pageTag;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@end
