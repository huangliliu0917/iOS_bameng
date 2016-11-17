//
//  MyViewController.h
//  bameng
//
//  Created by lhb on 16/11/14.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyViewControllerDelegate <NSObject>



@end


@interface MyViewController : UIViewController


@property(nonatomic,assign) BOOL isReachable;

@end
