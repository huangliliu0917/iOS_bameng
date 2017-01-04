//
//  InfomationViewController.m
//  bameng
//
//  Created by 罗海波 on 2016/12/29.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "InfomationViewController.h"
#import "CommonNetWorkTool.h"
#import "NewInfoParame.h"
#import "MYInfomationTableViewCell.h"
#import "PushWebViewController.h"


@interface InfomationViewController ()<PushWebViewControllerDelegate>



@property(nonatomic,strong) NSMutableArray * dataArrays;

@property(nonatomic,assign) int pageindex;


@end

@implementation InfomationViewController


- (NSMutableArray *)dataArrays{
    if (_dataArrays == nil) {
        _dataArrays = [NSMutableArray array];
    }
    return _dataArrays;
}

- (instancetype)init{
    
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        
        
    }
    
    return self;
}




- (void)setTabalViewRefresh {
    
    __weak typeof(self) wself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}


- (void)getNewZiXunList{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"pageIndex"] = @(1);
    dict[@"pageSize"] = @(20);
    dict[@"type"] = @(self.isLiuyan);
    dict[@"isSend"] = @(self.type);
    [HTMyContainAFN AFN:@"article/maillist" with:dict Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            
            self.pageindex = [responseObject[@"data"][@"PageIndex"] intValue];
            NSArray * data = [BMInfomationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            [self.dataArrays removeAllObjects];
            [self.dataArrays addObjectsFromArray:data];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        
    }];
}

- (void)getMoerZixunList{
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"pageIndex"] = @(self.pageindex + 1);
    dict[@"pageSize"] = @(20);
    dict[@"type"] = @(self.isLiuyan);
    dict[@"isSend"] = @(self.type);
    [HTMyContainAFN AFN:@"article/maillist" with:dict Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            self.pageindex = [responseObject[@"data"][@"PageIndex"] intValue];
            NSArray * data = [BMInfomationModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            if (data.count) {
                [self.dataArrays addObjectsFromArray:data];
                [self.tableView reloadData];

            }
        }
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];

    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.isLiuyan == 1) {
       self.tableView.contentInset = UIEdgeInsetsMake(108, 0, 0, 0); 
    }
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MYInfomationTableViewCell" bundle:nil] forCellReuseIdentifier:@"infomationIdentify"];
    
    [self setTabalViewRefresh];
    
    
    [self.tableView.mj_header beginRefreshing];
    
    
    [self.tableView removeSpaces];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
     [self.tableView tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.dataArrays.count];
     return self.dataArrays.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infomationIdentify" forIndexPath:indexPath];
    
    BMInfomationModel * model = self.dataArrays[indexPath.row];
    cell.model = model;
    LWLog(@"%@",[cell.model mj_keyValues]);
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMInfomationModel *model = self.dataArrays[indexPath.row];
    PushWebViewController *push = [[PushWebViewController alloc] init];
    push.openUrl = model.ArticleUrl;
    push.delegate = self;
    [self.navigationController pushViewController:push animated:YES];
}


- (void) ZhiXunRefresh{
    
    LWLog(@"xxx");
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
