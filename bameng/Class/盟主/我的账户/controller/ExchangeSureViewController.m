//
//  ExchangeSureViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ExchangeSureViewController.h"

@interface ExchangeSureViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *changBean;

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLable;

@end

@implementation ExchangeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.changBean.delegate = self;
    self.navigationItem.title = @"兑换";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
 
    __weak typeof(self)wself = self;
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/AlreadyConvertTotal" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@",responseObject);
        wself.firstLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"mengBeansCount"]];
        wself.secondLable.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"alreadyConverCount"]];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)DuiHuan:(id)sender {
    
    UserModel * user = [UserModel GetUserModel];
    if ([self.changBean.text integerValue] > [user.MengBeans integerValue]) {
        
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"盟豆" message:@"当前账户可兑换盟豆不足" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:ac];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }else{
        NSMutableDictionary *parme = [NSMutableDictionary dictionary];
        parme[@"amount"] = self.changBean.text;
        
        [HTMyContainAFN AFN:@"user/ConvertToBean" with:parme Success:^(NSDictionary *responseObject) {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"成功" message:[NSString stringWithFormat:@"兑换%@盟豆成功",self.changBean.text] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertVC addAction:ac];
            [self presentViewController:alertVC animated:YES completion:nil];
          
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        }];
        
    }
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
