//
//  MyShareSdkTool.m
//  bameng
//
//  Created by 罗海波 on 2016/12/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyShareSdkTool.h"
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>
#import "UIImage+LHB.h"

@implementation MyShareSdkTool

- (instancetype)MyShareSdkToolShare{
    
    return [[MyShareSdkTool alloc] init];
}
- (void)MyShareSdkTool:(NSString *)shareUrl{
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    

        NSArray* imageArray = @[[UIImage getAppIconName]];
        [shareParams SSDKSetupShareParamsByText:@"霸盟中的位置"
                                 images:imageArray
                                    url:[NSURL URLWithString:shareUrl]
                                  title:@"我的位置"
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
                       LWLog(@"xxx");
                       break;
                   }
                   case SSDKResponseStateFail:
                   {
                       LWLog(@"xxxSSDKResponseStateFail");
                       break;
                   }
                   default:
                       break;
               }
           }
 ];

}

@end
