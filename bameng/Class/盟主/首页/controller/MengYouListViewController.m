//
//  MengYouListViewController.m
//  bameng
//
//  Created by lhb on 16/11/23.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengYouListViewController.h"
#import "ProcessedTableViewCell.h"
#import "AllyInfomationTableViewController.h"

@interface MengYouListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *menyouList;

@property (weak, nonatomic) IBOutlet UIView *sortView;


@property(nonatomic,strong) NSArray * titileArray;


@property(nonatomic,strong) UIButton * selectBtn;


@property(nonatomic,strong) NSMutableArray * menYouDataList;


@property(nonatomic,assign) int status;


@property(nonatomic,assign) int PageIndex;
@end

@implementation MengYouListViewController


- (NSMutableArray *)menYouDataList{
    if (_menYouDataList == nil) {
        _menYouDataList = [NSMutableArray array];
    }
    return _menYouDataList;
}

- (NSArray *)titileArray{
    if (_titileArray == nil) {
        
        _titileArray = @[@"盟友等级",@"客户信息量",@"订单成交量"];
    }
    return _titileArray;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat spacing = 0;
    for (int i = 0; i<3; i++) {
        UIButton * btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(KScreenWidth / 3.0 * i, 0, KScreenWidth / 3.0, 40);
        // 还可增设间距
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         // 图片右移
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.tag = 100 + i;
        [btn setImage:[UIImage imageNamed:@"20x20-3"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"20x20-1"] forState:UIControlStateSelected];
        [btn setTitle:[[self titileArray] objectAtIndex:i]  forState:UIControlStateNormal];
        CGSize imageSize = btn.imageView.frame.size;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0.0, - imageSize.width * 2 - spacing, 0.0, 0.0);
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        // 文字左移
        CGSize titleSize = btn.titleLabel.frame.size;
        btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, - titleSize.width * 2 - spacing);
        [self.sortView addSubview:btn];
        
        if (i == 0) {
            
            btn.selected = YES;
            self.selectBtn = btn;
        }
        
    }
    self.status = 1; //降序

    [self.menyouList removeSpaces];
    [self.menyouList registerNib:[UINib nibWithNibName:@"ProcessedTableViewCell" bundle:nil] forCellReuseIdentifier:@"processedIdentify"];
    
     [self getNewData];
    
    [self setTabalViewRefresh];
    
}

- (void)getNewData{
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"pageIndex"] = @"0";
    parme[@"pageSize"] = @(20);
    if(self.selectBtn.tag == 100){
        parme[@"orderbyCode"] = @(0);
    }else if(self.selectBtn.tag == 101){
        parme[@"orderbyCode"] = @(1);
    }else{
        parme[@"orderbyCode"] = @(2);
    }
    parme[@"isDesc"] = self.status?@(1):@(0);
    [HTMyContainAFN AFN:@"user/allylist" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            self.PageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
            NSArray * array = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            
            [self.menYouDataList removeAllObjects];
            [_menYouDataList addObjectsFromArray:array];
            [self.menyouList reloadData];
            
        }
        [self.menyouList.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.menyouList.mj_header endRefreshing];
    }];
}


- (void)getMoerZixunList{
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"pageIndex"] = @(self.PageIndex + 1);
    parme[@"pageSize"] = @(20);
    if(self.selectBtn.tag == 100){
        parme[@"orderbyCode"] = @(0);
    }else if(self.selectBtn.tag == 101){
        parme[@"orderbyCode"] = @(1);
    }else{
        parme[@"orderbyCode"] = @(2);
    }
    parme[@"isDesc"] = self.status?@(1):@(0);
    [HTMyContainAFN AFN:@"user/allylist" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            self.PageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
            NSArray * array = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            if (array) {
                [_menYouDataList addObjectsFromArray:array];
                [self.menyouList reloadData];
            }
        }
        [self.menyouList.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.menyouList.mj_footer endRefreshing];
    }];
    
}
- (void)btnclick:(UIButton *) btn{
    LWLog(@"%@",btn.imageView.image);
    if (btn == self.selectBtn) {
        if (self.status) {
             [btn setImage:[UIImage imageNamed:@"20x20-2"] forState:UIControlStateSelected];
            self.status = 0;
        }else{
            [btn setImage:[UIImage imageNamed:@"20x20-1"] forState:UIControlStateSelected];
            self.status = 1;
        }
    }else{
        self.selectBtn.selected = NO;
        [btn setImage:[UIImage imageNamed:@"20x20-1"] forState:UIControlStateSelected];
        btn.selected = YES;
        self.selectBtn = btn;
        self.status = 1;
        
    }
    [self getNewData];

}

- (void)setTabalViewRefresh {
    
    __weak typeof(self) wself = self;
    self.menyouList.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewData];
    }];
    
    self.menyouList.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.menYouDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProcessedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"processedIdentify" forIndexPath:indexPath];
    cell.selectPage = 3;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UserModel * model = self.menYouDataList[indexPath.row];
    cell.mengyouModel = model;
    return cell;

    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    AllyInfomationTableViewController *info = [ [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil] instantiateViewControllerWithIdentifier:@"AllyInfomationTableViewController"];
    info.mengYouModel = self.menYouDataList[indexPath.row];
    [self.navigationController pushViewController:info animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}
@end
