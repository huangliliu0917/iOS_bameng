//
//  pickView.m
//  bameng
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "pickView.h"
//#import ""
@interface pickView ()
@property (weak, nonatomic) IBOutlet UIView *pzView;
@property (weak, nonatomic) IBOutlet UIView *xiangceView;

@end


@implementation pickView

- (IBAction)dismiss:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(pickViewOption:)]) {
        [self.delegate pickViewOption:1003];
    }
    
}


+ (instancetype)pickViewShare{
    pickView * picView =  [[[NSBundle mainBundle] loadNibNamed:@"pickView" owner:self options:nil] lastObject];
    CGRect frame = picView.frame;
    frame.size.width = KScreenWidth;
    picView.frame = frame;
    return picView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.pzView.userInteractionEnabled = YES;
    self.pzView.tag = 1000;
    self.xiangceView.userInteractionEnabled = YES;
    self.xiangceView.tag = 1001;
    
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItem:)];
    [self.pzView addGestureRecognizer:ges];
    
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItem:)];
    
    
    [self.xiangceView
     
     addGestureRecognizer:ges1];
    
}

- (void)selectItem:(UIGestureRecognizer *)tap{
    
    LWLog(@"%d",tap.view.tag);
    if ([self.delegate respondsToSelector:@selector(pickViewOption:)]) {
        [self.delegate pickViewOption:tap.view.tag];
    }
}

@end
