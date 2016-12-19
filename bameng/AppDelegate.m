//
//  AppDelegate.m
//  bameng
//
//  Created by 刘琛 on 16/10/20.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "AppDelegate.h"
#import "HTMyContainAFN.h"
#import "MengzhuTabbarController.h"
#import "MengYouTabbarViewController.h"
#import "LoginController.h"
#import "IQKeyboardManager.h"
#import "MyCoreLocation.h"


@interface AppDelegate ()



@end

@implementation AppDelegate


- (void)test{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    //    self.hostReach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    //    //开始监听，会启动一个run loop
    //    [self.hostReach startNotifier];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
        
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:158/255.0 blue:95/255.0 alpha:1]} forState:UIControlStateSelected];
    
    //1、处理键盘问题
    [IQKeyboardManager sharedManager].enable = YES;
    [self SetupInitShareSdkInfo];
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    self.window.backgroundColor = [UIColor whiteColor];
    LaucnViewController * launch = [[LaucnViewController alloc] init];
    self.window.rootViewController = launch;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    _Agent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    [self.window makeKeyAndVisible];
    
    
    
    return YES;
}



- (void)SetupInitShareSdkInfo{
    
    [ShareSDK registerApp:ShareSdkKey
     
          activePlatforms:@[
                            
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:HuoBanMallBuyWeiXinAppId
                                       appSecret:HuoBanMallShareSdkWeiXinSecret];
                 break;
             default:
                 break;
         }
     }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




/**
 * 判断网络类型
 */
-(void)reachabilityChanged:(NSNotification *)note{
    Reachability * currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    self.isReachable = YES;
    if(status == NotReachable){
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"网络连接异常" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alertVC addAction:ac];
        [self.currentVc presentViewController:alertVC animated:YES completion:nil];
        self.isReachable = NO;
        return;
    }
        if (status == ReachableViaWiFi || status== ReachableViaWWAN) {
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"网络连接信息" message:@"网络连接正常" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alertVC addAction:ac];
            [self.currentVc presentViewController:alertVC animated:YES completion:nil];
            self.isReachable = YES;
        }
}



@end
