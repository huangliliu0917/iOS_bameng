//
//  MyBusinessTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyBusinessTableViewCell.h"


@interface MyBusinessTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@property (weak, nonatomic) IBOutlet UILabel *mobleNumber;
@property (weak, nonatomic) IBOutlet UILabel *mdBean;

@end


@implementation MyBusinessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.iconView.backgroundColor = [UIColor redColor];
    
    self.iconView.layer.cornerRadius = self.iconView.frame.size.height * 0.5;
    self.iconView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(OrderInfoModel *)model{
    _model = model;
    
    
    LWLog(@"%@",[model mj_keyValues]);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.pictureUrl] placeholderImage:[UIImage imageNamed:@"dd264x264"]];
    self.nameLable.text = model.userName;
    self.mobleNumber.text = model.mobile;
    //订单状态 0 未成交 1 已成交 2退单
    if (model.status == 1) {
       self.statusLable.text = @"已成交";
    }else if(model.status == 2){
       self.statusLable.text = @"退单";
    }else{
       self.statusLable.text = @"未成交";
    }
   
    self.mdBean.text = [NSString stringWithFormat:@"%@",model.mengbeans];
}


@end
