//
//  UITableView+CJ.m
//  minipartner
//
//  Created by Cai Jiang on 2/9/15.
//  Copyright (c) 2015 Cai Jiang. All rights reserved.
//

#import "UITableView+CJ.h"

@implementation UITableView (CJ)

-(void)removeSpaces{
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)cleanSelection{
    [self selectRowAtIndexPath:Nil animated:YES scrollPosition:UITableViewScrollPositionNone];
}

- (void)showProgramFrameAnimationBubble{
    LKBubbleInfo *frameInfo = [[LKBubbleInfo alloc] init];
    NSMutableArray<UIImage *> *icons = [[NSMutableArray alloc] init];
    for (int i = 1 ; i <= 8; i ++) {
        [icons addObject: [UIImage imageNamed: [NSString stringWithFormat: @"lkbubble%d.jpg" , i]]];
    }
    frameInfo.iconArray = icons;
    // 在数组中依次放入多张图片即可实现多图循环播放
    frameInfo.backgroundColor = [UIColor colorWithRed: 238 / 255.0 green:238 / 255.0 blue:238 / 255.0 alpha:1];
    // 动画的帧动画播放间隔
    frameInfo.frameAnimationTime = 0.15;
    frameInfo.title = @"正在加载中...";
    frameInfo.titleColor = [UIColor darkGrayColor];
    [[LKBubbleView defaultBubbleView] showWithInfo: frameInfo];
}


- (void)HideProgram{
    [[LKBubbleView defaultBubbleView] hide];
}



- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        
        messageLabel.text = @"占无数据";
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}


@end
