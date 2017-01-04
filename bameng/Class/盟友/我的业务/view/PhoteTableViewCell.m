//
//  PhoteTableViewCell.m
//  bameng
//
//  Created by 罗海波 on 2017/1/3.
//  Copyright © 2017年 HT. All rights reserved.
//

#import "PhoteTableViewCell.h"


@interface PhoteTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UILabel *statusLable;

@end

@implementation PhoteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconView.layer.cornerRadius = self.iconView.frame.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    
    
    
}


- (void)setModel:(CustomInfomationModel *)model{
    _model = model;
    
    LWLog(@"%@",[model mj_keyValues]);
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.DataImg] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    self.nameLable.text = model.BelongOneName;
    
    
    
    if (model.InShop) {
        self.statusLable.text = @"已进店";
    }else{
        if (model.Status == 1) {
            self.statusLable.text = @"同意";
        }else if(model.Status == 2){
            self.statusLable.text = @"拒绝";
        }else{
            self.statusLable.text = @"未审核";
        }
    }
    
    

}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.type == 1) {
        self.statusLable.hidden = YES;
    }else{
        self.statusLable.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
