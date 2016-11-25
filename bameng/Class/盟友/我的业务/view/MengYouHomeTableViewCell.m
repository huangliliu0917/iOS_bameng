//
//  MengYouHomeTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengYouHomeTableViewCell.h"



@interface MengYouHomeTableViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *statusLable;
@end

@implementation MengYouHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = self.icon.frame.size.width / 2;
    self.icon.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setModel:(CustomInfomationModel *)model{
    _model = model;
    
    self.name.text = model.Name;
    self.phone.text = model.Mobile;
    
    [self.icon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"mrtx"]];
    
    if (model.Status == 1) {
        self.statusLable.text = @"同意";
    }else if(model.Status == 2){
        self.statusLable.text = @"拒绝";
    }else{
        self.statusLable.text = @"未审核";
    }
    
}
@end
