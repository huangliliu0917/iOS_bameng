//
//  NewOrderTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "NewOrderTableViewController.h"
#import "TZImagePickerController.h"
#import "AppDelegate.h"
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

/**现金圈编号*/
@property (weak, nonatomic) IBOutlet UITextField *cashNunber;

@end

@implementation NewOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.externInfo.layer.borderWidth = 1;
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
    
    
    /**
     userName
     Type: String
     客户名
     
     mobile
     Type: String
     手机号
     
     address
     Type: String
     客户地址
     
     cashNo
     Type: String
     现金卷编号
     
     memo
     Type: String
     备注
     */
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
    //if (!self.cashNunber.text.length) {
      //  [SVProgressHUD showErrorWithStatus:@"现金券为空"];
       // return;
    //}
    NSMutableDictionary * parame = [NSMutableDictionary dictionary];
    parame[@"userName"] = self.customName.text;
    parame[@"mobile"] = self.phoneNum.text;
    parame[@"address"] = self.customAddress.text;
    parame[@"address"] = self.cashNunber.text;
    parame[@"address"] = self.externInfo.text;
    
    AppDelegate * de = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [HTMyContainAFN AFNUpLoadImage:@"order/create" with:parame andImage:self.orderPic.image Success:^(NSDictionary *responseObject) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"订单提交" message:@"订单提交成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alertVC addAction:ac];
        [de.currentVc presentViewController:alertVC animated:YES completion:nil];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
   

    
    
}
@end
