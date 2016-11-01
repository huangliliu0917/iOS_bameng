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

@end

@implementation SelectObjectViewController

static NSString *selectObjectIdentify = @"selectObjectIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectObjectTableViewCell" bundle:nil] forCellReuseIdentifier:selectObjectIdentify];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
