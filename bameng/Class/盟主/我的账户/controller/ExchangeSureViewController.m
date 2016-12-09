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
@property (weak, nonatomic) IBOutlet UIButton *exchangeBtn;

@end

@implementation ExchangeSureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.changBean.delegate = self;
    self.navigationItem.title = @"兑换";
    self.exchangeBtn.layer.cornerRadius = 5;
    self.exchangeBtn.layer.masksToBounds = YES;
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
 
    
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
         __weak typeof(self)wself = self;
        [MBProgressHUD showMessage:nil];
        [HTMyContainAFN AFN:@"user/ConvertToBean" with:parme Success:^(NSDictionary *responseObject) {
            
            [MBProgressHUD hideHUD];
            [wself GetUserData];
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"成功" message:[NSString stringWithFormat:@"成功提交兑换%@盟豆申请",self.changBean.text] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                wself.firstLabel.text = [NSString stringWithFormat:@"%ld",[wself.firstLabel.text integerValue] - [self.changBean.text integerValue]];
            }];
            [alertVC addAction:ac];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            
          
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
            [MBProgressHUD hideHUD];
        }];
        
    }
}

- (void)GetUserData{
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/myinfo" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            UserModel *user = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
            [NSKeyedArchiver archiveRootObject:user toFile:fileName];
            [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
            
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
