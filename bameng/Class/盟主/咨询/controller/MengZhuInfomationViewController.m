//
//  MengZhuInfomationViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengZhuInfomationViewController.h"
#import "CircleBannerView.h"
#import "MengZhuInfomationBigTableViewCell.h"
#import "MengZhuInfomationSmallTableViewCell.h"
#import "AddNewInfomationTableViewController.h"
#import "MYInfomationTableViewCell.h"
#import "BMInfomationModel.h"

@interface MengZhuInfomationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) CircleBannerView *circleView;

@property (nonatomic, strong) UIView *tableHeadView;


@property (strong, nonatomic) IBOutlet UIView *chooserView;
@property (strong, nonatomic) IBOutlet UILabel *jituanLabel;
@property (strong, nonatomic) IBOutlet UILabel *zongdianLabel;
@property (strong, nonatomic) IBOutlet UILabel *fendianLabel;
@property (strong, nonatomic) IBOutlet UILabel *mengyouLabel;

@property (strong, nonatomic) IBOutlet UIView *jituan;
@property (strong, nonatomic) IBOutlet UIView *zongdian;
@property (strong, nonatomic) IBOutlet UIView *fendian;
@property (strong, nonatomic) IBOutlet UIView *mengyou;

@property (nonatomic, strong) UIView *slider;
@property (nonatomic, assign) NSInteger selectPage;


@property (nonatomic, strong) NSMutableArray *articleList;
@property (nonatomic, assign) NSInteger PageIndex;
@property (nonatomic, assign) NSInteger PageSize;

@end

@implementation MengZhuInfomationViewController

static NSString *zixunBigIdentify = @"zixunBigIdentify";
static NSString *zixunSmallIdentify = @"zixunSmallIdentify";
static NSString *infomationIdentify = @"infomationIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"资讯列表";
    
    self.selectPage = 1;
    self.slider = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth / 4 - 40) / 2, 33, 40, 2)];
    self.slider.backgroundColor = [UIColor colorWithRed:204/255.0 green:158/255.0 blue:95/255.0 alpha:1];
    [self.chooserView addSubview:self.slider];
    
    [self setSelectViewAction];
    
    [self.table registerNib:[UINib nibWithNibName:@"MengZhuInfomationBigTableViewCell" bundle:nil] forCellReuseIdentifier:zixunBigIdentify];
    [self.table registerNib:[UINib nibWithNibName:@"MengZhuInfomationSmallTableViewCell" bundle:nil] forCellReuseIdentifier:zixunSmallIdentify];
    [self.table registerNib:[UINib nibWithNibName:@"MYInfomationTableViewCell" bundle:nil] forCellReuseIdentifier:infomationIdentify];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table removeSpaces];
    [self allocTableHeadView];
    
    __weak MengZhuInfomationViewController *wself = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"tj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        AddNewInfomationTableViewController *add = [story instantiateViewControllerWithIdentifier:@"AddNewInfomationTableViewController"];
        [wself.navigationController pushViewController:add animated:YES];
    }];
    
    [self setUserReg];
    
    [self setTabalViewRefresh];
    
    self.PageSize = 20;
    self.PageIndex = 1;
    self.articleList = [NSMutableArray array];
}

//设置选择点击事件
- (void)setSelectViewAction {

    
    self.jituan.userInteractionEnabled = YES;
    [self.jituan bk_whenTapped:^{
        if (self.selectPage != 1) {
            
            self.selectPage = 1;
            
            [self selectPageChanged];
        }
    }];
    
    self.zongdian.userInteractionEnabled = YES;
    [self.zongdian bk_whenTapped:^{
        if (self.selectPage != 2) {
            
            self.selectPage = 2;
            
            [self selectPageChanged];
        }
    }];
    
    self.fendian.userInteractionEnabled = YES;
    [self.fendian bk_whenTapped:^{
        if (self.selectPage != 3) {
            
            self.selectPage = 3;
            
            [self selectPageChanged];
        }
    }];
    
    self.mengyou.userInteractionEnabled = YES;
    [self.mengyou bk_whenTapped:^{
        if (self.selectPage != 4) {
            
            self.selectPage = 4;
            
            [self selectPageChanged];
        }
    }];
}

- (void)selectPageChanged {
    switch (self.selectPage) {
        case 1:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self setAllLabelsTitleColorBlack];
                self.jituanLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = self.tableHeadView;
            [self getNewZiXunList];
            break;
        }
        case 2:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self setAllLabelsTitleColorBlack];
                self.zongdianLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = nil;
            [self getNewZiXunList];
            break;
        }
        case 3:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self setAllLabelsTitleColorBlack];
                self.fendianLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = nil;
            [self getNewZiXunList];
            break;
        }
        case 4:
        {
            [UIView animateWithDuration:0.25 animations:^{
                [self setAllLabelsTitleColorBlack];
                self.mengyouLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = nil;
            [self getNewZiXunList];
            break;
        }
        default:
            break;
    }
}

