//
//  PushWebViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "PushWebViewController.h"

@interface PushWebViewController ()


@end

@implementation PushWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.openUrl]]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
