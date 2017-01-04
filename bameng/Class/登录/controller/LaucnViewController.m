//
//  LaucnViewController.m
//  bameng
//
//  Created by lhb on 16/11/14.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "LaucnViewController.h"
#import "LoginController.h"
#import "MengzhuTabbarController.h"
#import "MengYouTabbarViewController.h"
#import "MainNavViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface LaucnViewController ()

@property(nonatomic,strong) BMKMapManager * manager;

@end

@implementation LaucnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setImage];
    
    
    // 要使用百度地图，请先启动BaiduMapManager
    self.manager = [[BMKMapManager alloc]init];
    BOOL ret = [self.manager start:HuoBanMallBaiDu generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    
//    LWLog(@"%d",self.isReachable);
    
    
    AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    
    
    if (manager.networkReachabilityStatus > 0) {
       [self getAppConfig];
        
        
        
    }
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (!(status == 0) || (status == -1)) {
            [self getAppConfig];
            
        }else{
//            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"网络异常" message:@"网络异常请检查网络" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//                [self getAppConfig];
//            }];
//            [alertVC addAction:ac];
//            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//处理白屏问题
- (void)setImage {
    CGSize viewSize = CGSizeMake(KScreenWidth, KScreenHeight);
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    LWLog(@"%@",launchImage);
    UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    launchView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    launchView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:launchView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
    
}


- (void)getAppConfig {
    [HTMyContainAFN AFN:@"Sys/Init" with:nil Success:^(id responseObject) {
        LWLog(@"%@", responseObject);
        LWLog(@"%@",[NSThread currentThread]);
        if ([responseObject[@"status"] intValue] == 200) {
            BassModel *base = [BassModel mj_objectWithKeyValues:responseObject[@"data"][@"baseData"]];
            [BassModel BassModelSave:base];
            LWLog(@"%@",[base mj_keyValues]);
            if (base.userStatus == 1) {
                UserModel *user = [UserModel mj_objectWithKeyValues:responseObject[@"data"][@"userData"]];
                LWLog(@"%@",user);
                NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
                [NSKeyedArchiver archiveRootObject:user toFile:fileName];
                
                [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:UserInfomation];
                //帐号类型判断来进行身份选择
                if (user.UserIdentity == 1) {//盟主
                    [[NSUserDefaults standardUserDefaults] setObject:isMengZhu forKey:mengyouIdentify];
                    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
                    MengzhuTabbarController *tabbar = [story instantiateViewControllerWithIdentifier:@"MengzhuTabbarController"];
                    [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
                    
                }else if (user.UserIdentity == 0) {//盟友
                    [[NSUserDefaults standardUserDefaults] setObject:isMengYou forKey:mengyouIdentify];
                    UIStoryboard *mengyou = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
                    MengYouTabbarViewController *you = [mengyou instantiateViewControllerWithIdentifier:@"MengYouTabbarViewController"];
                    [UIApplication sharedApplication].keyWindow.rootViewController = you;
                }

                
            }else if (base.userStatus == -1) {//帐号登陆
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginController *login = [story instantiateViewControllerWithIdentifier:@"LoginController"];
                MainNavViewController * nav = [[MainNavViewController alloc] initWithRootViewController:login];
                 [UIApplication sharedApplication].keyWindow.rootViewController = nav;
            }else{ //未登陆
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                LoginController *login = [story instantiateViewControllerWithIdentifier:@"LoginController"];
                MainNavViewController * nav = [[MainNavViewController alloc] initWithRootViewController:login];
                [UIApplication sharedApplication].keyWindow.rootViewController = nav;
                
            }
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}


@end
