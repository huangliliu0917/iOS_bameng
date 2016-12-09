//
//  CustomInfoController.m
//  bameng
//
//  Created by 刘琛 on 16/10/22.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CustomInfoController.h"
#import "ProcessedTableViewCell.h"
#import "UntreatedTableViewCell.h"
#import "SubmitUserInfoTableViewController.h"
#import "CustomDetailsTableViewController.h"
#import "CustomInformationauditTableViewController.h"
#import "AllyReviewTableViewController.h"
#import "AllyInfomationTableViewController.h"
#import "CustomInfomationModel.h"
#import "MeYouShenQingModel.h"
#import "DuiHuanModel.h"
@interface CustomInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UILabel *untreatedLabel;
@property (strong, nonatomic) IBOutlet UILabel *processedLabel;


@property (nonatomic, assign) BOOL isUntreated;

@property (nonatomic, assign) NSInteger PageIndex;
@property (nonatomic, assign) NSInteger PageSize;

@property (nonatomic, strong) NSMutableArray *customList;



@end

@implementation CustomInfoController



/**未处理*/
static NSString *untreatedIdentify = @"untreatedIdentify";
/**已处理*/
static NSString *processedIdentify = @"processedIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    
    LWLog(@"%ld",(long)self.selectPage);
    
    //是否是未处理
    self.isUntreated = YES;
    
    self.slider = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth / 2 - 77) / 2, 33, 77, 2)];
    self.slider.backgroundColor = [UIColor colorWithRed:204/255.0 green:158/255.0 blue:95/255.0 alpha:1];
    [self.chooserView addSubview:self.slider];
    
    [self.table registerNib:[UINib nibWithNibName:@"UntreatedTableViewCell" bundle:nil] forCellReuseIdentifier:untreatedIdentify];
    [self.table registerNib:[UINib nibWithNibName:@"ProcessedTableViewCell" bundle:nil] forCellReuseIdentifier:processedIdentify];
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.table removeSpaces];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    
//    self.table.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
//    __weak CustomInfoController *wself = self;
//    
//    [self.untreated bk_whenTapped:^{
//        if (!_isUntreated) {
//            _isUntreated = YES;
//            [UIView animateWithDuration:0.25 animations:^{
//                wself.untreatedLabel.textColor = MainColor;
//                wself.processedLabel.textColor = [UIColor blackColor];
//                self.slider.frame = CGRectMake((KScreenWidth / 2 - 77) / 2, 33, 77, 2);
//            }];
//            [self getNewInfoWithSliderChange];
//
//        }
//    }];
//    
//    [self.processed bk_whenTapped:^{
//        if (_isUntreated) {
//            _isUntreated = NO;
//            [UIView animateWithDuration:0.25 animations:^{
//                wself.processedLabel.textColor = MainColor;
//                wself.untreatedLabel.textColor = [UIColor blackColor];
//                self.slider.frame = CGRectMake((KScreenWidth / 2 - 77) / 2 + KScreenWidth / 2, 33, 77, 2);
//            }];
//            [self getNewInfoWithSliderChange];
//
//        }
//    }];
//    
    
//    if (self.selectPage == 1) {
//        
//        //客户信息页面
////        self.navigationItem.title = @"客户信息";
//        self.untreatedLabel.text = @"未处理信息";
//        self.processedLabel.text = @"已处理信息";
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"tj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
//            UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
//            SubmitUserInfoTableViewController *submit = [story instantiateViewControllerWithIdentifier:@"SubmitUserInfoTableViewController"];
//            [wself.navigationController pushViewController:submit animated:YES];
//        }];
//    }else if (self.selectPage == 2) {
//        //2兑换审核
//        self.title = @"兑换审核";
//        self.untreatedLabel.text = @"未处理申请";
//        self.processedLabel.text = @"已处理申请";
//    }else if (self.selectPage == 3) {
//        //3我的联盟
//        self.navigationItem.title = @"我的联盟";
//        self.untreatedLabel.text = @"盟友申请";
//        self.processedLabel.text = @"盟友列表";
//        
//    }
//    
    
    
    self.PageSize = 20;
    self.PageIndex = 1;
    self.customList = [NSMutableArray array];
    
    

    
    
