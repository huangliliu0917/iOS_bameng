//
//  CustomInformationauditTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CustomInformationauditTableViewController.h"

@interface CustomInformationauditTableViewController ()
@property (strong, nonatomic) IBOutlet UIButton *agree;
@property (strong, nonatomic) IBOutlet UIButton *refuse;


@property (weak, nonatomic) IBOutlet UILabel *custemName;

@property (weak, nonatomic) IBOutlet UILabel *custemPhone;

@property (weak, nonatomic) IBOutlet UILabel *customAddress;

@property (weak, nonatomic) IBOutlet UILabel *belong;
@property (weak, nonatomic) IBOutlet UILabel *shenghelable;
@property (weak, nonatomic) IBOutlet UILabel *infoMess;



/**dddd*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImageInfo;


@end

@implementation CustomInformationauditTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.agree.layer.masksToBounds = YES;
    self.agree.layer.cornerRadius = 5;
    
    self.refuse.layer.masksToBounds = YES;
    self.refuse.layer.borderWidth = 1;
    self.refuse.layer.borderColor = [UIColor colorWithRed:246/255.0 green:77/255.0 blue:83/255.0 alpha:1].CGColor;
    self.refuse.layer.cornerRadius = 5;
    
    
    self.custemName.text = self.customModel.Name;
    self.custemPhone.text = self.customModel.Mobile;
    self.customAddress.text = self.customModel.Addr;
    self.belong.text = self.customModel.BelongOneName;
    
    self.iconImageInfo.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageInfo.clipsToBounds = YES;
    
    [self.iconImageInfo sd_setImageWithURL:[NSURL URLWithString:self.customModel.DataImg] placeholderImage:nil];
}




- (IBAction)AgreebtnClick:(id)sender {
    [self doSubmit:YES];
}

- (IBAction)refusebtnClick:(id)sender {
    [self doSubmit:NO];
}




- (void)shengheyonghuxingxi:(BOOL) item andModel:(NSIndexPath *) index{
    
    
    
}



- (void)doSubmit:(BOOL)isAgree{
//    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
//    parme[@"cid"] = self.customModel.ID;
//    parme[@"status"] = isAgree?@"1":@"2";
//    [HTMyContainAFN AFN:@"customer/audit" with:parme Success:^(NSDictionary *responseObject) {
//        LWLog(@"%@", responseObject);
//        if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }
//    } failure:^(NSError *error) {
//        LWLog(@"%@",error);
//    }];
//    
    NSString *tile = nil;
    if (isAgree) {
        tile =  @"确定要同意申请";
    }else{
        tile =  @"确定要拒绝申请";
    }
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"审核提醒" message:tile preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        NSMutableDictionary *parme = [NSMutableDictionary dictionary];
        parme[@"cid"] = self.customModel.ID;
        parme[@"status"] = isAgree?@"1":@"2";
        [HTMyContainAFN AFN:@"customer/audit" with:parme Success:^(NSDictionary *responseObject) {
            LWLog(@"%@", responseObject);
            if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
               [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        }];
        
        
    }];
    
    
    UIAlertAction * ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    
    [alertVC addAction:ac];
    [alertVC addAction:ac1];
    [self presentViewController:alertVC animated:YES completion:nil];
    

    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 变高行数
    if (self.customModel.isSave == 0) {
        
        if (indexPath.row == 0) {
         
            return 0;
            
        }else{
            return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        }
        
    }else{
        if (indexPath.row == 0) {
            
            return 160;
           
        }else if(indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3){
            return 0;
        }
        
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    
    
    
}
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
