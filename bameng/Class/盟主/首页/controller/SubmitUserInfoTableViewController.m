//
//  SubmitUserInfoTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SubmitUserInfoTableViewController.h"

@interface SubmitUserInfoTableViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (strong, nonatomic) IBOutlet UITextView *otherTextView;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation SubmitUserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.otherTextView.layer.borderWidth = 1;
    self.otherTextView.layer.borderColor = [UIColor blackColor].CGColor;
    
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
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"username"] = self.nameField.text;
    parme[@"mobile"] = self.phoneField.text;
    parme[@"address"] = self.addressField.text;
    parme[@"remark"] = self.otherTextView.text;
    
    [HTMyContainAFN AFN:@"customer/create" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {

            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
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

@end
