//
//  AllyInfomationTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "AllyInfomationTableViewController.h"

@interface AllyInfomationTableViewController ()

@end

@implementation AllyInfomationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView removeSpaces];
    
    
    self.headImage.layer.cornerRadius = self.headImage.frame.size.height * 0.5;
    self.headImage.layer.masksToBounds = YES;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:_mengYouModel.UserHeadImg] placeholderImage:[UIImage imageNamed:@"mrtx"] options:SDWebImageRefreshCached];
    _account.text = _mengYouModel.LoginName;
    _nickName.text = _mengYouModel.NickName;
    _realName.text = _mengYouModel.RealName;
    _leave.text = _mengYouModel.LevelName;
    _postCustom.text = _mengYouModel.CustomerAmount;
    _ordor.text = [NSString stringWithFormat:@"%ld",(long)_mengYouModel.OrderSuccessAmount];
    _phone.text = _mengYouModel.UserMobile;
    _time.text = _mengYouModel.CreateTime;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
