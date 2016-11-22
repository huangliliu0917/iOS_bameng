//
//  MengDouTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengDouTableViewCell.h"

@interface MengDouTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *mendou;
@property (weak, nonatomic) IBOutlet UIImageView *iconVIew;

@end

@implementation MengDouTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MenDouBeanExchageLists *)model{
    _model = model;
    
    
    
    LWLog(@"%ld",model.money);
    /**0支出，1收入*/
    if (model.status == 1) {
        self.status.text = @"收入";
    }else{
        self.status.text = @"支出";
    }
    
    self.mendou.text = [NSString stringWithFormat:@"%ld",model.money];
    
    self.timeLable.text = model.time;
}

@end
