//
//  AddUserInfo.h
//  bameng
//
//  Created by 罗海波 on 2016/12/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddUserInfoDelegate <NSObject>

- (void)AddUserInfoDelegate:(int)item;


@end


@interface AddUserInfo : UIView


+ (instancetype)AddUserInfoShare;

@property(nonatomic,weak) id <AddUserInfoDelegate> delegate;

@end
