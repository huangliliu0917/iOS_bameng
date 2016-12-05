//  1客户信息/2兑换审核/3我的联盟
//  ProcessedTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ProcessedTableViewCell.h"

@implementation ProcessedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}


- (void)setSelectPage:(NSInteger)selectPage{
    
    _selectPage = selectPage;
    if (selectPage == 1) {
        self.nameLabel.text = @"客户姓名:";
        self.phoneLabel.text = @"联系方式:";
        
    }else if (selectPage == 2) {
        self.nameLabel.text = @"盟友:";
        self.phoneLabel.text = @"兑换盟豆";
        self.phone.textColor = [UIColor colorWithRed:250/255.0 green:76/255.0 blue:81/255.0 alpha:1];
        
    }else if (selectPage == 3) {
        self.nameLabel.text = @"姓名:";
        self.phoneLabel.text = @"联盟等级:";
        self.phone.layer.masksToBounds = YES;
        self.phone.layer.borderWidth = 1;
        self.phone.layer.cornerRadius = 3;
        self.phone.layer.borderColor = [UIColor redColor].CGColor;
        self.phone.backgroundColor = [UIColor redColor];
        self.phone.frame = CGRectMake(_phone.frame.origin.x, _phone.frame.origin.y, _phone.frame.size.width + 10, _phone.frame.size.height);
        self.review.hidden = YES;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}


- (void)setExchagemodel:(DuiHuanModel *)exchagemodel{
    _exchagemodel = exchagemodel;
    LWLog(@"%@",[exchagemodel mj_keyValues]);
    self.name.text = exchagemodel.name;
    self.phone.text = [NSString stringWithFormat:@"%@",exchagemodel.money];
    if (exchagemodel.status == 1) {
        self.review.text = @"已同意";
    }else if (exchagemodel.status == 2) {
        self.review.text = @"已拒绝";
    }else if (exchagemodel.status == 0) {
        self.review.text = @"未审核";
    }
}

- (void)setCustomModel:(CustomInfomationModel *)customModel {
    _customModel = customModel;
    self.name.text = _customModel.Name;
    self.phone.text = _customModel.Mobile;
    
    if (self.customModel.Status == 1) {
        self.review.text = @"已同意";
    }else if (self.customModel.Status == 2) {
        self.review.text = @"已拒绝";
    }else if (self.customModel.Status == 0) {
        self.review.text = @"未审核";
    }
}

- (void)setMengyouModel:(UserModel *)mengyouModel {
    _mengyouModel = mengyouModel;
    self.review.hidden = YES;
    
    LWLog(@"%@",mengyouModel.LevelName);
    self.name.text = mengyouModel.RealName;
    self.phone.text = mengyouModel.LevelName;
    [self.image sd_setImageWithURL:[NSURL URLWithString:_mengyouModel.UserHeadImg] placeholderImage:nil options:SDWebImageRefreshCached];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
