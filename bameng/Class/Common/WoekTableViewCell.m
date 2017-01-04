//
//  WoekTableViewCell.m
//  bameng
//
//  Created by 罗海波 on 2017/1/3.
//  Copyright © 2017年 HT. All rights reserved.
//

#import "WoekTableViewCell.h"

@implementation WoekTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
       
    }
    return self;
}

- (void)setModel:(WorkModel *)model{
    _model = model;
    self.textLabel.text = model.reportTitle;
    self.detailTextLabel.text = model.time;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.textLabel setFont:[UIFont systemFontOfSize:12]];
    [self.detailTextLabel setFont:[UIFont systemFontOfSize:12]];
}

- (void)setFrame:(CGRect)frame{
    
    static CGFloat margin = 2;
    frame.origin.x = margin;
    frame.size.width -= 2 * frame.origin.x;
    frame.origin.y += margin;
    frame.size.height -= margin;
    
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
