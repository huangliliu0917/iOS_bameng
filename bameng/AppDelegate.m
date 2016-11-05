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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self getAppConfig];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:158/255.0 blue:95/255.0 alpha:1]} forState:UIControlStateSelected];
    
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginController *login = [story instantiateViewControllerWithIdentifier:@"LoginController"];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:login];
    
//    [[NSUserDefaults standardUserDefaults] setObject:isMengZhu forKey:mengyouIdentify];
//    
//    NSString *identify = [[NSUserDefaults standardUserDefaults] objectForKey:mengyouIdentify];
//    if ([identify isEqualToString:isMengYou]) {
//        self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
//        UIStoryboard *mengyou = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
//        MengYouTabbarViewController *you = [mengyou instantiateViewControllerWithIdentifier:@"MengYouTabbarViewController"];
//        self.window.rootViewController = you;
//    }else {
//        self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
//        MengzhuTabbarController *tabbar = [story instantiateViewControllerWithIdentifier:@"MengzhuTabbarController"];
//        self.window.rootViewController = tabbar;
//    }
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)getAppConfig {
    [HTMyContainAFN AFN:@"Sys/Init" with:nil Success:^(id responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            BassModel *base = [BassModel mj_objectWithKeyValues:responseObject[@"data"][@"baseData"]];
            if (base.userStatus == 1) {
                UserModel *user = [UserModel mj_objectWithKeyValues:responseObject[@"data"][@"userData"]];
                LWLog(@"%@",user);
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
                [NSKeyedArchiver archiveRootObject:user toFile:fileName];
                
                [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:UserInfomation];
            }
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
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


@end
