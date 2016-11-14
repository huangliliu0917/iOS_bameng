//
//  MyViewController.m
//  bameng
//
//  Created by lhb on 16/11/14.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyViewController.h"
#import "AppDelegate.h"



@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate * appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDlg.currentVc = self;
    self.isReachable = appDlg.isReachable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
