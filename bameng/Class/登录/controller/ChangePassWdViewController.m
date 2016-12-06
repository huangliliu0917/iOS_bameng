//
//  ChangePassWdViewController.m
//  bameng
//
//  Created by lhb on 16/11/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ChangePassWdViewController.h"
#import "LoginController.h"

@interface ChangePassWdViewController ()

@property (weak, nonatomic) IBOutlet UITextField *currentPasswd;

@property (weak, nonatomic) IBOutlet UITextField *currentPasswdNew;

@property (weak, nonatomic) IBOutlet UITextField *currentPasswdNewone;
@end

@implementation ChangePassWdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改密码";
    // Do any additional setup after loading the view.
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveClick:(id)sender {
    
    
    
    if (!self.currentPasswd.text.length) {
        
        [self showErrorWithTitle:@"当前密码为空" autoCloseTime: 1.5];
        return;
    }
    if (!self.currentPasswdNew.text.length || !self.currentPasswdNewone.text.length) {
        
        [self showErrorWithTitle:@"新前密码为空" autoCloseTime: 1.5];
        return;
    }
    
    if (![self.currentPasswdNew.text isEqualToString:self.currentPasswdNewone.text]) {
        [self showErrorWithTitle:@"密码不一致" autoCloseTime: 1.5];
        return;
    }
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"oldPassword"] = [AsignLibrary md5by32:self.currentPasswd.text];
    parme[@"newPassword"] = [AsignLibrary md5by32:self.currentPasswdNew.text];
    [HTMyContainAFN AFN:@"user/ChanagePassword" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if([responseObject[@"status"] integerValue] == 200){
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"修改密码成功" message:@"请重新登录帐号" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginController *login = [story instantiateViewControllerWithIdentifier:@"LoginController"];
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            }];
            [alertVC addAction:ac];
            [self presentViewController:alertVC animated:YES completion:nil];

        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
    
}

- (void)dealloc{
    
    LWLog(@"xxx");
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
