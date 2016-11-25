//
//  CashCouponViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CashCouponViewController.h"
#import "CashCouponTableViewCell.h"
#import "CashModel.h"

@interface CashCouponViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSMutableArray * data;

@end

@implementation CashCouponViewController

static NSString *cashCouponIdentify = @"cashCouponIdentify";



- (NSMutableArray *)data{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.table registerNib:[UINib nibWithNibName:@"CashCouponTableViewCell" bundle:nil] forCellReuseIdentifier:cashCouponIdentify];
    [self.table removeSpaces];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    

    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/MyCashCouponList" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if([responseObject[@"status"] integerValue] == 200){
           NSArray *list =  [CashModel mj_keyValuesArrayWithObjectArray:responseObject[@"data"][@"list"]];
            if (list.count) {
                [self.data addObject:list];
                [self.table reloadData];
            }
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

#pragma mark table

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 107;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [self.table tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.data.count];
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cashCouponIdentify forIndexPath:indexPath];
    
    CashModel * model = self.data[indexPath.row];
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