- (void)setUserReg {
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeGes)];
    left.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeGes)];
    right.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:right];
}

- (void)leftSwipeGes {
    if (self.selectPage != 1) {
        self.selectPage--;
        [self selectPageChanged];
    }
}

- (void)rightSwipeGes {
    if (self.selectPage != 4) {
        self.selectPage++;
        [self selectPageChanged];
    }
}


- (void)allocTableHeadView {
    self.tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 210 * (KScreenWidth / 414))];
    self.table.tableHeaderView = self.tableHeadView;
    self.tableHeadView.backgroundColor = [UIColor blueColor];
}


//设置全部文字黑色
- (void)setAllLabelsTitleColorBlack {
    self.jituanLabel.textColor = [UIColor blackColor];
    self.zongdianLabel.textColor = [UIColor blackColor];
    self.fendianLabel.textColor = [UIColor blackColor];
    self.mengyouLabel.textColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getCrircleList];
    
    [self getNewZiXunList];
}


#pragma mark 网络请求

- (void)getCrircleList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @0;
    [HTMyContainAFN AFN:@"sys/FocusPic" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"sys/FocusPic：%@", responseObject);
    } failure:^(NSError *error) {
        LWLog(@"%@" ,error);
    }];
}

- (void)getNewZiXunList {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"identity"] = @([self identityForZiXunList]);
    dic[@"pageSize"] = @(self.PageSize);
    dic[@"pageIndex"] = @(1);
    [HTMyContainAFN AFN:@"article/list" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"article/list：%@",responseObject);
        
        if ([responseObject[@"status"] intValue] == 200) {
            [self.articleList removeAllObjects];
            if (self.selectPage == 4) {
                
            }else {
                NSDictionary *dic = responseObject[@"data"];
                if ([dic.allKeys indexOfObject:@"top"] != NSNotFound) {
                    NSArray *array = [BMInfomationModel mj_objectArrayWithKeyValuesArray:dic[@"top"]];
                    [self.articleList addObjectsFromArray:array];
                }
                NSArray *rows = [BMInfomationModel mj_objectArrayWithKeyValuesArray:dic[@"list"][@"Rows"]];
                [self.articleList addObjectsFromArray:rows];
                self.PageIndex = [dic[@"list"][@"PageIndex"] integerValue];
                self.PageSize = [dic[@"list"][@"PageSize"] integerValue];
            }
            
            [self.table reloadData];
        }
        
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [self.table.mj_header endRefreshing];
    }];
}

- (void)getMoerZixunList {
    __weak MengZhuInfomationViewController *wself = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"identity"] = @([self identityForZiXunList]);
    dic[@"pageSize"] = @(self.PageSize);
    dic[@"pageIndex"] = @(self.PageIndex + 1);
    [HTMyContainAFN AFN:@"article/list" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"article/list：%@",responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            
            NSDictionary *dic = responseObject[@"data"];
            NSArray *rows = [BMInfomationModel mj_objectArrayWithKeyValuesArray:dic[@"list"][@"Rows"]];
            if (rows.count == 0) {
                
            }else {
                [self.articleList addObjectsFromArray:rows];
                self.PageIndex = [dic[@"list"][@"PageIndex"] integerValue];
                self.PageSize = [dic[@"list"][@"PageSize"] integerValue];
                [self.table reloadData];
            }
        }
        
        [wself.table.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [wself.table.mj_footer endRefreshing];
    }];
}


- (NSInteger)identityForZiXunList {
    switch (self.selectPage) {
        case 1:
        {
            return 0;
            break;
        }
        case 2:
        {
            return 1;
            break;
        }
        case 3:
        {
            return 2;
            break;
        }
        case 4:
        {
            return 4;
            break;
        }
        default:
            break;
            
        
    }
    return 0;
}

#pragma mark table

- (void)setTabalViewRefresh {
    
    __weak MengZhuInfomationViewController *wself = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectPage == 4) {
        return 44;
    }else {
        if (indexPath.row == 0) {
            return 95;
        }else {
            return 81;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_selectPage == 4) {
        MYInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infomationIdentify forIndexPath:indexPath];
        return cell;
    }else {
        if (indexPath.row == 0) {
            MengZhuInfomationBigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zixunBigIdentify forIndexPath:indexPath];
            cell.model = self.articleList[indexPath.row];
            return cell;
        }else {
            MengZhuInfomationSmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zixunSmallIdentify forIndexPath:indexPath];
            cell.model = self.articleList[indexPath.row];
            return cell;
        }
    }
}



@end
