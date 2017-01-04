//
//  SubmitUserInfoTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SubmitUserInfoTableViewController.h"
#import "SelectObjectViewController.h"

@interface SubmitUserInfoTableViewController ()<SelectObjectDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (strong, nonatomic) IBOutlet UITextView *otherTextView;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;


@property (weak, nonatomic) IBOutlet UILabel *mengyouids;

@property (weak, nonatomic) IBOutlet UIImageView *mengdian;


@property (nonatomic, copy) NSString * hasmengYouId;

@end

@implementation SubmitUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.otherTextView.layer.borderWidth = 0.8;
    
    self.otherTextView.layer.borderColor = LWColor(200, 199, 204).CGColor;
    [self.tableView removeSpaces];
    
    
    
    self.mengdian.tag = 100;
    
    self.sendButton.layer.masksToBounds = YES;
    self.sendButton.layer.cornerRadius = 5;
    
    [self.sendButton bk_whenTapped:^{
        [self sendButtonAction];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendButtonAction {
    if (self.nameField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入客户姓名"];
    }else if (self.phoneField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
    }else if (self.addressField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入客户地址"];
    }else {
        if (![self checkTel:self.phoneField.text]) {
            [SVProgressHUD showErrorWithStatus:@"请输入11位手机号"];
        }else {
            [self sendUserInfomation];
        }
        
    }
}

- (void)sendUserInfomation {
    
    if (!self.nameField.text.length) {
        [MBProgressHUD showError:@"用户名不能为空"];
        return;
    }else if (!self.phoneField.text.length) {
        [MBProgressHUD showError:@"电话不能为空"];
        return;
    }else if (!self.addressField.text.length) {
        [MBProgressHUD showError:@"地址不能为空"];
        return;
    }else{
        
        if (self.mengdian.tag == 101 && self.hasmengYouId.length == 0) {
            [MBProgressHUD showError:@"请选择盟友门店"];
            return;
        }
    }
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"username"] = self.nameField.text;
    parme[@"mobile"] = self.phoneField.text;
    parme[@"address"] = self.addressField.text;
    parme[@"remark"] = self.otherTextView.text;
    parme[@"issave"] = (self.mengdian.tag == 100 ? @(1) : @(0));
    parme[@"ids"] = self.hasmengYouId;
    [MBProgressHUD showMessage:nil];
    [HTMyContainAFN AFN:@"customer/addInfo" with:parme Success:^(NSDictionary *responseObject) {
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


/**
 *  验证手机号的正则表达式
 */
-(BOOL) checkTel:(NSString *) phoneNumber{
    NSString *regex = @"^(1)\\d{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            [self pickMengYou];
        }else{
            [self fenxiangMengdianp];
        }
    }
}


- (void)pickMengYou{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
    SelectObjectViewController *select = [story instantiateViewControllerWithIdentifier:@"SelectObjectViewController"];
    select.type = 1;
    select.delegate = self;
    [self.navigationController pushViewController: select animated:YES];
    
}

- (void)selectMengYou:(NSString *) mengYouId andName:(NSString *)names{
    
    LWLog(@"xxx%@",names);
    self.hasmengYouId = mengYouId;
    if (names.length) {
        self.mengyouids.text = names;
    }
    
}


- (void)fenxiangMengdianp{

    UIImageView * vc = self.mengdian;
    if (vc.tag == 100) {
        self.mengdian.hidden = YES;
        vc.tag = 101;
    }else{
        self.mengdian.hidden = NO;
        vc.tag = 100;
    }
}


@end
