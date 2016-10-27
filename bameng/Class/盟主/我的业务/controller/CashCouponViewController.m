//
//  CashCouponViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CashCouponViewController.h"
#import "CashCouponTableViewCell.h"

@interface CashCouponViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation CashCouponViewController

static NSString *cashCouponIdentify = @"cashCouponIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.table registerNib:[UINib nibWithNibName:@"CashCouponTableViewCell" bundle:nil] forCellReuseIdentifier:cashCouponIdentify];
    [self.table removeSpaces];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark table

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 107;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cashCouponIdentify forIndexPath:indexPath];
    return cell;
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
