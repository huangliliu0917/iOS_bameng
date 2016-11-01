//
//  MyBusinessViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyBusinessViewController.h"
#import "MyBusinessTableViewCell.h"
#import "OrderDetailTableViewController.h"
#import "NewOrderTableViewController.h"

@interface MyBusinessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *all;
@property (strong, nonatomic) IBOutlet UIView *unfilledOrders;
@property (strong, nonatomic) IBOutlet UIView *clinchOrders;
@property (strong, nonatomic) IBOutlet UIView *chargeBack;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIView *chooserView;
@property (strong, nonatomic) IBOutlet UILabel *allLabel;
@property (strong, nonatomic) IBOutlet UILabel *unfilledOrdersLabel;
@property (strong, nonatomic) IBOutlet UILabel *clinchOrdersLabel;
@property (strong, nonatomic) IBOutlet UILabel *chargeBackLabel;

@property (nonatomic, strong) UIView *slider;
@property (nonatomic, assign) NSInteger selectPage;

@end

@implementation MyBusinessViewController

static NSString *myBusinessIdentify = @"myBusinessIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"我的订单";
    
    self.selectPage = 1;
    self.slider = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth / 4 - 40) / 2, 33, 40, 2)];
    self.slider.backgroundColor = [UIColor colorWithRed:204/255.0 green:158/255.0 blue:95/255.0 alpha:1];
    [self.chooserView addSubview:self.slider];

    [self setSelectViewAction];
    
    [self.table registerNib:[UINib nibWithNibName:@"MyBusinessTableViewCell" bundle:nil] forCellReuseIdentifier:myBusinessIdentify];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table removeSpaces];
    
#warning 盟友没有新建选项
    NSString *identify = [[NSUserDefaults standardUserDefaults] objectForKey:mengyouIdentify];
    if ([identify isEqualToString:isMengYou]) {
        
    }else {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"tj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
            NewOrderTableViewController *newOrder = [story instantiateViewControllerWithIdentifier:@"NewOrderTableViewController"];
            [self.navigationController pushViewController:newOrder animated:YES];
            
            
        }];
        
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

//设置选择点击事件
- (void)setSelectViewAction {
    __weak MyBusinessViewController *wself = self;
    
    [self.all bk_whenTapped:^{
        if (self.selectPage != 1) {
            
            self.selectPage = 1;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.allLabel.textColor = MainColor;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
    
    [self.unfilledOrders bk_whenTapped:^{
        if (self.selectPage != 2) {
            
            self.selectPage = 2;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.unfilledOrdersLabel.textColor = MainColor;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
    
    [self.clinchOrders bk_whenTapped:^{
        if (self.selectPage != 3) {
            
            self.selectPage = 3;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.clinchOrdersLabel.textColor = MainColor;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
    
    [self.chargeBack bk_whenTapped:^{
        if (self.selectPage != 4) {
            
            self.selectPage = 4;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.chargeBackLabel.textColor = MainColor;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
}

//设置全部文字黑色
- (void)setAllLabelsTitleColorBlack {
    self.allLabel.textColor = [UIColor blackColor];
    self.unfilledOrdersLabel.textColor = [UIColor blackColor];
    self.clinchOrdersLabel.textColor = [UIColor blackColor];
    self.chargeBackLabel.textColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBusinessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myBusinessIdentify forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
#warning 根据身份进不同的页面
    NSString *identify = [[NSUserDefaults standardUserDefaults] objectForKey:mengyouIdentify];
    if ([identify isEqualToString:isMengYou]) {

    }else {
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        OrderDetailTableViewController *ordor = [story instantiateViewControllerWithIdentifier:@"OrderDetailTableViewController"];
        [self.navigationController pushViewController:ordor animated:YES];
    }
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
