//
//  LaucnViewController.m
//  bameng
//
//  Created by lhb on 16/11/14.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "LaucnViewController.h"

@interface LaucnViewController ()

@end

@implementation LaucnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//处理白屏问题
- (void)setImage {
    CGSize viewSize = CGSizeMake(KScreenWidth, KScreenHeight);
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    LWLog(@"%@",launchImage);
    UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    launchView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    launchView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:launchView];
}


@end
