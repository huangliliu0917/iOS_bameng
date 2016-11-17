//
//  LXActionSheet.h
//  LXActionSheetDemo
//
//  Created by lixiang on 14-3-10.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LXActionSheetDelegate <NSObject>

@end

@interface LXActionSheet : UIView

- (id)initWithTitle:(int)styleType delegate:(id<LXActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray;

- (void)showInView:(UIView *)view;

/**头像的*/
@property(nonatomic,copy) void(^iconViewSelectItem)(NSInteger item);

@property(nonatomic,copy) void(^nickNameandNameSelectItem)(NSInteger item,NSString * content);

@end
