//
//  MengYouTabbarViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengYouTabbarViewController.h"
#import "AppDelegate.h"


@interface MengYouTabbarViewController ()

@property(nonatomic,strong) NSTimer * timer;



@end

@implementation MengYouTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.selectedIndex = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"accountLoginout" object:nil];
    
}


- (void)test{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
    
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}



- (void)checkUnreadCount{
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/remind" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
            [app.messageRed MessageRedWithDict:responseObject[@"data"]];
            if ([responseObject[@"data"][@"messageCount"] integerValue]) {
                [self.tabBar showBadgeOnItemIndex:1];
            }else{
                [self.tabBar hideBadgeOnItemIndex:1];
            }
           
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        
    }];
    
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
