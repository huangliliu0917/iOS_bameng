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
#import <MJRefresh/MJRefreshHeader.h>
#import "BMInfomationModel.h"
#import "PushWebViewController.h"
#import "BMCircleModel.h"

@interface HomeController ()<CircleBannerViewDelegate>

@property (nonatomic, strong) CircleBannerView *circleView;


@property (nonatomic, assign) NSInteger PageIndex;
@property (nonatomic, assign) NSInteger PageSize;

@property (nonatomic, strong) NSMutableArray *articleList;
@property (nonatomic, strong) NSMutableArray *circleList;

@end

@implementation HomeController


static NSString *homeTableCellIdentify = @"homeTableCellIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:0.7];
    
    self.title = @"霸盟";
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.table removeSpaces];
    [self.table registerNib:[UINib nibWithNibName:@"HomeMengzhuTableViewCell" bundle:nil] forCellReuseIdentifier:homeTableCellIdentify];
    [self.view addSubview:self.table];
    
    self.PageSize = 20;
    self.PageIndex = 1;
    self.articleList = [NSMutableArray array];
    self.circleList = [NSMutableArray array];
    
    [self setHeadActions];
    
}


- (void)setHeadActions {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
    
    
    HomeHeadView *head = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadView" owner:self options:nil].lastObject;
    head.frame = CGRectMake(0, 0, KScreenWidth, head.frame.size.height - 210.0 * (1 - KScreenWidth / 414));
    head.circulateHeight.constant = 210.0 * (KScreenWidth / 414);
    [head layoutIfNeeded];
    
    self.circleView = [[CircleBannerView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 210.0 * (KScreenWidth / 414))];
    self.circleView.delegate = self;
    [head.circulateView addSubview:self.circleView];
    
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
    
    [head.moreNews bk_whenTapped:^{
        [self.tabBarController setSelectedIndex:1];
    }];
    
    [self setTabalViewRefresh];
}




- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    [self getCrircleList];
    
    [self getNewZiXunList];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark circleView 

- (void)setCircleViewImages {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.circleList.count; i++) {
        BMCircleModel *model = self.circleList[i];
        [array addObject:model.PicUrl];
    }
    [self.circleView initSubviews];
    [self.circleView bannerWithImageArray:array];
}

- (void)bannerView:(CircleBannerView *)bannerView didSelectAtIndex:(NSUInteger)index{
    
    BMCircleModel *model = self.circleList[index];
    
    if (model.LinkUrl.length != 0) {
        PushWebViewController *push = [[PushWebViewController alloc] init];
        push.openUrl = model.LinkUrl;
        [self.navigationController pushViewController:push animated:YES];
    }
    
}

- (void)imageView:(UIImageView *)imageView loadImageForUrl:(NSString *)url {
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"banner"] options:SDWebImageRefreshCached];
}

#pragma mark 网络请求

- (void)getCrircleList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @2;
    [HTMyContainAFN AFN:@"sys/FocusPic" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"sys/FocusPic：%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray *array = [BMCircleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.circleList addObjectsFromArray:array];
            
            [self setCircleViewImages];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@" ,error);
    }];
}

- (void)getNewZiXunList {
    

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"identity"] = @0;
    dic[@"pageSize"] = @(self.PageSize);
    dic[@"pageIndex"] = @(1);
    [HTMyContainAFN AFN:@"article/list" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"article/list：%@",responseObject);
        
        if ([responseObject[@"status"] intValue] == 200) {
            
            [self.articleList removeAllObjects];
            NSDictionary *dic = responseObject[@"data"];
            if ([dic.allKeys indexOfObject:@"top"] != NSNotFound) {
                NSArray *array = [BMInfomationModel mj_objectArrayWithKeyValuesArray:dic[@"top"]];
                [self.articleList addObjectsFromArray:array];
            }
            NSArray *rows = [BMInfomationModel mj_objectArrayWithKeyValuesArray:dic[@"list"][@"Rows"]];
            [self.articleList addObjectsFromArray:rows];
            self.PageIndex = [dic[@"list"][@"PageIndex"] integerValue];
            self.PageSize = [dic[@"list"][@"PageSize"] integerValue];
            
            [self.table reloadData];
        }
        
        [self.table.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [self.table.mj_header endRefreshing];
    }];
}

- (void)getMoerZixunList {
    __weak HomeController *wself = self;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"identity"] = @0;
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


#pragma mark tabelView 

- (void)setTabalViewRefresh {
    
    __weak HomeController *wself = self;
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself getNewZiXunList];
    }];
    
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMoerZixunList)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BMInfomationModel *model = self.articleList[indexPath.row];
    
    PushWebViewController *push = [[PushWebViewController alloc] init];
    push.openUrl = model.ArticleUrl;
    [self.navigationController pushViewController:push animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articleList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeMengzhuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeTableCellIdentify forIndexPath:indexPath];
    cell.model = self.articleList[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

@end
