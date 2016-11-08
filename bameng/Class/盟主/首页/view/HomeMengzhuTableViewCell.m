//
//  HomeMengzhuTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/22.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "HomeMengzhuTableViewCell.h"

@implementation HomeMengzhuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BMInfomationModel *)model {
    _model = model;
    [self.cover sd_setImageWithURL:[NSURL URLWithString:_model.ArticleCover] placeholderImage:[UIImage imageNamed:@"264x264"] options:SDWebImageRefreshCached];
    self.title.text = _model.ArticleTitle;
    self.intro.text = _model.ArticleIntro;
    self.borwseAmount.text =  [_model.BrowseAmount stringValue];
    self.time.text = [_model.PublishTime substringToIndex:_model.PublishTime.length - 3];
}

- (void)setAllLable {
    

}


@end
