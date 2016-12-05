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
#import "LXActionSheet.h"
#import "SelectObjectViewController.h"
#import "PushWebViewController.h"

@interface CashCouponViewController ()<UITableViewDataSource,UITableViewDelegate,CashCouponTableViewCellDelegate,LXActionSheetDelegate,SelectObjectDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSMutableArray * dataList;


@property (strong, nonatomic) CashModel  * pickCashModel;

@end

@implementation CashCouponViewController

static NSString *cashCouponIdentify = @"cashCouponIdentify";



- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.table registerNib:[UINib nibWithNibName:@"CashCouponTableViewCell" bundle:nil] forCellReuseIdentifier:cashCouponIdentify];
    [self.table removeSpaces];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    [self setTabalViewRefresh];
    
    [self.table.mj_header beginRefreshing];
    
}


- (void)setTabalViewRefresh {
    
    __weak typeof(self) wself = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    //    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}

- (void)getNewZiXunList{
    [self.table showProgramFrameAnimationBubble];
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/MyCashCouponList" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if([responseObject[@"status"] integerValue] == 200){
            NSArray *list =  [CashModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (list.count) {
                [self.dataList removeAllObjects];
                [self.dataList addObjectsFromArray:list];
                [self.table reloadData];
            }
        }
        [self.table HideProgram];
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.table HideProgram];
        [self.table.mj_header endRefreshing];
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
    
    [self.table tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.dataList.count];
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cashCouponIdentify forIndexPath:indexPath];
     CashModel * model = self.dataList[indexPath.row];
    cell.delegate = self;
//    LWLog(@"%@",)
    cell.model = model;
    return cell;
}


- (void)CashCouponTableViewCellTurn:(NSInteger)item andmodel:(CashModel *)model{
    
    _pickCashModel = model;
    LWLog(@"%ld",(long)item);
    if (item == 1) {
        LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:4 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        //    __weak typeof(self) wself = self;
        action.delegate = self;
        [action showInView:self.view];
    }

}


- (void)myorMengzhu:(int)item{
    
    LWLog(@"%d",item);
    
    if(item == 0){//客户

        NSMutableDictionary *parme = [NSMutableDictionary dictionary];
        parme[@"couponId"] = @(self.pickCashModel.ID);
        parme[@"toUserId"] = @(0);
        LWLog(@"%@",parme);
        __weak typeof(self) wself = self;
        [HTMyContainAFN AFN:@"user/SendCashCoupon" with:parme Success:^(NSDictionary *responseObject) {
            LWLog(@"%@", responseObject);
            if ([responseObject[@"status"] intValue] == 200) {
                PushWebViewController *push = [[PushWebViewController alloc] init];
                push.openUrl = wself.pickCashModel.url;
                [self.navigationController pushViewController:push animated:YES];
            }
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        }];
        
    }else{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        SelectObjectViewController *select = [story instantiateViewControllerWithIdentifier:@"SelectObjectViewController"];
        select.type = 1;
        select.delegate = self;
        [self.navigationController pushViewController: select animated:YES];
    }
}



- (void)selectMengYou:(NSString *) mengYouId andName:(NSString *)names{
    
    LWLog(@"xxxxxxx%@",mengYouId);
    __weak typeof(self) wself = self;
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"couponId"] = @(self.pickCashModel.ID);
    parme[@"toUserId"] = mengYouId;
    [HTMyContainAFN AFN:@"user/SendAllyCashCoupon" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            PushWebViewController *push = [[PushWebViewController alloc] init];
            push.openUrl = wself.pickCashModel.url;
            [self.navigationController pushViewController:push animated:YES];
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
