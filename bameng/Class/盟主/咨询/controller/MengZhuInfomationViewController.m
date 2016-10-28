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

@interface MengZhuInfomationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) CircleBannerView *circleView;


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

@implementation MengZhuInfomationViewController

static NSString *zixunBigIdentify = @"zixunBigIdentify";
static NSString *zixunSmallIdentify = @"zixunSmallIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectPage = 1;
    self.slider = [[UIView alloc] initWithFrame:CGRectMake((KScreenWidth / 4 - 40) / 2, 33, 40, 2)];
    self.slider.backgroundColor = [UIColor colorWithRed:204/255.0 green:158/255.0 blue:95/255.0 alpha:1];
    [self.chooserView addSubview:self.slider];
    
    [self setSelectViewAction];
    
    [self.table registerNib:[UINib nibWithNibName:@"MengZhuInfomationBigTableViewCell" bundle:nil] forCellReuseIdentifier:zixunBigIdentify];
    [self.table registerNib:[UINib nibWithNibName:@"MengZhuInfomationSmallTableViewCell" bundle:nil] forCellReuseIdentifier:zixunSmallIdentify];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table removeSpaces];
    
}

//设置选择点击事件
- (void)setSelectViewAction {
    __weak MengZhuInfomationViewController *wself = self;
    
    [self.jituan bk_whenTapped:^{
        if (self.selectPage != 1) {
            
            self.selectPage = 1;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.jituanLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
    
    [self.zongdian bk_whenTapped:^{
        if (self.selectPage != 1) {
            
            self.selectPage = 2;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.zongdianLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
    
    [self.fendian bk_whenTapped:^{
        if (self.selectPage != 1) {
            
            self.selectPage = 3;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.fendianLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
    
    [self.mengyou bk_whenTapped:^{
        if (self.selectPage != 1) {
            
            self.selectPage = 4;
            [UIView animateWithDuration:0.25 animations:^{
                [wself setAllLabelsTitleColorBlack];
                wself.mengyouLabel.textColor = [UIColor colorWithRed:248/255.0 green:152/255.0 blue:155/255.0 alpha:1];;
                self.slider.frame =  CGRectMake((KScreenWidth / 4 - 40) / 2 + (self.selectPage - 1) * KScreenWidth / 4, 33, 40, 2);
            }];
            
        }
    }];
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
    if (indexPath.row == 0) {
        return 95;
    }else {
        return 81;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MengZhuInfomationBigTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zixunBigIdentify forIndexPath:indexPath];
        
        return cell;
    }else {
        MengZhuInfomationSmallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:zixunSmallIdentify forIndexPath:indexPath];
        return cell;
    }
}



@end
