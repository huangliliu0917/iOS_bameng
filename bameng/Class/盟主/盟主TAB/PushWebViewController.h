//
//  PushWebViewController.h
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PushWebViewControllerDelegate <NSObject>

/**
 资讯刷新
 */
- (void) ZhiXunRefresh;


@end


@interface PushWebViewController : MyViewController

@property (nonatomic ,strong) NSString *openUrl;


@property (weak,nonatomic) id <PushWebViewControllerDelegate> delegate;


/**文章详情标题*/
@property (nonatomic,copy) NSString * articalTitle;

@end
