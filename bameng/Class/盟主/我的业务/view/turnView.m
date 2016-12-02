//
//  turnView.m
//  bameng
//
//  Created by lhb on 16/12/2.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "turnView.h"


@interface turnView()

@property (weak, nonatomic) IBOutlet UIImageView *custom;
@property (weak, nonatomic) IBOutlet UIImageView *menyou;

@end

@implementation turnView


+ (turnView *)shareturnView{
    
    turnView * turn = [[[NSBundle mainBundle] loadNibNamed:@"turnView" owner:nil options:nil] lastObject];
    CGRect rm  = turn.frame;
    rm.size.width = KScreenWidth;
    turn.frame = rm;
    return turn;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.custom.userInteractionEnabled = YES;
    self.custom.tag = 100;
    self.menyou.userInteractionEnabled = YES;
    self.menyou.tag = 101;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnImageClick:)];
    [self.custom addGestureRecognizer:tap];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnImageClick:)];
    [self.menyou addGestureRecognizer:tap1];
    
}


- (void)btnImageClick:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag == 100) {
        
        [self.delegate turnClick:0];
    }else{
        [self.delegate turnClick:1];
    }
    
}
@end
