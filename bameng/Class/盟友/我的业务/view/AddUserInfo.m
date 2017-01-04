//
//  AddUserInfo.m
//  bameng
//
//  Created by 罗海波 on 2016/12/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "AddUserInfo.h"





@implementation AddUserInfo

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)AddUserInfoShare{
    
    
    AddUserInfo * aa =  [[[NSBundle mainBundle] loadNibNamed:@"AddUserInfo" owner:nil options:nil] lastObject];
    CGRect fm = aa.frame;
    fm.size.width = KScreenWidth;
    aa.frame = fm;
    return aa;
}

- (IBAction)one:(id)sender {
    [self pickItem:1];
    
}

- (IBAction)tow:(id)sender {
    [self pickItem:2];
}


- (IBAction)there:(id)sender {
    [self pickItem:0];
    
}


- (void)pickItem:(int)item{
    
    if ([self.delegate respondsToSelector:@selector(AddUserInfoDelegate:)]) {
        [self.delegate AddUserInfoDelegate:item];
    }
}

@end
