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

@end

@implementation MYSubmitInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.submitbtn.layer.cornerRadius = 5;
    self.submitbtn.layer.masksToBounds = YES;
    
    self.phone.delegate = self;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phone) {
        if (textField.text.length > 10) return NO;
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
