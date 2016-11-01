//
//  MYInfomationTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/1.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYInfomationViewController.h"
#import "MYInfomationTableViewCell.h"
#import "MengZhuInfomationBigTableViewCell.h"
#import "MengZhuInfomationSmallTableViewCell.h"
#import "CircleBannerView.h"

@interface MYInfomationViewController () <UITableViewDelegate,UITableViewDataSource>
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
@end

@implementation MYInfomationViewController

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
    
    __weak MYInfomationViewController *wself = self;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"tj"] style:UIBarButtonItemStylePlain handler:^(id sender) {
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
//        AddNewInfomationTableViewController *add = [story instantiateViewControllerWithIdentifier:@"AddNewInfomationTableViewController"];
//        [wself.navigationController pushViewController:add animated:YES];
//    }];
    
}

//设置选择点击事件
- (void)setSelectViewAction {
    __weak MYInfomationViewController *wself = self;
    
    self.jituan.userInteractionEnabled = YES;
    [self.jituan bk_whenTapped:^{
        if (self.selectPage != 1) {
            
            self.selectPage = 1;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.jituanLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = self.tableHeadView;
            [self.table reloadData];
        }
    }];
    
    self.zongdian.userInteractionEnabled = YES;
    [self.zongdian bk_whenTapped:^{
        if (self.selectPage != 2) {
            
            self.selectPage = 2;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.zongdianLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = self.tableHeadView;
            [self.table reloadData];
        }
    }];
    
    self.fendian.userInteractionEnabled = YES;
    [self.fendian bk_whenTapped:^{
        if (self.selectPage != 3) {
            
            self.selectPage = 3;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.fendianLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = self.tableHeadView;
            [self.table reloadData];
        }
    }];
    
    self.mengyou.userInteractionEnabled = YES;
    [self.mengyou bk_whenTapped:^{
        if (self.selectPage != 4) {
            
            self.selectPage = 4;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.mengyouLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            self.table.tableHeaderView = nil;
            [self.table reloadData];
            
        }
    }];
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


#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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
            
            return cell;
        }else {
            MengZhuInfomationSmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zixunSmallIdentify forIndexPath:indexPath];
            return cell;
        }
    }
}

@end
