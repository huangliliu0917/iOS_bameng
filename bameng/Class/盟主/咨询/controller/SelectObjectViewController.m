//
//  SelectObjectViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SelectObjectViewController.h"
#import "SelectObjectTableViewCell.h"

@interface SelectObjectViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *selectAll;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;

@property (nonatomic, strong) NSMutableArray *goods;
@property (nonatomic, strong) NSMutableArray *selectGoods;



@end

@implementation SelectObjectViewController

static NSString *selectObjectIdentify = @"selectObjectIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.goods = [NSMutableArray array];
    self.selectGoods = [NSMutableArray array];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectObjectTableViewCell" bundle:nil] forCellReuseIdentifier:selectObjectIdentify];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.editing = YES;
    self.title = @"盟友列表";
    [self.tableView removeSpaces];
    
#warning 全选修改
    [self.selectAll bk_whenTapped:^{
        //全选操作
        if (self.selectGoods.count != self.goods.count) {
            [self.selectGoods removeAllObjects];
            for (int row = 0; row < self.goods.count; row++){
                NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
                [self.tableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
            }
            [self.selectGoods addObjectsFromArray:self.goods];
        }else {
            for (int row = 0; row < self.goods.count; row++){
                NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
                [self.tableView deselectRowAtIndexPath:index animated:NO];
            }
            [self.selectGoods removeAllObjects];
        }
    }];
    
    [self.finishButton bk_whenTapped:^{
        
        if (_selectGoods.count != 0) {
            
            if ([self.delegate respondsToSelector:@selector(selectMengYou:andName:)]) {
                
                
                NSMutableString *str = [NSMutableString string];
                NSMutableString *strName = [NSMutableString string];
                for (int i = 0; i < _selectGoods.count; i++) {
                    UserModel *user = _selectGoods[i];
                    if (i == 0) {
                        [str appendString:user.UserId];
                        [strName appendString:user.RealName];
                        
                    }else {
                        [str appendFormat:@"|%@",user.UserId];
                        [strName appendFormat:@" %@",user.RealName];
                    }
                }
                
                [self.delegate selectMengYou:str andName:strName];
                
                
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }
        }else {
            
        }
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNewMengYouList];
}

#pragma mark 网络请求

- (void)getNewMengYouList {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"identity"] = @0;
    dic[@"pageSize"] = @(1000);
    dic[@"pageIndex"] = @(1);
    dic[@"orderbyCode"] = @(-1);
    dic[@"isDesc"] = @(0);
   
    [HTMyContainAFN AFN:@"user/allylist" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"user/allylist：%@",responseObject);
        
        if ([responseObject[@"status"] intValue] == 200) {
            [self.goods removeAllObjects];
            [self.selectGoods removeAllObjects];
            NSArray *array = [UserModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            [self.goods addObjectsFromArray:array];
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark tableView

- (void)setTabalViewRefresh {
    
    __weak SelectObjectViewController *wself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewMengYouList];
    }];
    
//    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectObjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectObjectIdentify forIndexPath:indexPath];
    cell.model = self.goods[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *model = self.goods[indexPath.row];
    [self.selectGoods addObject:model];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserModel *model = self.goods[indexPath.row];
    [self.selectGoods removeObject:model];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
