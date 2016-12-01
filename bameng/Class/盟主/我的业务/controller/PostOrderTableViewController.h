//  上传成交凭证
//  PostOrderTableViewController.h
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfoModel.h"


@protocol PostOrderTableViewControllerDelegate <NSObject>


- (void)uploadImage:(NSMutableDictionary *)dict andImage:(UIImage *)image;


@end

@interface PostOrderTableViewController : MyTableViewController

@property(nonatomic,strong) OrderInfoModel * model;


@property(nonatomic,weak) id <PostOrderTableViewControllerDelegate> delegate;


@property(nonatomic,strong) NSMutableDictionary * dict;
@property(nonatomic,strong) UIImage * havePickImage;


@end
