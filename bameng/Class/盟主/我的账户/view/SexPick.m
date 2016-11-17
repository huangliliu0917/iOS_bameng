//
//  SexPick.m
//  bameng
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SexPick.h"


@interface SexPick ()

@property (weak, nonatomic) IBOutlet UIView *man;
@property (weak, nonatomic) IBOutlet UIView *female;

@end


@implementation SexPick

- (IBAction)cancle:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SexPickDelegate:)]) {
        [self.delegate SexPickDelegate:1003];
    }
}

+ (instancetype)SexPickShare{
    
    SexPick * sex = [[[NSBundle mainBundle] loadNibNamed:@"SexPick" owner:nil options:nil] lastObject];
    CGRect fm = sex.frame;
    fm.size.width = KScreenWidth;
    sex.frame = fm;
    return sex;
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.man.tag = 1000;
    
    self.man.userInteractionEnabled = YES;
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItem:)];
    [self.man addGestureRecognizer:ges];
    
    UITapGestureRecognizer * ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectItem:)];
    self.female.tag = 1001;
    self.female.userInteractionEnabled = YES;
    [self.female
     
     addGestureRecognizer:ges1];
    
}


- (void)selectItem:(UITapGestureRecognizer*)tap{
    
    LWLog(@"%ld",tap.view.tag);
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"type"] = @"5";
    if(tap.view.tag == 1000){
      parme[@"content"] = @"m";
    }else{
      parme[@"content"] = @"f";
    }
    [HTMyContainAFN AFN:@"user/UpdateInfo" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];

    if ([self.delegate respondsToSelector:@selector(SexPickDelegate:)]) {
        [self.delegate SexPickDelegate:tap.view.tag];
    }
}
@end
