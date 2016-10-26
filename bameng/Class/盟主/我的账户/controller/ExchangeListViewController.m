//
//  ExchangeListViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ExchangeListViewController.h"
#import "ExchangeListTableViewCell.h"

@interface ExchangeListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation ExchangeListViewController

static NSString *exchangeListIdentify = @"exchangeListIdentify";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.table registerNib:[UINib nibWithNibName:@"ExchangeListTableViewCell" bundle:nil] forCellReuseIdentifier:exchangeListIdentify];
    [self.table removeSpaces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExchangeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exchangeListIdentify forIndexPath:indexPath];
    
    return cell;
}


@end
