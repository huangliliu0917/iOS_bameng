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

@interface MengYouHomeViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIButton *loacationButton;

@end

@implementation MengYouHomeViewController

static NSString *mengYouHomeIdentify = @"mengYouHomeIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView removeSpaces];
    [self.tableView registerNib:[UINib nibWithNibName:@"MengYouHomeTableViewCell" bundle:nil] forCellReuseIdentifier:mengYouHomeIdentify];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak MengYouHomeViewController *wself = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"tj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
        MYSubmitInfoTableViewController *sub = [story instantiateViewControllerWithIdentifier:@"MYSubmitInfoTableViewController"];
        [wself.navigationController pushViewController:sub animated:YES];
    }];
    
    
    self.loacationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 35)];
    [self.loacationButton setImage:[UIImage imageNamed:@"gps"] forState:UIControlStateNormal];
    [self.loacationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loacationButton setTitle:@"杭州" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.loacationButton];
    
    self.title = @"业务客户";
    
    
    
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MengYouHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mengYouHomeIdentify forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
    MYCustomDetailTableViewController *custom = [story instantiateViewControllerWithIdentifier:@"MYCustomDetailTableViewController"];
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
