//
//  customInfoDetailController.m
//  bameng
//
//  Created by 罗海波 on 2016/12/30.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "customInfoDetailController.h"

@interface customInfoDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UITextView *remarkDes;

@end

@implementation customInfoDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"客户信息详情";
    
    

    self.nameLable.text = self.model.Name;
    self.phoneLable.text = self.model.Mobile;
    self.addressLable.text = self.model.Addr;
    self.remarkDes.text = self.model.Remark;
    
    self.remarkDes.userInteractionEnabled =  NO;
    self.remarkDes.layer.borderWidth = 0.5;
    
    
    self.remarkDes.layer.borderColor = LWColor(239, 239, 244).CGColor;
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