//    if (self.selectPage == 1) {
//        //客户信息页面
//        [self getNewCustomInfomation];
//    }else if (self.selectPage == 2) {
//        //2兑换审核
//        
//        [self getNewExchangeInfomation];
//        
//        
//    }else if (self.selectPage == 3) {
//        //3我的联盟
//        [self getMoreMengYouList];
//        
//    }
    
    [self setTabalViewRefresh];

    
    
}


- (void)setTabalViewRefresh {
    
    __weak typeof (self) wself = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewInfoWithSliderChange];
    }];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoreInfoWithSliderChange)];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.table.mj_header beginRefreshing];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 网络请求统一管理

- (void)getNewInfoWithSliderChange {
    if (self.selectPage == 1) {
        
        //客户信息页面
        
        [self getNewCustomInfomation];
        
    }else if (self.selectPage == 2) {
        //2兑换审核
        [self getNewExchangeInfomation];
        
        
    }else if (self.selectPage == 3) {
        //3我的联盟
        
            [self getNewMengYouList];
      
        
    }
}

- (void)getMoreInfoWithSliderChange {
    if (self.selectPage == 1) {
        
        //客户信息页面
        [self getMoreCustomInfomation];

        
    }else if (self.selectPage == 2) {
        //2兑换审核
        [self getMoreExchangeInfomation];
        
        
    }else if (self.selectPage == 3) {
        
        [self getMoreMengYouList];
       
        
    }
}




#pragma mark 客户信息网络请求

- (void)getNewCustomInfomation {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.type);
    dic[@"pageIndex"] = @1;
    dic[@"pageSize"] = @(self.PageSize);
    LWLog(@"%@",dic);
    [self.table showProgramFrameAnimationBubble];
    [HTMyContainAFN AFN:@"customer/list" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"customer/list：%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray *array = [CustomInfomationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            
            [self.customList removeAllObjects];
            [self.customList addObjectsFromArray:array];
            
            self.PageIndex = 1;
//            self.PageSize = [dic[@"data"][@"PageSize"] integerValue];
            [self.table reloadData];
            [self.table.mj_header endRefreshing];
        }
        [self.table HideProgram];
    } failure:^(NSError *error) {
        [self.table.mj_header endRefreshing];
        LWLog(@"%@" ,error);
        [self.table HideProgram];
    }];
}

- (void)getMoreCustomInfomation {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.type);
    dic[@"pageIndex"] = @(self.PageIndex + 1);
    dic[@"pageSize"] = @(self.PageSize);
    LWLog(@"%@",dic);
    [HTMyContainAFN AFN:@"customer/list" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"customer/list：%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray *array = [CustomInfomationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            
            [self.customList addObjectsFromArray:array];
            
            self.PageIndex = [responseObject[@"data"][@"PageIndex"] integerValue];
            //            self.PageSize = [dic[@"data"][@"PageSize"] integerValue];
            
            LWLog(@"%ld",(long)self.PageIndex);
            [self.table reloadData];
            [self.table.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@" ,error);
    }];
}

#pragma mark 兑换审核网络请求
- (void)getNewExchangeInfomation {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.type - 1);
    dic[@"lastId"] = @(0);
    [HTMyContainAFN AFN:@"user/ConvertAuditList" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"customer/list：%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray *array = [DuiHuanModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            
            [self.customList removeAllObjects];
            [self.customList addObjectsFromArray:array];
            [self.table reloadData];
            
        }
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@" ,error);
        [self.table.mj_header endRefreshing];
    }];
}

