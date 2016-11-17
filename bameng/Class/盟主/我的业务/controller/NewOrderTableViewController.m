//
//  NewOrderTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "NewOrderTableViewController.h"
#import "TZImagePickerController.h"

@interface NewOrderTableViewController ()<TZImagePickerControllerDelegate>

/**客户姓名*/
@property (weak, nonatomic) IBOutlet UITextField *customName;

/**手机号*/
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

/**客户地址*/
@property (weak, nonatomic) IBOutlet UITextField *customAddress;


@property (weak, nonatomic) IBOutlet UITextView *externInfo;



- (IBAction)submitOrder:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *addPicture;


@property (weak, nonatomic) IBOutlet UILabel *titleInfo;

/**订单照片*/
@property (weak, nonatomic) IBOutlet UIImageView *orderPic;

@end

@implementation NewOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITapGestureRecognizer * ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImage)];
    self.addPicture.userInteractionEnabled = YES;
    [self.addPicture addGestureRecognizer:ges];
    
    
    self.orderPic.contentMode = UIViewContentModeScaleAspectFill;
    self.orderPic.clipsToBounds = YES;
}


- (void)addImage{
   
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    __weak NewOrderTableViewController * wself = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray * assets, BOOL a) {
        UIImage * pickImage = [photos objectAtIndex:0];
        LWLog(@"%@",NSStringFromCGSize(pickImage.size));
        LWLog(@"%@",[NSThread currentThread]);
        
        [wself.orderPic setImage:pickImage];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
    
}
#pragma mark - Table view data source

#warning needToDeal luohaibo

- (IBAction)submitOrder:(id)sender {
    
    if (!self.customName.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    if (!self.phoneNum.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请手机号"];
        return;
    }
    if (!self.customAddress.text.length) {
        [SVProgressHUD showErrorWithStatus:@"请输入地址"];
        return;
    }
    [HTMyContainAFN AFNUpLoadImage:@"sys/uploadpic" with:nil andImage:self.orderPic.image Success:^(NSDictionary *responseObject) {
        
        LWLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
   

    
    
}
@end
