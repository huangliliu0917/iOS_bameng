//  1客户信息/2兑换审核/3我的联盟
//  UntreatedTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "UntreatedTableViewCell.h"


@interface UntreatedTableViewCell()



@end

@implementation UntreatedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.agreeButtom.layer.borderColor = [UIColor colorWithRed:192/255.0 green:193/255.0 blue:194/255.0 alpha:1].CGColor;
    self.agreeButtom.layer.borderWidth = 1;
    self.agreeButtom.layer.cornerRadius = 5;
    self.agreeButtom.layer.masksToBounds = YES;
    
    self.refuseButtom.layer.borderColor = [UIColor colorWithRed:241/255.0 green:76/255.0 blue:81/255.0 alpha:1].CGColor;
    self.refuseButtom.layer.borderWidth = 1;
    self.refuseButtom.layer.cornerRadius = 5;
    self.refuseButtom.layer.masksToBounds = YES;
    
    
    [self.agreeButtom addTarget:self action:@selector(agreeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.refuseButtom addTarget:self action:@selector(disAgreeClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)agreeClick:(UIButton *)btn{
    
    LWLog(@"xxx");
    if (self.didSelectCustomInfo) {
        self.didSelectCustomInfo(YES);
    }
    
}

- (void)disAgreeClick:(UIButton *)btn{
    LWLog(@"xxx");
    if (self.didSelectCustomInfo) {
        self.didSelectCustomInfo(NO);
    }
    
}


- (void)setMeYouShenQing:(MeYouShenQingModel *)MeYouShenQing{
   _MeYouShenQing = MeYouShenQing;
    LWLog(@"%@",[MeYouShenQing mj_keyValues]);
    self.name.text = MeYouShenQing.UserName;
    self.phone.text = [NSString stringWithFormat:@"%@",MeYouShenQing.Mobile];
}



- (void)setExchagemodel:(DuiHuanModel *)exchagemodel{
    
    _exchagemodel = exchagemodel;
    
    NSLog(@"%@",[exchagemodel mj_keyValues]);
    
    self.name.text = exchagemodel.name;
    self.phone.text = [NSString stringWithFormat:@"%@",exchagemodel.money];
    self.reviewLabel.text = @"未处理";
//    self
}


- (void)setCustomModel:(CustomInfomationModel *)customModel{
    _customModel = customModel;
    
    LWLog(@"%@",[customModel mj_keyValues]);
    self.name.text = customModel.Name;
    self.phone.text = [NSString stringWithFormat:@"%@",customModel.Mobile];
    self.reviewLabel.text = @"未处理";
}

- (void)setSelectPage:(NSInteger)selectPage{
    _selectPage = selectPage;
    if (_selectPage == 1) {
        self.nameLabel.text = @"客户姓名:";
        self.phoneLabe.text = @"联系方式:";
        self.phone.textColor = [UIColor blackColor];
        self.reviewLabel.text = @"未审核";
        
    }else if (_selectPage == 2) {
        self.nameLabel.text = @"盟友:";
        self.phoneLabe.text = @"兑换盟豆";
        self.phone.textColor = [UIColor colorWithRed:250/255.0 green:76/255.0 blue:81/255.0 alpha:1];
        self.reviewLabel.text = @"未审核";
    }else if (_selectPage == 3) {
        self.nameLabel.text = @"姓名:";
        self.phoneLabe.text = @"联系方式:";
        self.phone.textColor = [UIColor blackColor];
        self.reviewLabel.text = @"未审核";
        
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
