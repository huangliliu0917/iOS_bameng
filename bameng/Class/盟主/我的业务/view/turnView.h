//
//  turnView.h
//  bameng
//
//  Created by lhb on 16/12/2.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol turnViewDelegate <NSObject>

- (void)turnClick:(int)item;


@end


@interface turnView : UIView
+ (turnView *)shareturnView;


@property(nonatomic,weak) id <turnViewDelegate> delegate;

@end
