//
//  SelectObjectViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SelectObjectViewController.h"
#import "SelectObjectTableViewCell.h"

@interface SelectObjectViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *selectAll;

@property (nonatomic, strong) NSArray *goods;
@property (nonatomic, strong) NSArray *selectGoods;

@end

@implementation SelectObjectViewController

static NSString *selectObjectIdentify = @"selectObjectIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectObjectTableViewCell" bundle:nil] forCellReuseIdentifier:selectObjectIdentify];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.editing = YES;
    self.title = @"盟友列表";
    
#warning 全选修改
    [self.selectAll bk_whenTapped:^{
        //全选操作
        
        for (int row = 0; row < 10; row++){
            NSIndexPath *index = [NSIndexPath indexPathForRow:row inSection:0];
            [self.tableView selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 61;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectObjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectObjectIdentify forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
