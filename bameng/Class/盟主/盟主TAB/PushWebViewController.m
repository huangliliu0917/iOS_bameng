//
//  PushWebViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "PushWebViewController.h"
#import "AppDelegate.h"

@interface PushWebViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation PushWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:AppToken];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64)];
    self.webView.customUserAgent = [NSString stringWithFormat:@"%@(Authorization);%@",token, app.Agent];
    [self.view addSubview:self.webView];
    
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
