//
//  MengYouTabbarViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengYouTabbarViewController.h"

@interface MengYouTabbarViewController ()

@end

@implementation MengYouTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.selectedIndex = 0;
    
}


- (void)checkUnreadCount{
    
    
    LWLog(@"xxxxxx---MengzhuTabbarController");
    
    static int a = 1;
    NSArray<UITabBarItem *> * items =  self.tabBar.items;
    items[0].badgeValue = [NSString stringWithFormat:@"%d",a];
    a++;
    LWLog(@"%@",items[0].badgeValue);
}


//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//
//    LWLog(@"%lu",(unsigned long)self.selectedIndex ) ;
//    LWLog(@"xxxxxx---MengzhuTabbarController");
//}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    NSLog(@"didSelectItem%lu",(unsigned long)item.tag ) ;
    NSLog(@"%@",item.title);
}


@end
