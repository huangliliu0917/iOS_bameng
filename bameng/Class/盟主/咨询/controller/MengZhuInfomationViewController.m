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
#import "BMCircleModel.h"
#import "PushWebViewController.h"

@interface MengZhuInfomationViewController ()<UITableViewDelegate,UITableViewDataSource,CircleBannerViewDelegate,PushWebViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) CircleBannerView *circleView;
@property (nonatomic, strong) NSMutableArray *circleList;

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



@property(nonatomic,strong)NSIndexPath * CurrentindexPath;



@property(nonatomic,assign) NSUInteger topListCount;

@end

@implementation MengZhuInfomationViewController

static NSString *zixunBigIdentify = @"zixunBigIdentify";
static NSString *zixunSmallIdentify = @"zixunSmallIdentify";
static NSString *infomationIdentify = @"infomationIdentify";

- (NSMutableArray *)articleList{
    if (_articleList == nil) {
        
        _articleList = [NSMutableArray array];
    }
    return _articleList;
}

- (NSMutableArray *)circleList{
    if (_circleList == nil) {
        _circleList = [NSMutableArray array];
    }
    return _circleList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.navigationItem.title = @"资讯列表";
    
    self.PageIndex = 1;
    //用于轮播
    self.selectPage = 1;
//    self.circleList = [NSMutableArray array];
    
//    self.slider = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth / 4 - 40) / 2, 33, 40, 2)];
//    self.slider.backgroundColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];
//    [self.chooserView addSubview:self.slider];
    
    [self setSelectViewAction];
    
    [self.table registerNib:[UINib nibWithNibName:@"MengZhuInfomationBigTableViewCell" bundle:nil] forCellReuseIdentifier:zixunBigIdentify];
    [self.table registerNib:[UINib nibWithNibName:@"MengZhuInfomationSmallTableViewCell" bundle:nil] forCellReuseIdentifier:zixunSmallIdentify];
    [self.table registerNib:[UINib nibWithNibName:@"MYInfomationTableViewCell" bundle:nil] forCellReuseIdentifier:infomationIdentify];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table removeSpaces];
    
    
    if(self.type == 0){
        //添加头部视图
        [self allocTableHeadView];
        [self getCrircleList];
    }
    
 
    [self setUserReg];
    
    [self setTabalViewRefresh];
    
    self.PageSize = 20;
    self.PageIndex = 1;
    
    
    
    [self.table.mj_header beginRefreshing];
    
    [self.table setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [self getNewZiXunList];
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
            self.table.tableHeaderView = self.circleView;
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
    
//    self.tableHeadView.backgroundColor = [UIColor blueColor];
    
    self.circleView = [[CircleBannerView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 210 * (KScreenWidth / 414))];
    self.table.tableHeaderView = self.circleView;
    self.circleView.delegate = self;
//    [self.tableHeadView addSubview:self.circleView];
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
    
    self.tabBarController.tabBar.hidden = NO;
    
    
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
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    static NSString * Imagesizex = nil;
    [manager downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        imageView.image = image;
        if (!Imagesizex) {
            CGFloat height =  imageView.image.size.height * KScreenWidth * 1.0 / imageView.image.size.width;
            CGRect fm = circleBannerView.frame;
            fm.size.height = height;
            circleBannerView.frame = fm;
            circleBannerView.flowLayout.itemSize = fm.size;
            [circleBannerView layoutSubviews];
            [self.table setTableHeaderView:circleBannerView];
            Imagesizex = @"xxx";
        }
        LWLog(@"下载完成");
    }];
}


#pragma mark 网络请求

- (void)getCrircleList {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"type"] = @0;
    [HTMyContainAFN AFN:@"sys/FocusPic" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"sys/FocusPic：%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            NSArray *array = [BMCircleModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.circleList removeAllObjects];
            [self.circleList addObjectsFromArray:array];
            [self setCircleViewImages];
            
        }
    } failure:^(NSError *error) {
        LWLog(@"%@" ,error);
    }];
}

- (void)getNewZiXunList {
    
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"identity"] = @([self type]);
    dic[@"pageSize"] = @(self.PageSize);
    dic[@"pageIndex"] = @(1);
    
    LWLog(@"%@",dic);
    [HTMyContainAFN AFN:@"article/list" with:dic Success:^(NSDictionary *responseObject) {
        LWLog(@"article/list：%@",responseObject);
        
        if ([responseObject[@"status"] intValue] == 200) {
            [self.articleList removeAllObjects];
            if (self.type == 4 || self.type == 3) {
                
                NSDictionary *dic = responseObject[@"data"];
                LWLog(@"%@",dic[@"list"][@"Rows"]);
                NSArray *rows = [BMInfomationModel mj_objectArrayWithKeyValuesArray:dic[@"list"][@"Rows"]];
                
                
                LWLog(@"%@",responseObject[@"list"][@"Rows"]);
//                [self.articleList removeAllObjects];
                [self.articleList addObjectsFromArray:rows];
                self.PageIndex = [responseObject[@"data"][@"list"][@"PageIndex"] integerValue];
                
                LWLog(@"%ld",(long)self.PageIndex);
                self.PageSize = [responseObject[@"data"][@"list"][@"PageSize"] integerValue];
            }else {
                NSDictionary *dic = responseObject[@"data"];
                if ([dic.allKeys indexOfObject:@"top"] != NSNotFound) {
                    NSArray *array = [BMInfomationModel mj_objectArrayWithKeyValuesArray:dic[@"top"]];
                    self.topListCount = array.count;
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
    
    dic[@"identity"] = @([self type]);
    dic[@"pageSize"] = @(self.PageSize);
    dic[@"pageIndex"] = @(self.PageIndex + 1);
    LWLog(@"%@",dic);
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
    [self.table tableViewDisplayWitMsg:nil ifNecessaryForRowCount:self.articleList.count];
    return self.articleList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 4 || self.type == 3) {
        return 44;
    }else {
        if (indexPath.row == 0) {
            return 105;
        }else {
            return 90;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 4 || self.type == 3) {
        MYInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:infomationIdentify forIndexPath:indexPath];
        
        BMInfomationModel * model = self.articleList[indexPath.row];
        cell.model = model;
        LWLog(@"%@",[cell.model mj_keyValues]);
        return cell;
    }else {
        if (self.topListCount>0 && indexPath.row < self.topListCount){
            MengZhuInfomationBigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zixunBigIdentify forIndexPath:indexPath];
            cell.model = self.articleList[indexPath.row];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else {
            MengZhuInfomationSmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zixunSmallIdentify forIndexPath:indexPath];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.model = self.articleList[indexPath.row];
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.CurrentindexPath = indexPath;
    BMInfomationModel *model = self.articleList[indexPath.row];
    PushWebViewController *push = [[PushWebViewController alloc] init];
    push.openUrl = model.ArticleUrl;
    if (self.type == 4 || self.type == 3){
        push.delegate = self;
    }
    
    [self.navigationController pushViewController:push animated:YES];
    

}

- (void) ZhiXunRefresh{
    
    
    LWLog(@"%@",self.CurrentindexPath);
    BMInfomationModel *model = self.articleList[self.CurrentindexPath.row];
    if (!model.IsRead) {
        model.IsRead = YES;
        self.articleList[self.CurrentindexPath.row] = model;
        LWLog(@"%lu",(unsigned long)self.articleList.count);
        [self.table reloadRowsAtIndexPaths:[NSArray arrayWithObjects:self.CurrentindexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    }

  
}
@end
