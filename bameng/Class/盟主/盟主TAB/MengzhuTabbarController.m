//
//  MengzhuTabbarController.m
//  bameng
//
//  Created by 刘琛 on 16/10/22.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengzhuTabbarController.h"
#import "MessageRedPoint.h"
#import "AppDelegate.h"
#import "MessageRedPoint.h"



@interface MengzhuTabbarController ()

@property(nonatomic,strong) NSTimer * timer;

@end

@implementation MengzhuTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.selectedIndex = 0;
    [self checkUnreadCount];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"accountLoginout" object:nil];

}


- (void)test{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.timer invalidate];
     self.timer = nil;
    
}

- (void)checkUnreadCount{
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/remind" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            
            
           AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
            LWLog(@"%@",[app.messageRed mj_keyValues]);
           [app.messageRed MessageRedWithDict:responseObject[@"data"]];
            if ([responseObject[@"data"][@"messageCount"] integerValue] || [responseObject[@"data"][@"messagePullCount"] integerValue] || [responseObject[@"data"][@"messagePushCount"] integerValue]) {
                [self.tabBar showBadgeOnItemIndex:3];
            }else{
                [self.tabBar hideBadgeOnItemIndex:3];
            }
            
            if ([responseObject[@"data"][@"businessRemind"] integerValue]) {
                [self.tabBar showBadgeOnItemIndex:2];
            }else{
                [self.tabBar hideBadgeOnItemIndex:2];
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
