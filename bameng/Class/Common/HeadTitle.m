//
//  HeadTitle.m
//  bameng
//
//  Created by 罗海波 on 2017/1/5.
//  Copyright © 2017年 HT. All rights reserved.
//

#import "HeadTitle.h"



@interface HeadTitle ()

@property (weak, nonatomic) IBOutlet UIView *firstView;

@property (weak, nonatomic) IBOutlet UILabel *firstLable;

@property (weak, nonatomic) IBOutlet UIView *secondView;


@property (weak, nonatomic) IBOutlet UILabel *secondLable;





@property(nonatomic,assign) int currentTag;
@end
@implementation HeadTitle


+ (instancetype) HeadTitleCreate{
    
    
   HeadTitle * head =  [[[NSBundle mainBundle] loadNibNamed:@"HeadTitle" owner:nil options:nil] lastObject];
//    CGRect fm = head.frame;
//    fm.size.width = KScreenWidth;
//    head.frame = fm;
    return head;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    
    UIView * slideView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width * 0.5 - self.firstLable.frame.size.width) * 0.5, self.frame.size.height - 1, self.firstLable.frame.size.width, 1)];
    _slideView = slideView;
    slideView.backgroundColor = LWColor(204,158,95);
    [self addSubview:slideView];
    
    
    
    
    self.firstRedView.layer.cornerRadius = self.firstRedView.frame.size.height* 0.5;
    self.firstRedView.layer.masksToBounds = YES;
    
    self.secondredView.layer.cornerRadius = self.firstRedView.frame.size.height* 0.5;
    self.secondredView.layer.masksToBounds = YES;
    self.firstLable.textColor = LWColor(204,158,95);
    
    self.firstView.userInteractionEnabled = YES;
    self.firstView.tag = 100;
    self.currentTag = 100;
    self.secondView.userInteractionEnabled = YES;
    self.secondView.tag = 101;
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectitem:)];
    [self.firstView addGestureRecognizer:ges];
    
    
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectitem:)];
    [self.secondView addGestureRecognizer:ges1];
    
}
- (void)selectitem:(UITapGestureRecognizer *) ges{
    
    
    UIView * vs = ges.view;
    if (vs.tag == 100) {
        if(self.currentTag == 100){
            return;
        }else{
            self.currentTag = 100;
            self.firstLable.textColor = LWColor(204,158,95);
            self.secondLable.textColor = [UIColor blackColor];
            [self slideviewToWithItem:1];
            if ([self.delegate respondsToSelector:@selector(HeadTitleDelegateWith:)]) {
                [self.delegate HeadTitleDelegateWith:1];
            }
        }
    }else{
        if(self.currentTag == 101){
            return;
        }else{
            self.currentTag = 101;
            self.secondLable.textColor = LWColor(204,158,95);
            self.firstLable.textColor = [UIColor blackColor];
            [self slideviewToWithItem:2];
            
            if ([self.delegate respondsToSelector:@selector(HeadTitleDelegateWith:)]) {
                [self.delegate HeadTitleDelegateWith:2];
            }
        }
        
    }
    
}


- (void)slideviewToWithItem:(int) item{
    
    if (item == 1) {
       
        [UIView animateWithDuration:.2 animations:^{
            
//            [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            _slideView.frame=CGRectMake((self.frame.size.width * 0.5 - self.firstLable.frame.size.width) * 0.5, self.frame.size.height - 1, self.firstLable.frame.size.width, 1);
            
        } completion:^(BOOL finished) {
            
        }];
        
        
    }else{
        [UIView animateWithDuration:.2 animations:^{
            
            //            [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            _slideView.frame=CGRectMake((self.frame.size.width * 0.5 - self.firstLable.frame.size.width) * 0.5 + self.frame.size.width * 0.5, self.frame.size.height - 1, self.firstLable.frame.size.width, 1);
            
        } completion:^(BOOL finished) {
            
        }];
        
    }
}

@end
