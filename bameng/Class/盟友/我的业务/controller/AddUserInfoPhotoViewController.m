//
//  AddUserInfoPhotoViewController.m
//  bameng
//
//  Created by 罗海波 on 2016/12/28.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "AddUserInfoPhotoViewController.h"
#import "SelectObjectViewController.h"
#import "UIImagePickerController+BlocksKit.h"
@interface AddUserInfoPhotoViewController ()<SelectObjectDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LXActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@property (weak, nonatomic) IBOutlet UIImageView * userInfoImage;

@property (weak, nonatomic) IBOutlet UIView *firstCell;

@property (weak, nonatomic) IBOutlet UILabel *firstLableText;

@property (weak, nonatomic) IBOutlet UIView *secondCell;
@property (weak, nonatomic) IBOutlet UIImageView *secondImage;


@property (weak, nonatomic) IBOutlet UIButton *tijiao;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menyouOrMengzhuheight;

@property (weak, nonatomic) IBOutlet UIView *menyouOrMengzhu;



@property(nonatomic,strong) UIImage * hasepickImage;
@property(nonatomic,copy) NSString * hasmengYouId;


@end

@implementation AddUserInfoPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    self.hasepickImage = nil;
    
    self.navigationItem.title = @"提交客户信息";
    self.userInfoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImage)];
    [self.userInfoImage addGestureRecognizer:tap];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    self.tijiao.layer.cornerRadius = 5;
    self.tijiao.layer.masksToBounds = YES;
    
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickMengYou)];
    self.firstCell.userInteractionEnabled = YES;
    [self.firstCell addGestureRecognizer:tap1];
    
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fenxiangMengdian:)];
    self.secondCell.userInteractionEnabled = YES;
    self.secondCell.tag = 100;
    [self.secondCell addGestureRecognizer:tap2];
   
    
    
    UserModel * model = [UserModel GetUserModel];
    if (model.UserIdentity == 0) {
        self.menyouOrMengzhu.hidden = YES;
        self.menyouOrMengzhuheight.constant = 0;
    }
}

- (void)fenxiangMengdian:(UITapGestureRecognizer *) tap{
    
    LWLog(@"%@",tap);
    
    UIView * vc = [tap view];
    if (vc.tag == 100) {
        self.secondImage.hidden = YES;
        vc.tag = 101;
    }else{
        self.secondImage.hidden = NO;
        vc.tag = 100;
    }
}


- (void)pickMengYou{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
    SelectObjectViewController *select = [story instantiateViewControllerWithIdentifier:@"SelectObjectViewController"];
    select.type = 1;
    select.delegate = self;
    [self.navigationController pushViewController: select animated:YES];
    
}



- (IBAction)upDateinfo:(id)sender {
  
    if (self.hasepickImage == nil) {
        [MBProgressHUD showError:@"请添加图片"];
        return;
    }
    
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"remark"] = self.remarkTextView.text;
    parme[@"issave"] = self.secondCell.tag == 100 ? @(1):@(0);
    parme[@"isd"] = self.hasmengYouId;
    
    
    NSData *imgData = UIImageJPEGRepresentation(self.hasepickImage, 0.5);
    // 原始图片
    UIImage *result = [UIImage imageWithData:imgData];
    
    [MBProgressHUD showMessage:nil];
    [HTMyContainAFN AFNUpLoadImage:@"customer/addImgInfo" with:parme andImage:result Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD hideHUD];
        if ([responseObject[@"status"] intValue] == 200) {
            [MBProgressHUD showSuccess:@"客户信息提交成功"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
        [MBProgressHUD hideHUD];
    }];

    
    
}

- (void)pickImage{
    
    LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:0 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    __weak typeof(self) wself = self;
    [action setIconViewSelectItem:^(NSInteger item) {
        LWLog(@"%ld",(long)item);
        [wself imageSelectItem:item];
    }];
    [action showInView:self.view];
}

/**
 *  头像
 */
- (void)imageSelectItem:(NSInteger)item{
    LWLog(@"%ld",(long)item);
    __weak typeof(self) wself = self;
    if(item == 1000){//拍照
        UIImagePickerController * pick = [[UIImagePickerController alloc] init];
        
        
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [MBProgressHUD showError:@"当前相机没权限"];
            return;
        }
        
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        pick.delegate = self;
        pick.allowsEditing = YES;
        [pick setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *ac) {
           
            [wself.userInfoImage setImage:ac[@"UIImagePickerControllerOriginalImage"]];
            wself.hasepickImage = ac[@"UIImagePickerControllerOriginalImage"];
            LWLog(@"%@",ac );
            [vc dismissViewControllerAnimated:YES completion:nil];
            
           
            
        }];
        [pick setBk_didCancelBlock:^(UIImagePickerController * vc) {
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [self presentViewController:pick animated:YES completion:nil];
    }else{//相册
        UIImagePickerController * pick = [[UIImagePickerController alloc] init];
        
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            [MBProgressHUD showError:@"当前相册没权限"];
            return;
        }
        [pick setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *ac) {
             [wself.userInfoImage setImage:ac[@"UIImagePickerControllerOriginalImage"]];
            wself.hasepickImage = ac[@"UIImagePickerControllerOriginalImage"];
            [vc dismissViewControllerAnimated:YES completion:nil];
            LWLog(@"%@",ac );
            
           
        }];
        [pick setBk_didCancelBlock:^(UIImagePickerController * vc) {
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [self presentViewController:pick animated:YES completion:nil];
    }
}



- (void)selectMengYou:(NSString *) mengYouId andName:(NSString *)names{
    
    LWLog(@"xxx%@",names);
    
    self.hasmengYouId = mengYouId;
    if (names.length) {
        self.firstLableText.text = names;
    }
    
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
