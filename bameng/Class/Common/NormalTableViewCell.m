//
//  NormalTableViewCell.m
//  bameng
//
//  Created by 罗海波 on 2016/12/30.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "NormalTableViewCell.h"


@interface NormalTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *firstLableone;
@property (weak, nonatomic) IBOutlet UILabel *firstLabletwo;
@property (weak, nonatomic) IBOutlet UILabel *secondLableOne;
@property (weak, nonatomic) IBOutlet UILabel *secondLableTwo;

@end


@implementation NormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.iconImage.layer.cornerRadius = self.iconImage.frame.size.width * 0.5;
    self.iconImage.layer.masksToBounds = YES;
}



- (void)setModel:(CustomResourceModel *)model{
    _model = model;
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    

    // Configure the view for the selected state
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.model.Type== 1) {
        
        self.firstLableone.text = @"提交人 :";
        self.firstLabletwo.text = self.model.Name;
        self.secondLableOne.text = @"提交资料:";
        self.secondLableTwo.text = @"照片";
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.model.DataImg] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            LWLog(@"%@",[imageURL absoluteString]);
            if (!error) {
                [self.iconImage setImage:image];
            }
        }];
        
        
        
    }else{
        
        self.firstLableone.text = @"客户姓名:";
        self.firstLabletwo.text = self.model.Name;
        self.secondLableOne.text = @"联系方式 :";
        self.secondLableTwo.text = self.model.Mobile;
        
        
        [self.iconImage setImage:[UIImage imageNamed:@"mrtx"]];
        
        
    }
}
@end
