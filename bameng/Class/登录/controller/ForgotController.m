//
//  ForgotController.m
//  bameng
//
//  Created by 刘琛 on 16/11/3.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ForgotController.h"

@interface ForgotController ()

@end

@implementation ForgotController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.saveButton.layer.masksToBounds = YES;
    self.saveButton.layer.cornerRadius = 5;
    
    self.captchaField.layer.masksToBounds = YES;
    self.captchaField.layer.cornerRadius = 5;
    
    
    
}

- (void)getCaptchaFormServer {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"identity"] = @0;
    dic[@"pageSize"] = @(1);
    dic[@"pageIndex"] = @(1);
    [HTMyContainAFN AFN:@"article/list" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"article/list：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {

        }
        

    } failure:^(NSError *error) {
        LWLog(@"%@", error);

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
