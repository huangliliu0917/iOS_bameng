//
//  SaveCanclePickView.m
//  bameng
//
//  Created by lhb on 16/11/16.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SaveCanclePickView.h"


@interface SaveCanclePickView()

@property (weak, nonatomic) IBOutlet UILabel *nickType;

/**名字*/
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end


@implementation SaveCanclePickView

+ (instancetype)SaveCanclePickViewShare{
   SaveCanclePickView * view =  [[[NSBundle mainBundle] loadNibNamed:@"SaveCanclePickView" owner:nil options:nil] lastObject];
    CGRect fram = view.frame;
    fram.size.width = KScreenWidth;
    view.frame = fram;
    return view;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.saveBtn.layer.cornerRadius = 5;
    self.saveBtn.layer.masksToBounds = YES;
    
}

- (void)setType:(int)type{
    _type = type;
    if (self.type == 1) {
        self.nickType.text = @"昵称";
    }else if(self.type == 2){
        self.nickType.text = @"姓名";
    }
}

- (IBAction)saveClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(SaveCanclePickViewDelegate: withContent:)]) {
        NSMutableDictionary *parme = [NSMutableDictionary dictionary];
        
        NSLog(@"%d",self.type);
        if (self.type==1) {
            parme[@"type"] = @"2";
        }else if(self.type == 2){
            parme[@"type"] = @"4";
        }
        parme[@"content"] = self.textName.text;
        LWLog(@"%@",parme);
        [HTMyContainAFN AFN:@"user/UpdateInfo" with:parme Success:^(NSDictionary *responseObject) {
            LWLog(@"%@", responseObject);
            [MBProgressHUD showSuccess:responseObject[@"statusText"]];
        } failure:^(NSError *error) {
            LWLog(@"%@",error);
        }];
        
        [self.delegate SaveCanclePickViewDelegate:self.type withContent:self.textName.text];
    }
}



@end
