//
//  MengYouHomeViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengYouHomeViewController.h"
#import "MengYouHomeTableViewCell.h"
#import "MYSubmitInfoTableViewController.h"
#import "MYCustomDetailTableViewController.h"
#import "MyCoreLocation.h"
#import "CustomInfomationModel.h"
#import "SubmitUserInfoTableViewController.h"


@interface MengYouHomeViewController ()<UITableViewDataSource, UITableViewDelegate,MyCoreLocationDelegate>


@property (strong, nonatomic) IBOutlet UILabel *agreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *rankingLabel;
@property (strong, nonatomic) IBOutlet UILabel *firendLabel;
@property (strong, nonatomic) IBOutlet UILabel *ordorLabel;
@property (strong, nonatomic) IBOutlet UILabel *clinchLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;






@property (nonatomic, strong) UIButton *loacationButton;

@property(nonatomic,strong) NSTimer *timer;


/**定位*/
@property(nonatomic,strong) MyCoreLocation * core;


@property(nonatomic,strong) UIButton * cityBtn;


@property(nonatomic,strong) NSMutableArray * dataLists;


@property(nonatomic,assign) int PageIndex;

@end

@implementation MengYouHomeViewController

static NSString *mengYouHomeIdentify = @"mengYouHomeIdentify";


- (NSMutableArray *)dataLists{
    
    if (_dataLists == nil) {
        _dataLists = [NSMutableArray array];
    }
    return _dataLists;
}

- (UIButton *)cityBtn{
    if (_cityBtn == nil) {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityBtn.frame = CGRectMake(0, 0, 80, 30);
        [_cityBtn setTitle:@"未知" forState:UIControlStateNormal];
        [_cityBtn.titleLabel setFont:[UIFont fontWithName:@"ArialMT"size:15]];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [_cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -27, 0, 0)];
        [_cityBtn setImage:[UIImage imageNamed:@"gps"] forState:UIControlStateNormal];
    }
    return _cityBtn;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
}

/*
 * 定位服务
 */
- (void) MyCoreLocationTakeBackCity:(NSString *)city andLatLong:(NSString *)info{
    LWLog(@"%@---%@",city,info);
    if (city.length) {
        [self.cityBtn setTitle:city forState:UIControlStateNormal];
        [_core MyCoreLocationStopLocal];
        NSMutableDictionary * pareme = [NSMutableDictionary dictionary];
        pareme[@"mylocation"] = city;
        pareme[@"lnglat"] = info;
        [HTMyContainAFN AFN:@"sys/MyLocation" with:pareme Success:^(NSDictionary *responseObject) {
            LWLog(@"sys/MyLocation：%@", responseObject);
        } failure:^(NSError *error) {
            LWLog(@"%@" ,error);
        }];
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView removeSpaces];
    [self.tableView registerNib:[UINib nibWithNibName:@"MengYouHomeTableViewCell" bundle:nil] forCellReuseIdentifier:mengYouHomeIdentify];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak MengYouHomeViewController *wself = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"tj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        SubmitUserInfoTableViewController *sub = [story instantiateViewControllerWithIdentifier:@"SubmitUserInfoTableViewController"];
        [wself.navigationController pushViewController:sub animated:YES];
    }];
    
    
    _core = [MyCoreLocation MyCoreLocationShare];
    _core.delegate = self;
    [_core MyCoreLocationStartLocal];
    
//
    
    [self GetYeWuData];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:15 target:self selector:@selector(GetYeWuData) userInfo:nil repeats:YES];
    self.timer = timer;
    
    

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.cityBtn];
    self.navigationItem.title = @"业务客户";
    
//    int type,
//    int pageIndex,
//    int pageSize
    [self setTabalViewRefresh];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    
}


- (void)getNewZiXunList{
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"type"] = @(0);
    parme[@"pageIndex"] = @(0);
    parme[@"pageSize"] = @(20);
    [HTMyContainAFN AFN:@"customer/list" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        self.PageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray * data =  [CustomInfomationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            if (data.count) {
                [self.dataLists removeAllObjects];
                [self.dataLists addObjectsFromArray:data];
                [self.tableView reloadData];
            }
        }
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        LWLog(@"%@",error);
    }];
 
    
}

- (void) getMoerZixunList{
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"type"] = @(0);
    parme[@"pageIndex"] = @(self.PageIndex + 1);
    parme[@"pageSize"] = @(20);
    [HTMyContainAFN AFN:@"customer/list" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        self.PageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray * data =  [CustomInfomationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            if (data.count) {
//                [self.dataLists removeAllObjects];
                [self.dataLists addObjectsFromArray:data];
                [self.tableView reloadData];
            }
        }
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (void)setTabalViewRefresh {
    
    __weak typeof(self) wself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}



- (void)GetYeWuData{
    
    [HTMyContainAFN AFN:@"user/AllyHomeSummary" with:nil Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if([responseObject[@"status"] integerValue] == 200){
            self.agreeLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"AllyAmount"]]; //
            self.rankingLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"CustomerAmount"]]; //
            self.firendLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"CustomerRank"]]; //
            self.ordorLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"OrderRank"]]; //
            self.clinchLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"OrderSuccessAmount"]]; //
       }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
    
    
    
}

- (void)setUserInfomation {
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
    UserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
//    self.agreeLabel.text =
}

#pragma mark tableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 98;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [tableView tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.dataLists.count];
    return self.dataLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MengYouHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mengYouHomeIdentify forIndexPath:indexPath];
    CustomInfomationModel * model = self.dataLists[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
    MYCustomDetailTableViewController *custom = [story instantiateViewControllerWithIdentifier:@"MYCustomDetailTableViewController"];
    CustomInfomationModel * model = self.dataLists[indexPath.row];
    custom.model = model;
    [self.navigationController pushViewController:custom animated:YES];
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

@end
