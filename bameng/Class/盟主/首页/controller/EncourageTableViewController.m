//
//  EncourageTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "EncourageTableViewController.h"

@interface EncourageTableViewController ()

@end

@implementation EncourageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.cornerRadius = 5;
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    
    [self.saveButton bk_whenTapped:^{
        [self sendMengYouEncourage];
    }];
    
    [self.view bk_whenTapped:^{
        [self.view endEditing:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    [self getMengYouEncourage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getMengYouEncourage  {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [HTMyContainAFN AFN:@"user/GetAllyReward" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"article/list：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {

            LWLog(@"%@",responseObject);
            self.customLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"CustomerReward"]];
            self.successMengDou.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"OrderReward"]];
            self.inShopMengDou.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"ShopReward"]];
        }

    } failure:^(NSError *error) {
        LWLog(@"%@", error);

    }];
    
}

- (void)sendMengYouEncourage {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"creward"] = self.customLabel.text;
    dic[@"orderreward"] = self.successMengDou.text;
    dic[@"shopreward"] = self.inShopMengDou.text;
    [HTMyContainAFN AFN:@"user/setallyRaward" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"user/setallyRaward：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"奖励设置成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:ac];
            [self presentViewController:alertVC animated:YES completion:nil];
//            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        
    }];
}


@end
