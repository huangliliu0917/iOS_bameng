//
//  SetPhoneViewController.m
//  bameng
//
//  Created by lhb on 16/11/23.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SetPhoneViewController.h"

@interface SetPhoneViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengMa;
@property (weak, nonatomic) IBOutlet UILabel *yanLable;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation SetPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.phoneTextField.delegate = self;
    self.yanzhengMa.delegate = self;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getTabzma)];
    self.yanLable.userInteractionEnabled = YES;
    [self.yanLable addGestureRecognizer:tap];
    
    
    self.yanLable.layer.cornerRadius = 5;
    self.yanLable.layer.masksToBounds = YES;
    
    
    self.saveBtn.layer.cornerRadius = 5;
    self.saveBtn.layer.masksToBounds = YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextField) {
        if (textField.text.length > 10) return NO;
    }
    if (textField == self.yanzhengMa) {
        if (textField.text.length > 5) return NO;
    }
    return YES;
}


- (void)getTabzma{
    if (!self.phoneTextField.text.length) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"手机号不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:ac];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"mobile"] = self.phoneTextField.text;
    parme[@"type"] = @"1";
    [HTMyContainAFN AFN:@"sys/sendsms" with:parme Success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] integerValue] == 200) {
            [self showRightWithTitle: responseObject[@"statusText"] autoCloseTime: 1.5];
        }else{
            [self showErrorWithTitle:responseObject[@"statusText"] autoCloseTime: 1.5];
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
                [self.yanLable setText:@"重新发送"];
                self.yanLable.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.yanLable setText:[NSString stringWithFormat:@"%@秒",strTime]];
                self.yanLable.userInteractionEnabled = NO;
   
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


- (IBAction)saveClick:(id)sender {//保存
    
    if(!self.yanLable.text.length){
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"验证码不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:ac];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"verifyCode"] = self.yanzhengMa.text;
    parme[@"mobile"] = self.phoneTextField.text;
    LWLog(@"%@",parme);
    [HTMyContainAFN AFN:@"user/ChanageMobile" with:parme Success:^(NSDictionary *responseObject) {
        if ([responseObject[@"status"] integerValue] == 200) {
            [self showRightWithTitle: responseObject[@"statusText"] autoCloseTime: 1.5];
            
            if ([self.delegate respondsToSelector:@selector(savePhoneNumber:)]) {
                [self.delegate savePhoneNumber:self.phoneTextField.text];
            }
        }else{
            [self showErrorWithTitle:responseObject[@"statusText"] autoCloseTime: 1.5];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color {
    
    //倒计时时间
    __block NSInteger timeOut = 60;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
//                self.backgroundColor = mColor;
                [self.yanLable setText:@"60s"];
                self.yanLable.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
//                self.backgroundColor = color;
//                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                [self.yanLable setText:[NSString stringWithFormat:@"%ld",(long)timeOut]];
                self.yanLable.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}


@end
