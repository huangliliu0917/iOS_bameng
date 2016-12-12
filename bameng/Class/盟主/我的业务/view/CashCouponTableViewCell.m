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

@property (weak, nonatomic) IBOutlet UIView *first;

@property (weak, nonatomic) IBOutlet UIView *second;

@property (weak, nonatomic) IBOutlet UIView *third;
@property (weak, nonatomic) IBOutlet UIView *fourth;


@property (weak, nonatomic) IBOutlet UIView *five;

@property (weak, nonatomic) IBOutlet UIView *six;
@property (weak, nonatomic) IBOutlet UIView *seven;
@property (weak, nonatomic) IBOutlet UIView *eight;

@end


@implementation CashCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.turnImage.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tureImageClick)];
    
    [self.turnImage addGestureRecognizer:ges];
    
    self.first.layer.cornerRadius = 6;
    self.first.layer.masksToBounds = YES;
    
    
    self.second.layer.cornerRadius = 6;
    self.second.layer.masksToBounds = YES;
    
    
    self.third.layer.cornerRadius = 6;
    self.third.layer.masksToBounds = YES;
    
    
    self.fourth.layer.cornerRadius = 6;
    self.fourth.layer.masksToBounds = YES;
    
    
    self.five.layer.cornerRadius = 6;
    self.five.layer.masksToBounds = YES;
    
    
    self.six.layer.cornerRadius = 6;
    self.six.layer.masksToBounds = YES;
    
    
    self.seven.layer.cornerRadius = 6;
    self.seven.layer.masksToBounds = YES;
    
    
    self.eight.layer.cornerRadius = 6;
    self.eight.layer.masksToBounds = YES;
}



- (void)tureImageClick{
    
    LWLog(@"xxx");
    
    UserModel * user = [UserModel GetUserModel];
    if ([self.delegate respondsToSelector:@selector(CashCouponTableViewCellTurn: andmodel:)]) {
        
        [self.delegate CashCouponTableViewCellTurn:user.UserIdentity andmodel:self.model];
        
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
