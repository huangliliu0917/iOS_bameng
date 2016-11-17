//  1客户信息/2兑换审核/3我的联盟  
//  CustomInfoController.h
//  bameng
//
//  Created by 刘琛 on 16/10/22.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomInfoController : MyViewController

@property (strong, nonatomic) IBOutlet UIView *chooserView;

/**未处理*/
@property (strong, nonatomic) IBOutlet UIView *untreated;
/**已处理*/
@property (strong, nonatomic) IBOutlet UIView *processed;

@property (nonatomic, strong) UIView *slider;

@property (nonatomic, assign) NSInteger selectPage;

@end
