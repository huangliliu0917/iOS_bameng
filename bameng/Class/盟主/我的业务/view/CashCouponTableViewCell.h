//
//  CashCouponTableViewCell.h
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CashModel.h"


@protocol CashCouponTableViewCellDelegate <NSObject>

- (void)CashCouponTableViewCellTurn:(NSInteger)item andmodel:(CashModel *)model;


@end


@interface CashCouponTableViewCell : UITableViewCell


@property(nonatomic,strong) CashModel * model;




@property(nonatomic,weak) id <CashCouponTableViewCellDelegate>delegate;
@end
