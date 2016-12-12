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
#import "AppDelegate.h"
#import "ForgotController.h"


@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;
    
//    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:AppToken];
    [self setupInit];
    
    
    NSString * phone =  [[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    if (phone.length) {
        self.phone.text = phone;
    }
    NSString * passwd =  [[NSUserDefaults standardUserDefaults] objectForKey:@"passwd"];
    if (passwd.length) {
        self.password.text = phone;
    }
    if(self.isReachable){
        LWLog(@"有网");
    }else{
        LWLog(@"没网");
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

    
    NSString * pass = [[NSUserDefaults standardUserDefaults]objectForKey:@"passwd"];
    if (pass.length) {
        self.password.text = pass;
    }
}

- (void)setupInit{
    self.forgetButton.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forgetPasswd)];
    [self.forgetButton addGestureRecognizer:ges];
    
}


- (void)forgetPasswd{
    
    
    LWLog(@"xxx");
    ForgotController * fg = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ForgotController"];
    [self.navigationController pushViewController:fg animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginButtonAction:(id)sender {
    NSString *phoneText = self.phone.text;
    NSString *passwordText = self.password.text;
    
    [self.view endEditing:YES];
    if (phoneText.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
    }else if (passwordText.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
    }else {
        NSMutableDictionary *parme = [NSMutableDictionary dictionary];
        parme[@"loginName"] = phoneText;
        parme[@"password"] = [AsignLibrary md5by32:passwordText];
        
        [MBProgressHUD showMessage:nil];
        [HTMyContainAFN AFN:@"user/login" with:parme Success:^(NSDictionary *responseObject) {
            LWLog(@"%@", responseObject);
            [MBProgressHUD hideHUD];
            if ([responseObject[@"status"] intValue] == 200) {
                
                [[NSUserDefaults standardUserDefaults] setObject:phoneText forKey:@"account"];
                [[NSUserDefaults standardUserDefaults] setObject:passwordText forKey:@"passwd"];
                
                
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
            [MBProgressHUD hideHUD];
        }];
    }
    
}

@end
