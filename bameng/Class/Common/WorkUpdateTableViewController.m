//  工作汇报
//  WorkUpdateTableViewController.m
//  bameng
//
//  Created by 罗海波 on 2017/1/3.
//  Copyright © 2017年 HT. All rights reserved.
//

#import "WorkUpdateTableViewController.h"
#import "WoekTableViewCell.h"
#import "WorkModel.h"
#import "PushWebViewController.h"

@interface WorkUpdateTableViewController ()


@property(nonatomic,strong) NSMutableArray * dataArray;

@property(nonatomic,assign) int PageIndex;


@end

@implementation WorkUpdateTableViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (instancetype)init{
   return  [super initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"工作汇报";
    
    [self setTabalViewRefresh];
    
    
    self.tableView.rowHeight = 44;
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView removeSpaces];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn  setImage:[UIImage imageNamed:@"tj"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(addJob) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}


- (void)addJob{
    BassModel * model = [BassModel GetBassModel];
    PushWebViewController *push = [[PushWebViewController alloc] init];
    NSString * place =  [NSString stringWithFormat:@"%@?addr=%@",model.reportUrl,[[NSUserDefaults standardUserDefaults] objectForKey:@"detailaddress"]];

    NSString* string2 = [place stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:place]];
    LWLog(@"%@",string2);
    push.openUrl = string2;
    [self.navigationController pushViewController:push animated:YES];
    
    
}

- (void)setTabalViewRefresh {
    
    __weak typeof(self) wself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}


- (void)getNewZiXunList{
    
    [MBProgressHUD showMessage:nil];
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"pageIndex"] = @(1);
    parme[@"pageSize"] = @(20);
    [HTMyContainAFN AFN:@"user/reportlist" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 200) {
           self.PageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
           NSArray * data = [WorkModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"] ];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:data];
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [MBProgressHUD hideHUD];
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)getMoerZixunList{
    
    [MBProgressHUD showMessage:nil];
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"pageIndex"] = @(self.PageIndex + 1);
    parme[@"pageSize"] = @(20);
    [HTMyContainAFN AFN:@"user/reportlist" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 200) {
            self.PageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
            NSArray * data = [WorkModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"] ];
            if (data.count) {
                [self.dataArray addObjectsFromArray:data];
                [self.tableView reloadData];
            }
        }
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [MBProgressHUD hideHUD];
        [self.tableView.mj_footer endRefreshing];
    }];

}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    [tableView tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.dataArray.count];
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WoekTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WoekTableViewCell"];
    if (cell == nil) {
        
        cell = [[WoekTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"WoekTableViewCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
   
    WorkModel * model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkModel * model = [self.dataArray objectAtIndex:indexPath.row];
    PushWebViewController *push = [[PushWebViewController alloc] init];
    push.openUrl = model.reportUrl;
    [self.navigationController pushViewController:push animated:YES];
}

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
