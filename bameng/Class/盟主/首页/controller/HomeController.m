//
//  HomeController.m
//  bameng
//
//  Created by 刘琛 on 16/10/21.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "HomeController.h"
#import "HomeMengzhuTableViewCell.h"
#import "CustomInfoController.h"
#import "EncourageTableViewController.h"
#import "MyWalletTableViewController.h"
#import "NewOrderTableViewController.h"

@interface HomeController ()

@property (nonatomic, strong) CircleBannerView *circleView;

@end

@implementation HomeController


static NSString *homeTableCellIdentify = @"homeTableCellIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"霸盟";
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.table removeSpaces];
    [self.table registerNib:[UINib nibWithNibName:@"HomeMengzhuTableViewCell" bundle:nil] forCellReuseIdentifier:homeTableCellIdentify];
    [self.view addSubview:self.table];
    
    [self setHeadActions];
    
}

- (void)setHeadActions {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
    
    
    HomeHeadView *head = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadView" owner:self options:nil].lastObject;
    head.frame = CGRectMake(0, 0, KScreenWidth, head.frame.size.height - 210.0 * (1 - KScreenWidth / 414));
    head.circulateHeight.constant = 210.0 * (KScreenWidth / 414);
    [head layoutIfNeeded];
    self.table.tableHeaderView = head;
    [head.zhanghu bk_whenTapped:^{
        MyWalletTableViewController *wallet = [story instantiateViewControllerWithIdentifier:@"MyWalletTableViewController"];
        [self.navigationController pushViewController:wallet animated:YES];
    }];
    
    [head.neworder bk_whenTapped:^{
        NewOrderTableViewController *newOrder = [story instantiateViewControllerWithIdentifier:@"NewOrderTableViewController"];
        [self.navigationController pushViewController:newOrder animated:YES];
    }];
    
    [head.custom bk_whenTapped:^{
        CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
        custom.selectPage = 1;
        [self.navigationController pushViewController:custom animated:YES];
    }];
    [head.coalition bk_whenTapped:^{
        CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
        custom.selectPage = 3;
        [self.navigationController pushViewController:custom animated:YES];
        
    }];
    [head.exchange bk_whenTapped:^{
        CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
        custom.selectPage = 2;
        [self.navigationController pushViewController:custom animated:YES];
    }];
    [head.reward bk_whenTapped:^{
        EncourageTableViewController *encourage = [story instantiateViewControllerWithIdentifier:@"EncourageTableViewController"];
        [self.navigationController pushViewController:encourage animated:YES];
    }];
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}








- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeMengzhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableCellIdentify forIndexPath:indexPath];
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

@end
