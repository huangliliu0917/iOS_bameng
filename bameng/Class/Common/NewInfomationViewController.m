//
//  NewInfomationViewController.m
//  bameng
//
//  Created by 罗海波 on 2016/12/29.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "NewInfomationViewController.h"
#import "LiuXSegmentView.h"
#import "MengZhuInfomationViewController.h"
#import "InfomationViewController.h"
#import "AddNewInfomationTableViewController.h"
#import "MYAddNewMessageTableViewController.h"
#import "HeadTitle.h"
#import "AppDelegate.h"


@interface NewInfomationViewController ()<UIScrollViewDelegate,HeadTitleDelegate>
@property(nonatomic,strong) UIScrollView * scrollView;


@property(nonatomic,strong) NSMutableArray * titleArray;


@property(nonatomic,strong)  HeadTitle * head;


@end

@implementation NewInfomationViewController





- (NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        UserModel * user =  [UserModel GetUserModel];
        _titleArray = [[NSMutableArray alloc] init];
        [_titleArray addObject:@"发送消息"];
        if (user.UserIdentity == 1) {
            [_titleArray addObject:@"接收消息"];
        }else{
            [_titleArray addObject:@"接收消息"];
        }
    }
    return _titleArray;
}



- (void)setUpInit{
    

    self.navigationItem.title = @"我的消息";
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"新增" forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage imageNamed:@"tj"] forState:UIControlStateNormal];
    [rightBtn sizeToFit];
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    [rightBtn.titleLabel setFont:[UIFont fontWithName:@"ArialMT"size:15]];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(addInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];

    
}

- (void)addInfo{
    UserModel * user = [UserModel GetUserModel];
    if (user.UserIdentity) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        AddNewInfomationTableViewController *add = [story instantiateViewControllerWithIdentifier:@"AddNewInfomationTableViewController"];
        [self.navigationController pushViewController:add animated:YES];
        
    }else{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
        MYAddNewMessageTableViewController *add = [story instantiateViewControllerWithIdentifier:@"MYAddNewMessageTableViewController"];
        [self.navigationController pushViewController:add animated:YES];
    }
}


- (void)setupChildViewControllers
{
    
    InfomationViewController * vc1 = [[InfomationViewController alloc] init];
    vc1.type = 1;
    vc1.isLiuyan = 1;
    [self addChildViewController:vc1];
    
    InfomationViewController * vc2 = [[InfomationViewController alloc] init];
    vc2.type = 0;
    vc2.isLiuyan = 1;
    [self addChildViewController:vc2];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupChildViewControllers];
    
    [self setUpInit];
    
    [self setupScrollView];
    
    [self setupTitlesView];
    
    [self addChildVcView];
    
    
    
    
    AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
    
    LWLog(@"%d",app.messageRed.messagePullCount);
     LWLog(@"%d",app.messageRed.messagePushCount);
    if (app.messageRed.messagePullCount) {
        self.head.secondredView.hidden = NO;
    }
    if (app.messageRed.messagePushCount) {
        self.head.secondredView.hidden = NO;
    }
    
    
    [app.messageRed addObserver:self forKeyPath:@"messagePullCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [app.messageRed addObserver:self forKeyPath:@"messagePushCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [app.messageRed addObserver:self forKeyPath:@"messageCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    //    [self.tableView.mj_footer beginRefreshing];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
    
    
    if([keyPath isEqualToString:@"messagePullCount"] )
    {
        if(app.messageRed.messagePullCount > 0){
            self.head.secondredView.hidden = NO;
            
        }else{
            self.head.secondredView.hidden = YES;
        }
        
        
    }else if([keyPath isEqualToString:@"messagePushCount"]){
        
        if(app.messageRed.messagePushCount > 0){
            self.head.firstRedView.hidden = NO;
            
        }else{
            self.head.firstRedView.hidden = YES;
        }
        
    }
    
    
}

- (void)dealloc{
    
    AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
    [app.messageRed removeObserver:self forKeyPath:@"messagePullCount"];
    [app.messageRed removeObserver:self forKeyPath:@"messagePushCount"];
    [app.messageRed removeObserver:self forKeyPath:@"messageCount"];
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
    
    HeadTitle * head = [HeadTitle HeadTitleCreate];
    self.head= head;
    self.head.secondredView.hidden = YES;
    self.head.firstRedView.hidden = YES;
    head.delegate = self;
    head.frame = CGRectMake(0, 64, KScreenWidth, 44);
    [self.view addSubview:head];
    
    
//    __weak typeof(self) wself = self;
//    self.liuXSegmentView = [[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, 44) titles:[self titleArray] clickBlick:^(NSInteger index) {
//        [wself selectCurrentOption:index-1];
//    }];
//    _liuXSegmentView.titleNomalColor = [UIColor blackColor];
//    _liuXSegmentView.titleSelectColor = LWColor(204,158,95);
//    [self.view addSubview:_liuXSegmentView];
//    
//    
//    UIView * red = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//    red.backgroundColor= [UIColor redColor];
//    [self.view addSubview:red];
//    
}

- (void) HeadTitleDelegateWith:(int)item{
    
    // 让UIScrollView滚动到对应位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = (item - 1) * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
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
    
    [self.head slideviewToWithItem:index + 1];
    // 添加子控制器的view
    [self addChildVcView];
    
    // 当index == 0时, viewWithTag:方法返回的就是self.titlesView
    //    XMGTitleButton *titleButton = (XMGTitleButton *)[self.titlesView viewWithTag:index];
}


@end



