//
//  HomeViewController.m
//  fanmore---
//
//  Created by HuoTu-Mac on 15/5/25.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HomeListViewController.h"
#import "MengZhuInfomationViewController.h"
#import "LiuXSegmentView.h"


#define pageSize 10

/**选择时候的颜色*/
#define COLOR_BACK_SELECTED [UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1]


@interface HomeListViewController ()<UIScrollViewDelegate>


@property(nonatomic,strong) UIScrollView * scrollView;



@property(nonatomic,strong) NSMutableArray< NSDictionary *> * titleArray;


@property(nonatomic,strong)  LiuXSegmentView * liuXSegmentView;
@end


@implementation HomeListViewController


- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
       UserModel * user =  [UserModel GetUserModel];
       _titleArray = [NSMutableArray array];
        [_titleArray addObject:@{@(0):@"集团资讯"}];
        [_titleArray addObject:@{@(1):@"总店资讯"}];
        if (user.ShopType != 1) {//没有分店
            [_titleArray addObject:@{@(2):@"分店咨讯"}];
        }
        if (user.UserIdentity == 1) {
            [_titleArray addObject:@{@(3):@"盟主消息"}];
        }else{
            [_titleArray addObject:@{@(4):@"盟友消息"}];
        }
    }
    return _titleArray;
}



- (void)setUpInit{
    
    
    
    
    
    
//    [self.navigationController.navigationBar  setBarTintColor:HuoBanMallBuyNavColor];
    
    self.navigationItem.title = @"资讯";
    

//    UserModel * userInfo = (UserModel *)[UserLoginTool LoginReadModelDateFromCacheDateWithFileName:RegistUserDate];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchButton];
//    self.titleHeadOption.delegate  = self;
//    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
//    btn.layer.cornerRadius = 16;
//    btn.layer.masksToBounds = YES;
//    btn.layer.borderColor = [UIColor whiteColor].CGColor;
//    btn.layer.borderWidth = 1;
//    self.leftBtn = btn;
//    [btn sd_setImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"geren"]];
//    [btn addTarget:self action:@selector(leftButton) forControlEvents:UIControlEventTouchDown];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectController:) name:@"backToHomeView" object:nil];
//    [self.taskTableview registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellReuseIdentifier:homeCellidentify];
//    self.taskTableview.rowHeight = 150;
//    self.taskTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.taskTableview.backgroundColor = [UIColor colorWithRed:0.884 green:0.890 blue:0.832 alpha:1.000]
    ;
}


- (void)setupChildViewControllers
{
    
    for (int i = 0; i<self.titleArray.count; i++) {
        MengZhuInfomationViewController * vc1 = [[UIStoryboard storyboardWithName:@"MengZhu" bundle:nil] instantiateViewControllerWithIdentifier:@"MengZhuInfomationViewController"];
        NSDictionary * dict = [self.titleArray objectAtIndex:i];
        
        LWLog(@"%d",[[[dict allKeys] firstObject] intValue]);
        vc1.type = [[[dict allKeys] firstObject] intValue];
        [self addChildViewController:vc1];
    }
    
   
    LWLog(@"xxx");

//    LWLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TheSlidingControl"]);
//
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TheSlidingControl"] intValue] != 0) {
//        
//        for (int i = 0; i < self.titleSlideArray.count; i++) {
//            ViewController * vc = [[ViewController alloc] init];
//            vc.vcType = 4;
//            SlideModel * model = [self.titleSlideArray objectAtIndex:i];
//            vc.ViewMainUrl = model.linkUrl;
//            [self addChildViewController:vc];
//        }
//
//    }else{
//        ViewController * vc = [[ViewController alloc] init];
//        vc.ViewMainUrl = self.homeUrl;
//        [self addChildViewController:vc];
//
//    }
    


}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
 
    [self setUpInit];
    
    [self setupScrollView];
   
    [self setupTitlesView];
   
    [self addChildVcView];
    

   
}


#pragma mark - 添加子控制器的view
- (void)addChildVcView
{
    // 子控制器的索引
    NSUInteger index = self.scrollView.contentOffset.x / KScreenWidth;
    
    // 取出子控制器
    UIViewController *childVc = self.childViewControllers[index];
    if ([childVc isViewLoaded]) return;
    
    childVc.view.frame = self.scrollView.bounds;
    [self.scrollView addSubview:childVc.view];
}



- (void)setupTitlesView
{
 
    __weak typeof(self) wself = self;
    NSMutableArray *title = [NSMutableArray array];
    
    for (int i = 0; i<self.titleArray.count; i++) {
        LWLog(@"%@",[self.titleArray objectAtIndex:i]);
    }

    for (int i = 0; i<[self titleArray].count; i++) {
        LWLog(@"%@",[self.titleArray objectAtIndex:i]);
        NSDictionary *dict = [self.titleArray objectAtIndex:i];
        [title addObject:[self.titleArray objectAtIndex:i][@([[[dict allKeys] firstObject] intValue])]];
    }
    
  
    self.liuXSegmentView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 44) titles:title clickBlick:^(NSInteger index) {
            [wself selectCurrentOption:index-1];
    }];
    _liuXSegmentView.titleNomalColor = [UIColor blackColor];
    _liuXSegmentView.titleSelectColor = LWColor(204,158,95);
    [self.view addSubview:_liuXSegmentView];
   
    
}



- (void)setupScrollView
{
    // 不允许自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.frame = self.view.bounds;
//    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    // 添加所有子控制器的view到scrollView中
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.frame.size.width, 0);
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
//    self.scrollView.backgroundColor = [UIColor orangeColor];
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    

}






#pragma mark titleHeadOption

- (void)selectCurrentOption:(NSInteger) index{
    
    // 让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = index * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
}


#pragma mark - <UIScrollViewDelegate>

//- (void)scrollviewend:(UIScrollView *)scrollView{
//    
//
//    if (scrollView.contentOffset.x <  0) {
//        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:^(BOOL finished) {
//        }];
//    }
//}

/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 使用setContentOffset:animated:或者scrollRectVisible:animated:方法让scrollView产生滚动动画
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addChildVcView];
}

/**
 * 在scrollView滚动动画结束时, 就会调用这个方法
 * 前提: 人为拖拽scrollView产生的滚动动画
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 选中\点击对应的按钮
    NSUInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
//    HomeTitleButton *titleButton = self.titleView.subviews[index];
//    [self.titleView titleClick:titleButton];
    
    [self.liuXSegmentView btnSlideToCurrentPageWithIndex:index];
    // 添加子控制器的view
    [self addChildVcView];
    
    // 当index == 0时, viewWithTag:方法返回的就是self.titlesView
    //    XMGTitleButton *titleButton = (XMGTitleButton *)[self.titlesView viewWithTag:index];
}


@end
