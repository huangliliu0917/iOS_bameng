//
//  PushWebViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "PushWebViewController.h"
#import "AppDelegate.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

@interface PushWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;



@property (nonatomic,strong) UIButton * shareBtn;

@property(nonatomic,strong) NSString * shareDes;


@end

@implementation PushWebViewController



- (UIButton *)shareBtn{
    if (_shareBtn == nil) {
        _shareBtn = [[UIButton alloc] init];
        _shareBtn.frame = CGRectMake(0, 0, 25, 25);
        _shareBtn.hidden = YES;
//        _shareBtn.userInteractionEnabled = NO;
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"bzf"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}



- (void)shareBtnClick:(UIButton *)btn{
    
    LWLog(@"%@",self.shareDes);
    
    __weak typeof(self) wself = self;
    [self.webView evaluateJavaScript:@"getShareData()" completionHandler:^(id _Nullable shareStr, NSError * _Nullable error) {
        
        if (!error) {
           wself.shareDes = [shareStr copy];
            NSArray * shareArray = [wself.shareDes componentsSeparatedByString:@"^"];
            if (shareArray.count != 4) {
                return;
            }
            NSArray* imageArray = @[[shareArray lastObject]];
            //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
            if (imageArray) {
                NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                [shareParams SSDKSetupShareParamsByText:[shareArray objectAtIndex:1]
                                                 images:imageArray
                                                    url:[NSURL URLWithString:[shareArray objectAtIndex:2]]
                                                  title:[shareArray firstObject]
                                                   type:SSDKContentTypeAuto];
                //2、分享（可以弹出我们的分享菜单和编辑界面）
                [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
                [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                         items:nil
                                   shareParams:shareParams
                           onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                               
                               switch (state) {
                                   case SSDKResponseStateSuccess:
                                   {
                                       
                                       [wself showRightWithTitle:@"分享成功" autoCloseTime:1];
                                       LWLog(@"xxx");
                                       break;
                                   }
                                   case SSDKResponseStateFail:
                                   {
                                       
                                       [wself showErrorWithTitle:@"分享失败" autoCloseTime:1];
                                       LWLog(@"xxxSSDKResponseStateFail");
                                       break;
                                   }
                                   default:
                                       break;
                               }
                           }
                 ];}

        }
        
      
    }];
    
    
   
    
    
    
//    self.shareDes
//    //1、创建分享参数
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:AppToken];
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64)];
    self.webView.customUserAgent = [NSString stringWithFormat:@"%@(Authorization);%@",token, app.Agent];
    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.openUrl]]];
    
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.shareBtn]];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        NSString *str = title;
        self.navigationItem.title = str;
    }];
    
    [webView evaluateJavaScript:@"getShareData()" completionHandler:^(id _Nullable shareStr, NSError * _Nullable error) {
        
        LWLog(@"%@",[NSThread currentThread]);
        NSString *str = shareStr;
        if (str.length > 0) {
            self.shareDes = [str copy];
            self.shareBtn.hidden = NO;
        }else {
            self.shareBtn.hidden = YES;
        }
    }];

}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if([self.delegate respondsToSelector:@selector(ZhiXunRefresh)]){
        [self.delegate ZhiXunRefresh];
    }
}

@end
