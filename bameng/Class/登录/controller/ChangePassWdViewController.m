//
//  ChangePassWdViewController.m
//  bameng
//
//  Created by lhb on 16/11/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ChangePassWdViewController.h"

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
           [self showRightWithTitle:responseObject[@"statusText"] autoCloseTime: 1.5];
        }else{
           [self showErrorWithTitle:responseObject[@"statusText"] autoCloseTime: 1.5];
        }
        
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    
    
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
