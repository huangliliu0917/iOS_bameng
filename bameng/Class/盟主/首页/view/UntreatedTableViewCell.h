//
//  UntreatedTableViewCell.h
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomInfomationModel.h"


@interface UntreatedTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UIButton *agreeButtom;
@property (strong, nonatomic) IBOutlet UIButton *refuseButtom;
//名字： 盟友
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

//手机：兑换盟逗
@property (strong, nonatomic) IBOutlet UILabel *phoneLabe;

@property (nonatomic, assign) NSInteger selectPage;
@property (strong, nonatomic) IBOutlet UILabel *reviewLabel;

@property (nonatomic, strong) CustomInfomationModel *customModel;



@end
