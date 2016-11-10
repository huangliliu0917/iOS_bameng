//  盟友信息已经审核过的
//  AllyInfomationTableViewController.h
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllyInfomationTableViewController : UITableViewController

@property (nonatomic, strong) UserModel *mengYouModel;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *account;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *realName;
@property (strong, nonatomic) IBOutlet UILabel *leave;
@property (strong, nonatomic) IBOutlet UILabel *sex;
@property (strong, nonatomic) IBOutlet UILabel *postCustom;
@property (strong, nonatomic) IBOutlet UILabel *ordor;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end
