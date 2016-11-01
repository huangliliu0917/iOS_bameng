//
//  MengYouHomeTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengYouHomeTableViewCell.h"

@implementation MengYouHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = self.icon.frame.size.width / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
