//
//  BusinessTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "BusinessTableViewController.h"
#import "CustomInfoController.h"
#import "EncourageTableViewController.h"
#import "CashCouponViewController.h"
@interface BusinessTableViewController ()

@end

@implementation BusinessTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的业务";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//
    
    [HTMyContainAFN AFN:@"user/MyBusiness" with:nil Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);

    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    [self.tableView removeSpaces];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self getMyBusinessInfo];
}

- (void)getMyBusinessInfo {
    [HTMyContainAFN AFN:@"user/MyBusiness" with:nil Success:^(id responseObject) {
        LWLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
    switch (indexPath.row) {
        case 0:
        {
            //我的订单
            
            break;
        }
        case 1:
        {  
            //客户信息
            CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
            custom.selectPage = 1;
            [self.navigationController pushViewController:custom animated:YES];
            break;
        }
        case 2:
        {
            //兑换审核
            CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
            custom.selectPage = 2;
            [self.navigationController pushViewController:custom animated:YES];
            break;
        }
        case 3:
        {
            //奖励设置
            EncourageTableViewController *encourage = [story instantiateViewControllerWithIdentifier:@"EncourageTableViewController"];
            [self.navigationController pushViewController:encourage animated:YES];
            break;
        }
        case 4:
        {
            //我的联盟
            CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
            custom.selectPage = 3;
            [self.navigationController pushViewController:custom animated:YES];
            break;
        }
        case 5:
        {
            //我的现金券
            CashCouponViewController *cash = [story instantiateViewControllerWithIdentifier:@"CashCouponViewController"];
            [self.navigationController pushViewController:cash animated:YES];
            break;
        }
        default:
            break;
    }
}


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
