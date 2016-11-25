//
//  CashCouponTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CashCouponTableViewCell.h"



@interface CashCouponTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UILabel *cashName;
@property (weak, nonatomic) IBOutlet UILabel *cashTime;
@property (weak, nonatomic) IBOutlet UIImageView *turnImage;
@property (weak, nonatomic) IBOutlet UILabel *times;

@end


@implementation CashCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(CashModel *)model{
    _model = model;
    
    self.money.text = [NSString stringWithFormat:@"%@",model.money];
    self.cashName.text = model.name;
    self.times.text = model.due;
}
@end
