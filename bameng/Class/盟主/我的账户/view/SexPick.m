//
//  SexPick.m
//  bameng
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SexPick.h"

@implementation SexPick

+ (instancetype)SexPickShare{
    
    SexPick * sex = [[[NSBundle mainBundle] loadNibNamed:@"SexPick" owner:nil options:nil] lastObject];
    CGRect fm = sex.frame;
    fm.size.width = KScreenWidth;
    sex.frame = fm;
    return sex;
    
}

@end
