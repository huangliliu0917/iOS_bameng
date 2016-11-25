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
#import "CustomSlideViewController.h"

@interface BusinessTableViewController ()

@property(nonatomic,strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *custormNumber;
@property (weak, nonatomic) IBOutlet UILabel *duihuan;
@property (weak, nonatomic) IBOutlet UILabel *crashNumber;

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
    
    
//    [NSTimer s]
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(GetYeWuData) userInfo:nil repeats:YES];
    self.timer = timer;

    
    [HTMyContainAFN AFN:@"user/MyBusiness" with:nil Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if([responseObject[@"status"] integerValue] == 200){
            self.orderNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"orderAmount"]];
            self.crashNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"cashCouponAmount"]];
            self.duihuan.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"exchangeAmount"]];
            self.custormNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"customerAmount"]];
        }

    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    [self.tableView removeSpaces];
}


- (void)GetYeWuData{
    
    [HTMyContainAFN AFN:@"user/MyBusiness" with:nil Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if([responseObject[@"status"] integerValue] == 200){
            self.orderNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"orderAmount"]];
            self.crashNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"cashCouponAmount"]];
            self.duihuan.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"exchangeAmount"]];
            self.custormNumber.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"customerAmount"]];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
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
            
            CustomSlideViewController * vc = [[CustomSlideViewController alloc] init];
            vc.selectPage = 1;
            [self.navigationController pushViewController:vc animated:YES];
            
//            //客户信息
//            CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
//            custom.selectPage = 1;
//            [self.navigationController pushViewController:custom animated:YES];
            break;
        }
        case 2:
        {
            //兑换审核
            CustomSlideViewController * vc = [[CustomSlideViewController alloc] init];
            vc.selectPage = 2;
            [self.navigationController pushViewController:vc animated:YES];
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
            CustomSlideViewController * vc = [[CustomSlideViewController alloc] init];
            vc.selectPage = 3;
            [self.navigationController pushViewController:vc animated:YES];
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
