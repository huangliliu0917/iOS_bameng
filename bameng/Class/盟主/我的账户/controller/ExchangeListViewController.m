//
//  ExchangeListViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ExchangeListViewController.h"
#import "ExchangeListTableViewCell.h"
#import "MenDouBeanExchageLists.h"

@interface ExchangeListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *table;


@property(nonatomic,strong) NSMutableArray <MenDouBeanExchageLists *>* dataList;

@end

@implementation ExchangeListViewController


- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

static NSString *exchangeListIdentify = @"exchangeListIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"兑换记录";
    [self.table registerNib:[UINib nibWithNibName:@"ExchangeListTableViewCell" bundle:nil] forCellReuseIdentifier:exchangeListIdentify];
    [self.table removeSpaces];
    
    
//
    [self setTabalViewRefresh];
    
    [self.table.mj_header beginRefreshing];
}

- (void) getNewZiXunList{
    
    
    __weak typeof(self) wself = self;
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"lastId"] = @(0);
    [HTMyContainAFN AFN:@"user/ConvertFlow" with:parme Success:^(NSDictionary *responseObject) {
       LWLog(@"%@",responseObject);
        NSArray * arr = [MenDouBeanExchageLists mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if (arr.count) {
            [wself.dataList removeAllObjects];
            [wself.dataList addObjectsFromArray:arr];
            [wself.table reloadData];
        }
        [wself.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [wself.table.mj_header endRefreshing];
    }];

}


- (void) getMoerZixunList{
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    MenDouBeanExchageLists * model = [self.dataList lastObject];
    parme[@"lastId"] = @(model.ID);
    __weak typeof(self) wself = self;
    [HTMyContainAFN AFN:@"user/ConvertFlow" with:parme Success:^(NSDictionary *responseObject) {
        
        NSArray * arr = [MenDouBeanExchageLists mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if (arr.count) {
            [wself.dataList addObjectsFromArray:arr];
            [wself.table reloadData];
        }
        
        [wself.table.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [wself.table.mj_footer endRefreshing];
    }];
    
}

- (void)setTabalViewRefresh {
    
    __weak ExchangeListViewController *wself = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [tableView tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.dataList.count];
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exchangeListIdentify forIndexPath:indexPath];
    MenDouBeanExchageLists * model = [self.dataList objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}


@end
