//
//  MYInfomationTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/11/1.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYInfomationTableViewCell.h"

@interface MYInfomationTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *redPoint;

@property (weak, nonatomic) IBOutlet UILabel *desLable;


@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@end


@implementation MYInfomationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(BMInfomationModel *)model{
    
    _model = model;
    
    LWLog(@"%@",[model mj_keyValues]);
    
    if (model.IsRead) {
        self.redPoint.hidden = YES;
    }else{
        self.redPoint.hidden = YES;
    }
    
    self.desLable.text = model.ArticleIntro;
    self.timeLable.text = model.PublishTimeText;
    
}
@end
