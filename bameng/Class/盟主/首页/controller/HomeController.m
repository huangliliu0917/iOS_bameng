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
#import "MyCoreLocation.h"
#import "CustomSlideViewController.h"
#import "MJChiBaoZiHeader.h"

@interface HomeController ()<CircleBannerViewDelegate,MyCoreLocationDelegate>

@property (nonatomic, strong) CircleBannerView *circleView;

@property (nonatomic, strong) HomeHeadView * head;

@property (nonatomic, assign) NSInteger PageIndex;
@property (nonatomic, assign) NSInteger PageSize;

@property (nonatomic, strong) NSMutableArray *articleList;
@property (nonatomic, strong) NSMutableArray *circleList;




/**定位*/
@property(nonatomic,strong) MyCoreLocation * core;
/**城市按钮*/
@property(nonatomic,strong) UIButton * cityBtn;


@property(nonatomic,assign) CGFloat scrollH;
@property(nonatomic,assign) CGFloat scrollHW;


@end

@implementation HomeController


static NSString *homeTableCellIdentify = @"homeTableCellIdentify";


- (UIButton *)cityBtn{
    if (_cityBtn == nil) {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cityBtn.frame = CGRectMake(0, 0, 80, 30);
        [_cityBtn setTitle:@"未知" forState:UIControlStateNormal];
        [_cityBtn.titleLabel setFont:[UIFont fontWithName:@"ArialMT"size:15]];
        [_cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        [_cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -27, 0, 0)];
        [_cityBtn setImage:[UIImage imageNamed:@"gps"] forState:UIControlStateNormal];
    }
    return _cityBtn;
}



/*
 * 定位服务
 */
- (void) MyCoreLocationTakeBackCity:(NSString *)city andLatLong:(NSString *)info{
    LWLog(@"%@---%@",city,info);
    if (city.length) {
        [self.cityBtn setTitle:city forState:UIControlStateNormal];
        [_core MyCoreLocationStopLocal];
        NSMutableDictionary * pareme = [NSMutableDictionary dictionary];
        pareme[@"mylocation"] = city;
        pareme[@"lnglat"] = info;
        [HTMyContainAFN AFN:@"sys/MyLocation" with:pareme Success:^(NSDictionary *responseObject) {
            LWLog(@"sys/MyLocation：%@", responseObject);
        } failure:^(NSError *error) {
            LWLog(@"%@" ,error);
        }];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setMinimumDismissTimeInterval:0.7];
    
    self.navigationItem.title = @"霸盟";
    
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
    
    
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[self cityBtn]];
    
    _core = [MyCoreLocation MyCoreLocationShare];
    _core.delegate = self;
    [_core MyCoreLocationStartLocal];
    
    [self getCrircleList];
    
    [self getNewZiXunList];
    
}


- (void)setHeadActions {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
    
    
    HomeHeadView *head = [[NSBundle mainBundle] loadNibNamed:@"HomeHeadView" owner:self options:nil].lastObject;
    head.backgroundColor = [UIColor redColor];
    _head = head;
    head.frame = CGRectMake(0, 0, KScreenWidth, KScreenWidth * 328.0 / 375);
    self.scrollHW = KScreenWidth * 328.0 / 375;
    head.circulateHeight.constant = 210.0 * KScreenWidth / 375;
    [head layoutIfNeeded];
    
    self.circleView = [[CircleBannerView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 210.0 * KScreenWidth / 375)];
    self.scrollH = 210.0 * KScreenWidth / 375;
    self.circleView.delegate = self;
    [head.circulateView addSubview:self.circleView];
    
    self.table.tableHeaderView = head;
    //中间6个栏目选择
    [head.zhanghu bk_whenTapped:^{
        
        LWLog(@"%@",[NSThread currentThread]);
        MyWalletTableViewController *wallet = [story instantiateViewControllerWithIdentifier:@"MyWalletTableViewController"];
        [self.navigationController pushViewController:wallet animated:YES];
    }];
    
    [head.neworder bk_whenTapped:^{
        NewOrderTableViewController *newOrder = [story instantiateViewControllerWithIdentifier:@"NewOrderTableViewController"];
        [self.navigationController pushViewController:newOrder animated:YES];
    }];
    
    [head.custom bk_whenTapped:^{//客户信息
        
        CustomSlideViewController * vc = [[CustomSlideViewController alloc] init];
        vc.selectPage = 1;
//        CustomInfoController *custom = [story instantiateViewControllerWithIdentifier:@"CustomInfoController"];
//        custom.selectPage = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [head.coalition bk_whenTapped:^{//我的联盟
        CustomSlideViewController * vc = [[CustomSlideViewController alloc] init];
        vc.selectPage = 3;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [head.exchange bk_whenTapped:^{
        CustomSlideViewController * vc = [[CustomSlideViewController alloc] init];
        vc.selectPage = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [head.reward bk_whenTapped:^{//奖励设置
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
    
    //[self getCrircleList];
    
    //[self getNewZiXunList];
    
    
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
    self.circleView.interval = 5;
    self.circleView.scrollDirection = CircleBannerViewScrollDirectionHorizontal;
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

- (void)imageView:(UIImageView *)imageView loadImageForUrl:(NSString *)url bringBack:(CircleBannerView *)circleBannerView{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"banner"] options:SDWebImageRefreshCached];
    
     imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    static NSString * Imagesize = nil;
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        imageView.image = image;
        
        
        if (!Imagesize) {
            CGFloat height =  imageView.image.size.height * KScreenWidth * 1.0 / imageView.image.size.width;
            CGRect fm = circleBannerView.frame;
            fm.size.height = height;
            circleBannerView.frame = fm;
            circleBannerView.flowLayout.itemSize = fm.size;
//            [self ToRefreshUiWithWidges];
            [circleBannerView layoutSubviews];
            
            LWLog(@"%@",[NSThread currentThread]);
            self.head.circulateHeight.constant = height;
            CGRect fmx = self.head.frame;
            
            LWLog(@"%@",NSStringFromCGRect(fmx));
            if (height - self.scrollH) {
                fmx.size.height += height - self.scrollH;
            }else{
                fmx.size.height -= height - self.scrollH;
            }
           
//            CGRect newFrame = self.head.frame;
//            newFrame.size.height = newFrame.size.height + webView.frame.size.height;
            self.head.frame = fmx;
            [self.table setTableHeaderView:self.head];
//
//            self.head.frame = fmx;
//            
//            [self.table layoutIfNeeded];
//            [self.table layoutSubviews];
            Imagesize = @"xxx";
        }
        
        NSLog(@"下载完成");
    }];

    
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

- (void)headrefresh{
//    [self getCrircleList];
    [self getNewZiXunList];
    
}
- (void)setTabalViewRefresh {
     __weak HomeController *wself = self;
    
    MJChiBaoZiHeader * head = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(headrefresh)];
//    MJChiBaoZiHeader * head = [MJChiBaoZiHeader headerWithRefreshingBlock:^{
//        [wself getCrircleList];
//        [wself getNewZiXunList];
//    }];
   head.lastUpdatedTimeLabel.hidden = YES;
    head.backgroundColor = LWColor(249, 249, 249);
    head.labelLeftInset = 0;
//    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self getCrircleList];
//        [wself getNewZiXunList];
//    }];
    self.table.mj_header = head;
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
