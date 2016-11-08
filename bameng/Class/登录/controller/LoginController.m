//
//  LoginController.m
//  bameng
//
//  Created by 刘琛 on 16/11/3.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "LoginController.h"
#import "MengzhuTabbarController.h"
#import "MengYouTabbarViewController.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginButtonAction:(id)sender {
    NSString *phoneText = self.phone.text;
    NSString *passwordText = self.password.text;
    
    if (phoneText.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
    }else if (passwordText.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
    }else {
        NSMutableDictionary *parme = [NSMutableDictionary dictionary];
        parme[@"loginName"] = phoneText;
        parme[@"password"] = [AsignLibrary md5by32:passwordText];
        
        [HTMyContainAFN AFN:@"user/login" with:parme Success:^(NSDictionary *responseObject) {
            LWLog(@"%@", responseObject);
            if ([responseObject[@"status"] intValue] == 200) {
                UserModel *user = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
                [NSKeyedArchiver archiveRootObject:user toFile:fileName];
                
                [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
                
                if (user.UserIdentity == 1) {
                    [[NSUserDefaults standardUserDefaults] setObject:isMengZhu forKey:mengyouIdentify];
                    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
                    MengzhuTabbarController *tabbar = [story instantiateViewControllerWithIdentifier:@"MengzhuTabbarController"];
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;

                }else if (user.UserIdentity == 0) {
                    [[NSUserDefaults standardUserDefaults] setObject:isMengYou forKey:mengyouIdentify];
                    UIStoryboard *mengyou = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
                    MengYouTabbarViewController *you = [mengyou instantiateViewControllerWithIdentifier:@"MengYouTabbarViewController"];
                    [UIApplication sharedApplication].keyWindow.rootViewController = you;
                }
                
                
            }
            
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        }];
    }
    
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
