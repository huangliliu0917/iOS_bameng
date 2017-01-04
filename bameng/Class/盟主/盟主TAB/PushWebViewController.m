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
    

    
    
    
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:AppToken];
    self.webView = [[WKWebView alloc] init];
//    self.webView.scrollView.backgroundColor = [UIColor redColor];
    self.webView.customUserAgent = [NSString stringWithFormat:@"%@(Authorization);%@",token, app.Agent];
    self.view = self.webView;
//    [self.view addSubview:self.webView];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.openUrl]]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.shareBtn]];
    
    
    if (self.articalTitle.length) {
        self.navigationItem.title = self.articalTitle;
    }
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    
    LWLog(@"xxxxx%@",self.articalTitle);
    
    if (!self.articalTitle.length) {
        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
            NSString *str = title;
            self.navigationItem.title = str;
        }];
    }
    
    if (self.type == 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self screenShot];
        });
       
    }
    
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



/**
 *截图功能
 */
-(void)screenShot{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);
    
    //设置截屏大小
    
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, 641, KScreenHeight + 300);//这里可以设置想要截图的区域
    
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    
    //以下为图片保存代码
    
    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
    
//    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *pictureName= @"screenShow.png";
//    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
//    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
//    
//    CGImageRelease(imageRefRect);
//    
//    
//    
//    //从手机本地加载图片
//    
//    UIImage *bgImage2 = [[UIImage alloc]initWithContentsOfFile:savedImagePath];
//    
    
}

@end
