//
//  AppDelegate.h
//  bameng
//
//  Created by 刘琛 on 16/10/20.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "MyViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSString *Agent;



/**判断网络状态*/
@property(nonatomic,assign) BOOL isReachable;


/**当强网络状态*/
@property (nonatomic,strong) Reachability * hostReach;


/**当前展示的控制器*/
@property (nonatomic,strong) UIViewController * currentVc;


@end

