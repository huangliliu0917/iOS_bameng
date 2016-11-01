//
//  MYWealthTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/1.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYWealthTableViewController.h"
#import "MyWalletTableViewController.h"
#import "SettingTableViewController.h"
#import "MengDouTableViewController.h"
#import "DaijiesuanTableViewController.h"
#import "IntegralTableViewController.h"
#import "CashCouponViewController.h"
#import "MyBusinessViewController.h"

@interface MYWealthTableViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *setting;
@property (strong, nonatomic) IBOutlet UIView *mengdou;
@property (strong, nonatomic) IBOutlet UIView *daijiesuan;
@property (strong, nonatomic) IBOutlet UIView *jifen;
@property (strong, nonatomic) IBOutlet UILabel *mengdouLabel;
@property (strong, nonatomic) IBOutlet UILabel *daijiesuanLabel;
@property (strong, nonatomic) IBOutlet UILabel *jifenLabel;

@end

@implementation MYWealthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.setting.userInteractionEnabled = YES;
    [self.setting bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        SettingTableViewController *setting = [story instantiateViewControllerWithIdentifier:@"SettingTableViewController"];
        [self.navigationController pushViewController:setting animated:YES];
    }];
    
    [self.mengdou bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        MengDouTableViewController *mengdou = [story instantiateViewControllerWithIdentifier:@"MengDouTableViewController"];
        [self.navigationController pushViewController:mengdou animated:YES];
    }];
    
    [self.daijiesuan bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        DaijiesuanTableViewController *jiesuan = [story instantiateViewControllerWithIdentifier:@"DaijiesuanTableViewController"];
        [self.navigationController pushViewController:jiesuan animated:YES];
    }];
    
    [self.jifen bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        IntegralTableViewController *jifen = [story instantiateViewControllerWithIdentifier:@"IntegralTableViewController"];
        [self.navigationController pushViewController:jifen animated:YES];
    }];
    
    [self.tableView removeSpaces];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        MyWalletTableViewController *wallet = [story instantiateViewControllerWithIdentifier:@"MyWalletTableViewController"];
        [self.navigationController pushViewController:wallet animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        MyBusinessViewController *business = [story instantiateViewControllerWithIdentifier:@"MyBusinessViewController"];
        [self.navigationController pushViewController:business animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        CashCouponViewController *cash = [story instantiateViewControllerWithIdentifier:@"CashCouponViewController"];
        [self.navigationController pushViewController:cash animated:YES];
    }
}

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
