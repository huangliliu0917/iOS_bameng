//
//  PhoteViewController.m
//  bameng
//
//  Created by 罗海波 on 2016/12/30.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "PhoteViewController.h"

@interface PhoteViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *remark;

@end

@implementation PhoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.model.DataImg] placeholderImage:nil];
    self.remark.userInteractionEnabled =  NO;
    self.remark.layer.borderWidth = 0.5;
    
    self.remark.text = self.model.Remark;
    self.remark.layer.borderColor = LWColor(239, 239, 244).CGColor;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
