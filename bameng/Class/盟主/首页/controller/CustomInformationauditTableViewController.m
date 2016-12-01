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
}


- (void)setCustomModel:(CustomInfomationModel *)customModel{
    _customModel = customModel;
    self.custemName.text = customModel.Name;
    self.custemPhone.text = customModel.Mobile;
    self.customAddress.text = customModel.Addr;
    self.belong.text = customModel.BelongOneName;
    
}

- (IBAction)AgreebtnClick:(id)sender {
    [self doSubmit:YES];
}

- (IBAction)refusebtnClick:(id)sender {
    [self doSubmit:NO];
}


- (void)doSubmit:(BOOL)isAgree{
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
