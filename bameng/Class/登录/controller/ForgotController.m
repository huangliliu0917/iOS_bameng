//
//  ForgotController.m
//  bameng
//
//  Created by 刘琛 on 16/11/3.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ForgotController.h"

@interface ForgotController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *phoneField;
@property (strong, nonatomic) IBOutlet UITextField *captchaField;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UIImageView *showAndHidden;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;


@property (weak, nonatomic) IBOutlet UILabel *yanzhengma;

@end

@implementation ForgotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupInit];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneField) {
        if (textField.text.length > 10) return NO;
    }
    return YES;
}


- (void)setupInit{
    
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.cornerRadius = 5;
    
    self.captchaField.layer.masksToBounds = YES;
    self.captchaField.layer.cornerRadius = 5;
    
    self.yanzhengma.layer.masksToBounds = YES;
    self.yanzhengma.layer.cornerRadius = 5;
 
    self.phoneField.delegate = self;
    
    self.yanzhengma.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yanzhengmaxx)];
    [self.yanzhengma addGestureRecognizer:ges];
    
    
    self.showAndHidden.userInteractionEnabled = YES;
    self.showAndHidden.tag = 100;
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMima:)];
    [self.showAndHidden addGestureRecognizer:ges1];
    
    
    
}



- (void)showMima:(UITapGestureRecognizer *)tap{
    UIImageView * im = (UIImageView *)tap.view;
    if(im.tag == 100){//显示
        self.password.secureTextEntry = NO;
        im.tag = 101;
    }else{//隐藏
        self.password.secureTextEntry = YES;
        im.tag = 100;
    }
    
}

- (void)yanzhengmaxx{
    
    if (!self.phoneField.text.length) {
        [MBProgressHUD showError:@"手机号为空"];
        
        return;
    }
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"mobile"] = self.phoneField.text;
    parme[@"type"] = @"1";
    [HTMyContainAFN AFN:@"sys/sendsms" with:parme Success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] integerValue] == 200) {
            [MBProgressHUD showSuccess:responseObject[@"statusText"]];
        }else{
            [MBProgressHUD showError:responseObject[@"statusText"]];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    [self settime];
    
}

- (void)settime{
    /*************倒计时************/
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.yanzhengma setText:@"重新发送"];
                self.yanzhengma.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.yanzhengma setText:[NSString stringWithFormat:@"%@秒",strTime]];
                self.yanzhengma.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (IBAction)savePasswd:(id)sender {
    
    if(!self.captchaField.text){
        [MBProgressHUD showError:@"验证码为空"];
        return;
    }
    if(!self.password.text){
        [MBProgressHUD showError:@"密码为空"];
        return;
    }
    
    [self getCaptchaFormServer];
}


- (void)getCaptchaFormServer {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"mobile"] = self.phoneField.text;
    dic[@"password"] = [AsignLibrary md5by32:self.password.text];
    dic[@"verifyCode"] = self.captchaField.text;
    [MBProgressHUD showMessage:nil];
    [HTMyContainAFN AFN:@"user/forgetpwd" with:dic Success:^(NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        LWLog(@"article/list：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            [MBProgressHUD showSuccess:responseObject[@"statusText"]];
            
            [[NSUserDefaults standardUserDefaults] setObject:self.password.text forKey:@"passwd"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
        

    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [MBProgressHUD hideHUD];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
