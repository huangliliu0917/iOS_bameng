//
//  AllyReviewTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "AllyReviewTableViewController.h"

@interface AllyReviewTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UILabel *sexLable;
@property (weak, nonatomic) IBOutlet UILabel *phoneLable;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *refuresBtn;

@end

@implementation AllyReviewTableViewController
- (IBAction)agreeBtnClick:(id)sender {
    [self test:YES];
}
- (IBAction)refresLable:(id)sender {
    [self test:NO];
}

- (void)test:(BOOL)isAgree{
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    LWLog(@"%@",self.model.ID);
    parme[@"id"] = [NSString stringWithFormat:@"%@",self.model.ID];
    parme[@"status"] = isAgree?@"1":@"2";
    __weak typeof(self) weakSelf = self;
    [HTMyContainAFN AFN:@"user/AllyApplyAudit" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
            [MBProgressHUD showSuccess:responseObject[@"statusText"]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"盟友详情审核";
    self.agreeBtn.layer.cornerRadius = 5;
    self.agreeBtn.layer.masksToBounds = YES;
    
    self.refuresBtn.layer.cornerRadius = 5;
    self.refuresBtn.layer.masksToBounds = YES;
    self.refuresBtn.layer.borderColor = LWColor(240, 99, 105).CGColor;
    self.refuresBtn.layer.borderWidth = 1;
    
    LWLog(@"%@",[self.model mj_keyValues]);
    self.nameLable.text = self.model.UserName;
    self.statusLable.text = self.model.StatusName;
    
    if([self.model.UserGender isEqualToString:@"M"]){
        self.sexLable.text = @"男";
    }else if([self.model.UserGender isEqualToString:@"F"]){
        self.sexLable.text = @"女";
    }else{
        self.sexLable.text = @"未知";
    }
    self.phoneLable.text = self.model.Mobile;
    self.timeLable.text = self.model.CreateTime;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
