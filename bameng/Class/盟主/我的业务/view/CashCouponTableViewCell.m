//
//  CashCouponTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CashCouponTableViewCell.h"



@interface CashCouponTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;
@property (weak, nonatomic) IBOutlet UILabel *cashNameLable;

@property (weak, nonatomic) IBOutlet UILabel *cashTimeLimited;
@property (weak, nonatomic) IBOutlet UILabel *turnTimes;
@property (weak, nonatomic) IBOutlet UIImageView *turnImage;

@end


@implementation CashCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.turnImage.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tureImageClick)];
    
    [self.turnImage addGestureRecognizer:ges];
    
}



- (void)tureImageClick{
    
    LWLog(@"xxx");
    
    UserModel * user = [UserModel GetUserModel];
    if ([self.delegate respondsToSelector:@selector(CashCouponTableViewCellTurn:)]) {
        
        [self.delegate CashCouponTableViewCellTurn:user.UserIdentity];
        
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(CashModel *)model{
    _model = model;
    LWLog(@"%@",model.money);
    self.moneyLable.text = [NSString stringWithFormat:@"%@",model.money];
    self.cashNameLable.text = model.name;
    self.cashTimeLimited.text = model.due;
}
@end
