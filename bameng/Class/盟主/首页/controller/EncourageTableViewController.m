//
//  EncourageTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "EncourageTableViewController.h"

@interface EncourageTableViewController ()
@property(nonatomic,strong) UIButton * btn;
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
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, KScreenHeight - 48, KScreenWidth, 48)];
    _btn = btn;
    [btn setBackgroundColor:LWColor(245, 77, 82)];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [self.view.window addSubview:btn];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self getMengYouEncourage];
    
   
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    btn.backgroundColor = [UIColor blueColor];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_btn removeFromSuperview];
    
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
            if(responseObject[@"data"] ){
                self.customLabel.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"CustomerReward"]];
                self.successMengDou.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"OrderReward"]];
                self.inShopMengDou.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"ShopReward"]];
                self.extraReward.text = [NSString stringWithFormat:@"%@", responseObject[@"data"][@"ExtraReward"]];
            }
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
    dic[@"extrareward"] = self.extraReward.text;
    
    LWLog(@"%@",dic);
    [HTMyContainAFN AFN:@"user/setallyRaward" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"user/setallyRaward：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"盟友奖励设置成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:ac];
            [self presentViewController:alertVC animated:YES completion:nil];
//            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 4) {
        return 0;
    }else{
         return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

@end
