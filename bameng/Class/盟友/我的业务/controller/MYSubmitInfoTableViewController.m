//
//  MYSubmitInfoTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/1.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYSubmitInfoTableViewController.h"

@interface MYSubmitInfoTableViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextView *remarks;
@property (weak, nonatomic) IBOutlet UIButton *submitbtn;
@property (weak, nonatomic) IBOutlet UILabel *firstLable;
@property (weak, nonatomic) IBOutlet UILabel *secondLable;
@property (weak, nonatomic) IBOutlet UILabel *thredLable;


@property (weak, nonatomic) IBOutlet UILabel *forthLable;



@end

@implementation MYSubmitInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.submitbtn.layer.cornerRadius = 5;
    self.submitbtn.layer.masksToBounds = YES;
    
    self.phone.delegate = self;
    
    
//    self.remarks.layer.borderWidth= 0.7;
//    self.remarks.layer.borderColor = LWColor(239, 239, 244).CGColor;
    
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/GetAllyReward" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 200) {
            self.firstLable.text = [NSString stringWithFormat:@"1.每条成交的订单可获得%@盟豆奖励",responseObject[@"data"][@"OrderReward"]];
            self.secondLable.text = [NSString stringWithFormat:@"2.每条成功提交的信息可获得%@盟豆奖励",responseObject[@"data"][@"CustomerReward"]];
            self.thredLable.text = [NSString stringWithFormat:@"3.客户上门%@盟豆奖励",responseObject[@"data"][@"ShopReward"]];
            
            NSString * fortha =  [NSString stringWithFormat:@"%@",responseObject[@"data"][@"ExtraReward"]];
            if (fortha.length) {
                self.forthLable.text = [NSString stringWithFormat:@"4.额外奖励设置:%@",fortha];
            }else{
                self.forthLable.hidden = YES;
            }
            
            
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    
    if (textField == self.phone) {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 11;
    }
    
    return YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)sendUserInfomation {
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"username"] = self.name.text;
    parme[@"mobile"] = self.phone.text;
    parme[@"address"] = self.address.text;
    parme[@"remark"] = self.remarks.text;
    [MBProgressHUD showMessage:nil];
    [HTMyContainAFN AFN:@"customer/create" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 200) {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"客户信息提交成功" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertVC addAction:ac];
            [self presentViewController:alertVC animated:YES completion:nil];
            
        }else{
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"客户信息提交失败" message:responseObject[@"statusText"] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVC addAction:ac];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];
    
}



- (IBAction)submitClick:(id)sender {
    
    
    
    if (self.name.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入客户姓名"];
    }else if (self.phone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
    }else if (self.address.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入客户地址"];
    }else {
       
        [self sendUserInfomation];
      
        
    }
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 变高行数
   
    if (indexPath.row == 3) {
        
        return 0;
        
    } else {
        /** 返回静态单元格故事板中的高度 */
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
