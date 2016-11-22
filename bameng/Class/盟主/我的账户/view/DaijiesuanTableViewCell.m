//
//  DaijiesuanTableViewCell.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "DaijiesuanTableViewCell.h"

@interface DaijiesuanTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

@end

@implementation DaijiesuanTableViewCell

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
    
    
    LWLog(@"%@",[model mj_keyValues]);
    if (self.pageTag == 2) {//积分
        if(model.status){
            self.status.text = @"收入";
            self.scoreLable.text = [NSString stringWithFormat:@"+%ld",model.money];
            self.scoreLable.textColor = [UIColor redColor];
        }else{
            self.status.text = @"支出";
            self.scoreLable.text = [NSString stringWithFormat:@"-%ld",model.money];
            self.scoreLable.textColor = [UIColor greenColor];
        }
        self.timeLable.text = model.time;
        
    }else{//待结算
        if(model.status){
            self.status.text = @"收入";
            self.scoreLable.text = [NSString stringWithFormat:@"+%ld",model.money];
            self.scoreLable.textColor = [UIColor redColor];
        }else{
            self.status.text = @"转正";
            self.scoreLable.text = [NSString stringWithFormat:@"-%ld",model.money];
            self.scoreLable.textColor = [UIColor greenColor];
        }
        self.timeLable.text = model.time;
//        self.scoreLable.text = [NSString stringWithFormat:@"%ld",model.money];
        
    }
    
}

@end
