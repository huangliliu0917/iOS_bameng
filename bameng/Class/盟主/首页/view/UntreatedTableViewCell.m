//  1客户信息/2兑换审核/3我的联盟
//  UntreatedTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "UntreatedTableViewCell.h"


@interface UntreatedTableViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UIButton *agreeButtom;
@property (strong, nonatomic) IBOutlet UIButton *refuseButtom;
//名字： 盟友
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

//手机：兑换盟逗
@property (strong, nonatomic) IBOutlet UILabel *phoneLabe;


@property (strong, nonatomic) IBOutlet UILabel *reviewLabel;




@end

@implementation UntreatedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
  
    
    LWLog(@"%@",NSStringFromCGSize(self.image.frame.size));
    self.image.layer.cornerRadius = self.image.frame.size.width * 0.5;
    self.image.layer.masksToBounds = YES;
    
//    self.agreeButtom.layer.borderColor = [UIColor colorWithRed:192/255.0 green:193/255.0 blue:194/255.0 alpha:1].CGColor;
//    self.agreeButtom.layer.borderWidth = 1;
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
    
    LWLog(@"%@",[exchagemodel mj_keyValues]);
    
    self.name.text = exchagemodel.name;
    self.phone.text = [NSString stringWithFormat:@"%@",exchagemodel.money];
    self.reviewLabel.text = @"未处理";
//    self
    [self.image sd_setImageWithURL:[NSURL URLWithString:exchagemodel.headimg] placeholderImage:[UIImage imageNamed:@"264x264"]];
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
        
        self.agreeButtom.hidden = YES;
        self.refuseButtom.hidden= YES;
        self.nameLabel.text = @"1";
        self.nameLabel.hidden = YES;
        self.phoneLabe.text = @"1";
        self.phoneLabe.hidden = YES;
        self.phone.textColor = [UIColor blackColor];
        self.reviewLabel.text = @"未审核";
        
    }else if (_selectPage == 2) {
        self.nameLabel.text = @"盟友:";
        self.phoneLabe.text = @"兑换盟豆";
        self.phone.textColor = [UIColor colorWithRed:250/255.0 green:76/255.0 blue:81/255.0 alpha:1];
        self.reviewLabel.text = @"未审核";
    }else if (_selectPage == 3) {
        self.nameLabel.text = @"1";
        self.nameLabel.hidden = YES;
        self.phoneLabe.text = @"1";
        self.phoneLabe.hidden = YES;

        self.phone.textColor = [UIColor blackColor];
        self.reviewLabel.text = @"未审核";
        
    }
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    LWLog(@"xxxxxxx%@",NSStringFromCGSize(frame.size));
}


- (void)layoutSubviews {
    [super layoutSubviews];
    LWLog(@"xxxxxxx");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
