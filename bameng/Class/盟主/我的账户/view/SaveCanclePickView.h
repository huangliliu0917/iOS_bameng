//
//  SaveCanclePickView.h
//  bameng
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SaveCanclePickViewDelegate <NSObject>


/*
 *
 1保存
 0取消
 */
- (void)SaveCanclePickViewDelegate:(NSInteger)item withContent:(NSString *)content;

@end


@interface SaveCanclePickView : UIView

/**1 标示昵称  2 姓名*/
@property(nonatomic,assign) int type;


+ (instancetype)SaveCanclePickViewShare;


@property(nonatomic,weak) id <SaveCanclePickViewDelegate> delegate;
@end