- (void)getMoreExchangeInfomation {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @(self.type - 1);
    DuiHuanModel * model = [self.customList lastObject];
    dic[@"lastId"] = @(model.ID);
    [HTMyContainAFN AFN:@"user/ConvertAuditList" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"customer/list：%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray *array = [DuiHuanModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
           
            [self.customList addObjectsFromArray:array];
            [self.table reloadData];
            
        }
        [self.table.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@" ,error);
        [self.table.mj_footer endRefreshing];
    }];
}

#pragma mark 我的联盟网络请求

- (void)getNewMengYouList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pageSize"] = @(self.PageSize);
    dic[@"pageIndex"] = @(1);
    [HTMyContainAFN AFN:@"user/AllyApplylist" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"user/allylist：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            self.PageIndex = [responseObject[@"data"][@"PageIndex"] integerValue];
            LWLog(@"%ld",(long)self.PageIndex);
            NSArray *array = [MeYouShenQingModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            if (array.count) {
                [self.customList removeAllObjects];
                [self.customList addObjectsFromArray:array];
                [self.table reloadData];
            }
            
        }
        
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [self.table.mj_header endRefreshing];
    }];
}


- (void)getMoreMengYouList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pageSize"] = @(self.PageSize);
    dic[@"pageIndex"] = @(self.PageIndex + 1);
    LWLog(@"%@",dic);
    [HTMyContainAFN AFN:@"user/AllyApplylist" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"user/allylist：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            self.PageIndex = [responseObject[@"data"][@"PageIndex"] integerValue];
            NSArray *array = [MeYouShenQingModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            if (array.count) {
                [self.customList removeAllObjects];
                [self.customList addObjectsFromArray:array];
                [self.table reloadData];
            }
            
        }
        
        [self.table.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [self.table.mj_footer endRefreshing];
    }];

//    
//    
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    
//    dic[@"identity"] = @0;
//    dic[@"pageSize"] = @(self.PageSize);
//    dic[@"pageIndex"] = @(self.PageIndex + 1);
//    [HTMyContainAFN AFN:@"user/AllyApplylist" with:dic Success:^(NSDictionary *responseObject) {
//        LWLog(@"user/allylist：%@",responseObject);
//        if ([responseObject[@"status"] intValue] == 200) {
//            
//            self.PageIndex = [dic[@"data"][@"PageIndex"] integerValue];
//            NSArray *array = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
//            [self.customList addObjectsFromArray:array];
//            
//            self.PageIndex = [dic[@"data"][@"PageIndex"] integerValue];
//            self.PageSize = [dic[@"data"][@"PageSize"] integerValue];
//            
//            [self.table reloadData];
//        }
//        
//        [self.table.mj_footer endRefreshing];
//    } failure:^(NSError *error) {
//        LWLog(@"%@", error);
//        [self.table.mj_footer endRefreshing];
//    }];

}


