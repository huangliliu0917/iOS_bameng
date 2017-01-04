//
//  CustomerTableViewController.m
//  bameng
//
//  Created by 罗海波 on 2016/12/30.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CustomerTableViewController.h"
#import "NormalTableViewCell.h"
#import "CustomResourceModel.h"
#import "customInfoDetailController.h"
#import "PhoteViewController.h"


@interface CustomerTableViewController ()


@property(nonatomic,strong) NSMutableArray <CustomResourceModel *>* dataArray;



@property (nonatomic,assign) int pageIndex;

@end

@implementation CustomerTableViewController


- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.estimatedRowHeight=213;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    
    self.navigationItem.title = @"客户资料";
    
    [self setTabalViewRefresh];
    
    [self.tableView.mj_header beginRefreshing];

    
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
    [HTMyContainAFN AFN:@"customer/reslist" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 200) {
          self.pageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
          NSArray * dataArray =  [CustomResourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
          [self.dataArray removeAllObjects];
          [self.dataArray addObjectsFromArray:dataArray];
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
    parme[@"pageIndex"] = @(self.pageIndex + 1);
    parme[@"pageSize"] = @(20);
    [HTMyContainAFN AFN:@"customer/reslist" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 200) {
            self.pageIndex = [responseObject[@"data"][@"PageIndex"] intValue];
            NSArray * dataArray =  [CustomResourceModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"Rows"]];
            [self.dataArray addObjectsFromArray:dataArray];
            [self.tableView reloadData];
        }
        
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
        [MBProgressHUD hideHUD];
    }];}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    [self.tableView tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.dataArray.count];
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NormalTableViewCell"];
    CustomResourceModel * model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomResourceModel * model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.Type == 0) {
        
        customInfoDetailController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"customInfoDetailController"];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        PhoteViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PhoteViewController"];
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
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
