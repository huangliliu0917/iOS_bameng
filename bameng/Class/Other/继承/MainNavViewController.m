//
//  MainNavViewController.m
//  ysg
//
//  Created by lhb on 16/4/11.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MainNavViewController.h"

@interface MainNavViewController ()

@end

@implementation MainNavViewController


+ (void)initialize{
     UINavigationBar * NavBar = [UINavigationBar appearance];
//     [NavBar setBarTintColor:HuoBanMallBuyNavColor];
    
    
//    UIImage * imagess = [UIImage imageNamed:@"Financial_confirm_btn_normal"];
//    UIImage * imagedd =  [imagess stretchableImageWithLeftCapWidth:imagess.size.width*0.5 topCapHeight:imagess.size.height*0.5];
//
//    [NavBar setBackgroundImage:imagedd forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    NSMutableDictionary * textAttr = [NSMutableDictionary dictionary];
    textAttr[NSForegroundColorAttributeName] = [UIColor blackColor];
    [NavBar setTitleTextAttributes:textAttr];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"dhjt" hightIcon:nil target:self action:@selector(back)];

    }
    [super pushViewController:viewController animated:YES];
}



- (void)back
{
    
    [self popViewControllerAnimated:YES];
}
- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