#pragma mark tableView


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [tableView tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.customList.count];
    return self.customList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LWLog(@"%ld",(long)self.selectPage);
    if (self.selectPage == 1) {
        if (self.type == 1) {
            UntreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:untreatedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CustomInfomationModel * model = self.customList[indexPath.row];
            cell.customModel = model;
            
            cell.selectPage = self.selectPage;
            __weak typeof(self) weakSelf = self;
            [cell setDidSelectCustomInfo:^(BOOL isAgree) {
                LWLog(@"%d",isAgree);
                NSMutableDictionary *parme = [NSMutableDictionary dictionary];
                parme[@"cid"] = model.ID;
                parme[@"status"] = isAgree?@"1":@"2";
                [HTMyContainAFN AFN:@"customer/audit" with:parme Success:^(NSDictionary *responseObject) {
                    LWLog(@"%@", responseObject);
                    if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                        [weakSelf.customList removeObjectAtIndex:[indexPath row]];  //删除_data数组里的数据
                        [weakSelf.table deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
                    }
                } failure:^(NSError *error) {
                    LWLog(@"%@",error);
                }];
            }];
            return cell;
            
        }else {
            
            ProcessedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:processedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.customModel = self.customList[indexPath.row];
            cell.selectPage = self.selectPage;
            return cell;
        }
    }else if (self.selectPage == 2) {
        
        if (self.type == 1) {
            
            UntreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:untreatedIdentify forIndexPath:indexPath];
            DuiHuanModel * model = self.customList[indexPath.row];
            cell.exchagemodel = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            LWLog(@"%ld",(long)self.selectPage);
            cell.selectPage = self.selectPage;
            __weak typeof(self) weakSelf = self;
            [cell setDidSelectCustomInfo:^(BOOL isAgree) {
                LWLog(@"%d",isAgree);
                NSMutableDictionary *parme = [NSMutableDictionary dictionary];
                parme[@"id"] = @(model.ID);
                parme[@"status"] = isAgree?@"1":@"2";
                [HTMyContainAFN AFN:@"user/ConvertAudit" with:parme Success:^(NSDictionary *responseObject) {
                    LWLog(@"%@", responseObject);
                    if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                        [weakSelf.customList removeObjectAtIndex:[indexPath row]];  //删除_data数组里的数据
                        [weakSelf.table deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
                    }
                } failure:^(NSError *error) {
                    LWLog(@"%@",error);
                }];
            }];

            return cell;
            
        }else {
            
            ProcessedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:processedIdentify forIndexPath:indexPath];
            DuiHuanModel * model = self.customList[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            LWLog(@"%ld",(long)self.selectPage);
            cell.selectPage = self.selectPage;
            cell.exchagemodel = model;
            
            return cell;
        }
    }else if (self.selectPage == 3) {
        
        
        UntreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:untreatedIdentify forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectPage = self.selectPage;
        MeYouShenQingModel * model = self.customList[indexPath.row];
        cell.MeYouShenQing = model;
        [cell setDidSelectCustomInfo:^(BOOL isAgree) {
            LWLog(@"%d",isAgree);
            NSMutableDictionary *parme = [NSMutableDictionary dictionary];
            LWLog(@"%@",model.ID);
            parme[@"id"] = [NSString stringWithFormat:@"%@",model.ID];
            parme[@"status"] = isAgree?@"1":@"2";
            __weak typeof(self) weakSelf = self;
            [HTMyContainAFN AFN:@"user/AllyApplyAudit" with:parme Success:^(NSDictionary *responseObject) {
                LWLog(@"%@", responseObject);
                if ([[responseObject objectForKey:@"status"] integerValue] == 200) {
                    [weakSelf.customList removeObjectAtIndex:[indexPath row]];  //删除_data数组里的数据
                    [weakSelf.table deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
                }
            } failure:^(NSError *error) {
                LWLog(@"%@",error);
            }];
        }];
        return cell;

    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.selectPage == 1) {
        if (self.type == 1) {
            return 108;
        }else {
            return 76;
        }
    }else if (self.selectPage == 2) {
        if (self.type == 1) {
            return 108;
        }else {
            return 76;
        }
    }else if (self.selectPage == 3) {
        if (self.type == 1) {
            return 108;
        }else {
            return 76;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectPage == 1) {
        
        LWLog(@"xxxx");
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        if (self.type == 1) {
            LWLog(@"xxxx");
            CustomInformationauditTableViewController *info = [story instantiateViewControllerWithIdentifier:@"CustomInformationauditTableViewController"];
            info.customModel = self.customList[indexPath.row];
            
            [self.navigationController pushViewController:info animated:YES];
            
        }else {
            
            CustomDetailsTableViewController *detail = [story instantiateViewControllerWithIdentifier:@"CustomDetailsTableViewController"];
            detail.customModel = self.customList[indexPath.row];
            [self.navigationController pushViewController:detail animated:YES];
            
        }
    }else if (self.selectPage == 2) {
        LWLog(@"xxxx");
        
    }else if (self.selectPage == 3) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        AllyReviewTableViewController *review = [story instantiateViewControllerWithIdentifier:@"AllyReviewTableViewController"];
        MeYouShenQingModel * model = self.customList[indexPath.row];
        review.model = model;
        [self.navigationController pushViewController:review animated:YES];

        
    }
}

@end
