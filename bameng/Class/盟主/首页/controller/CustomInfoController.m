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

@interface CustomInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UILabel *untreatedLabel;
@property (strong, nonatomic) IBOutlet UILabel *processedLabel;


@property (nonatomic, assign) BOOL isUntreated;

@end

@implementation CustomInfoController

static NSString *untreatedIdentify = @"untreatedIdentify";
static NSString *processedIdentify = @"processedIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    __weak CustomInfoController *wself = self;
    
    [self.untreated bk_whenTapped:^{
        if (!_isUntreated) {
            _isUntreated = YES;
            [UIView animateWithDuration:0.25 animations:^{
                wself.untreatedLabel.textColor = MainColor;
                wself.processedLabel.textColor = [UIColor blackColor];
                self.slider.frame = CGRectMake((KScreenWidth / 2 - 77) / 2, 33, 77, 2);
            }];
            
            [self.table reloadData];
        }
    }];
    
    [self.processed bk_whenTapped:^{
        if (_isUntreated) {
            _isUntreated = NO;
            [UIView animateWithDuration:0.25 animations:^{
                wself.processedLabel.textColor = MainColor;
                wself.untreatedLabel.textColor = [UIColor blackColor];
                self.slider.frame = CGRectMake((KScreenWidth / 2 - 77) / 2 + KScreenWidth / 2, 33, 77, 2);
            }];
            
            [self.table reloadData];
        }
    }];
    
    
    if (self.selectPage == 1) {
        
        //客户信息页面
        
        self.title = @"客户信息";
        self.untreatedLabel.text = @"未处理信息";
        self.processedLabel.text = @"已处理信息";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"tj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
            
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
            SubmitUserInfoTableViewController *submit = [story instantiateViewControllerWithIdentifier:@"SubmitUserInfoTableViewController"];
            [wself.navigationController pushViewController:submit animated:YES];
        }];
    }else if (self.selectPage == 2) {
        //2兑换审核
        self.title = @"兑换审核";
        self.untreatedLabel.text = @"未处理申请";
        self.processedLabel.text = @"已处理申请";
        
        
    }else if (self.selectPage == 3) {
        //3我的联盟
        self.title = @"我的联盟";
        self.untreatedLabel.text = @"盟友申请";
        self.processedLabel.text = @"盟友列表";
        
    }
    
    
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.selectPage == 1) {
        if (_isUntreated) {
            
            UntreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:untreatedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectPage = self.selectPage;
            return cell;
            
        }else {
            
            ProcessedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:processedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectPage = self.selectPage;
            return cell;
        }
    }else if (self.selectPage == 2) {
        
        if (_isUntreated) {
            
            UntreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:untreatedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectPage = self.selectPage;
            return cell;
            
        }else {
            
            ProcessedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:processedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectPage = self.selectPage;
            return cell;
        }
    }else if (self.selectPage == 3) {
        
        if (_isUntreated) {
            
            UntreatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:untreatedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectPage = self.selectPage;
            return cell;
            
        }else {
            
            ProcessedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:processedIdentify forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectPage = self.selectPage;
            return cell;
        }
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (self.selectPage == 1) {
        if (_isUntreated) {
            return 108;
        }else {
            return 76;
        }
    }else if (self.selectPage == 2) {
        if (_isUntreated) {
            return 108;
        }else {
            return 76;
        }
    }else if (self.selectPage == 3) {
        if (_isUntreated) {
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
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        
        if (_isUntreated) {
            
            CustomInformationauditTableViewController *info = [story instantiateViewControllerWithIdentifier:@"CustomInformationauditTableViewController"];
            [self.navigationController pushViewController:info animated:YES];
            
        }else {
            
            CustomDetailsTableViewController *detail = [story instantiateViewControllerWithIdentifier:@"CustomDetailsTableViewController"];
            [self.navigationController pushViewController:detail animated:YES];
            
        }
    }else if (self.selectPage == 2) {
        
        
    }else if (self.selectPage == 3) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];

        if (_isUntreated) {
            AllyReviewTableViewController *review = [story instantiateViewControllerWithIdentifier:@"AllyReviewTableViewController"];
            [self.navigationController pushViewController:review animated:YES];
        }else {
            AllyInfomationTableViewController *info = [story instantiateViewControllerWithIdentifier:@"AllyInfomationTableViewController"];
            [self.navigationController pushViewController:info animated:YES];
        }
        
    }
}

@end
