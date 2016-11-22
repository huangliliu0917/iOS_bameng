//
//  MengDouTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengDouTableViewController.h"
#import "MengDouTableViewCell.h"
#import "MenDouBeanExchageLists.h"

@interface MengDouTableViewController ()
@property (strong, nonatomic) IBOutlet UILabel *incomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *expendLabel;




@property(nonatomic,strong) NSMutableArray<MenDouBeanExchageLists*> * dataList;

@end

@implementation MengDouTableViewController

static NSString *mengdouIdentify = @"mengdouIdentify";




- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.navigationItem.title = @"盟豆";
    

    [self.tableView removeSpaces];
    
    
    [self setTabalViewRefresh];
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MengDouTableViewCell" bundle:nil] forCellReuseIdentifier:mengdouIdentify];
    
    [self.tableView.mj_header beginRefreshing];
    

    
}


- (void)setTabalViewRefresh {
    
    __weak typeof (self) wself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}

- (void)getMoerZixunList{
    NSMutableDictionary * parme = [NSMutableDictionary dictionary];
    MenDouBeanExchageLists * model = [self.dataList lastObject];
    LWLog(@"%@",[model mj_keyValues]);
    parme[@"lastId"] = @([self.dataList lastObject].ID);
    [HTMyContainAFN AFN:@"user/BeanFlowList" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            self.incomeLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"income"]];
            self.expendLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"outcome"]];
            NSArray * array = [MenDouBeanExchageLists mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (array.count) {
                [self.dataList addObjectsFromArray:array];
                [self.tableView reloadData];
            }
        }
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.tableView.mj_footer endRefreshing];
    }];

    
}

- (void)getNewZiXunList{
    NSMutableDictionary * parme = [NSMutableDictionary dictionary];
    parme[@"lastId"] = @(0);
    [HTMyContainAFN AFN:@"user/BeanFlowList" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            self.incomeLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"income"]];
            self.expendLabel.text = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"outcome"]];
            NSArray * array = [MenDouBeanExchageLists mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            if (array.count) {
                [self.dataList removeAllObjects];
                [self.dataList addObjectsFromArray:array];
                [self.tableView reloadData];
            }
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
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

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MengDouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mengdouIdentify forIndexPath:indexPath];
    cell.model = self.dataList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
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
