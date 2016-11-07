//
//  MengZhuInfomationSmallTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MengZhuInfomationSmallTableViewCell.h"

@implementation MengZhuInfomationSmallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BMInfomationModel *)model {
    _model = model;
    [self.cover sd_setImageWithURL:[NSURL URLWithString:_model.ArticleCover] placeholderImage:nil options:SDWebImageRefreshCached];
    self.title.text = _model.ArticleTitle;
    self.intro.text = _model.ArticleIntro;
    self.browseAmout.text =  [_model.BrowseAmount stringValue];
    self.time.text = [_model.PublishTime substringToIndex:_model.PublishTime.length - 3];
}

@end
