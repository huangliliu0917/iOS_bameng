//  我的账户页面（最外层）
//  MyAccountTableViewController.h
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
@property (strong, nonatomic) IBOutlet UILabel *nickName;
@property (strong, nonatomic) IBOutlet UILabel *Level;
@property (strong, nonatomic) IBOutlet UIImageView *setting;


@property (strong, nonatomic) IBOutlet UIView *mengdou;
@property (strong, nonatomic) IBOutlet UIView *daijiesuan;
@property (strong, nonatomic) IBOutlet UIView *keyongjifen;


@property (strong, nonatomic) IBOutlet UILabel *mengdouLable;
@property (strong, nonatomic) IBOutlet UILabel *daijiesuanLable;
@property (strong, nonatomic) IBOutlet UILabel *keyongjifenLable;

@end
