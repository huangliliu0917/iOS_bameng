//
//  ExchangeListTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "ExchangeListTableViewCell.h"

@interface ExchangeListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *InOrOut;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *exchangeMenDou;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;

@end

@implementation ExchangeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setModel:(MenDouBeanExchageLists *)model{
    _model = model;
    
    self.exchangeMenDou.text = [NSString stringWithFormat:@"%@",model.money];
    self.timeLable.text = model.time;
    
    if (!model.status) {
        self.statusLable.text = @"未审核";
    }else{
       self.statusLable.text = @"已通过";
    }
}
@end
