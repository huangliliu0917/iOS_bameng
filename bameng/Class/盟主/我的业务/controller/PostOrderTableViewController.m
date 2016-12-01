//
//  PostOrderTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "PostOrderTableViewController.h"
#import "UIImagePickerController+BlocksKit.h"


@interface PostOrderTableViewController ()<LXActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *pickImage;
@property (weak, nonatomic) IBOutlet UIImageView *imagepic;
@property (weak, nonatomic) IBOutlet UITextField *customName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *priceName;

@property (weak, nonatomic) IBOutlet UITextView *addtionInfo;


@property (nonatomic,strong) UIImage * currentpickImage;



@property(nonatomic,strong) NSMutableDictionary * dataImage;

@end

@implementation PostOrderTableViewController



- (NSMutableDictionary *)dataImage{
    if (_dataImage == nil) {
        _dataImage = [NSMutableDictionary dictionary];
        
    }
    return _dataImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.pickImage.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickImagex)];
    [self.pickImage addGestureRecognizer:tap];
    
    
//    __weak typeof(self) wself = self;
//    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.model.pictureUrl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        if (!error) {
//            wself.imagepic.image = image;
//        }
//        
//    }];
    
    LWLog(@"%@",self.model.userName);
    self.customName.text =self.model.userName;
    self.phone.text = self.model.mobile;
    
    if(self.havePickImage){
        self.imagepic.image = self.havePickImage;
        self.priceName.text  = [NSString stringWithFormat:@"%@",self.dict[@"price"]];
        self.addtionInfo.text  = [NSString stringWithFormat:@"%@",self.dict[@"memo"]];
    }else{
        self.priceName.text  = [NSString stringWithFormat:@"%@",self.model.money];
    }
}



- (void)setModel:(OrderInfoModel *)model{
    _model = model;
    
}

- (void)pickImagex{
    
    LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:0 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    __weak typeof(self) wself = self;
    [action setIconViewSelectItem:^(NSInteger item) {
        LWLog(@"%ld",(long)item);
        [wself imageSelectItem:item];
    }];
    [action showInView:self.view];
    
    
}

- (void)imageSelectItem:(NSInteger)item{
    
    LWLog(@"%ld",(long)item);
    UIImagePickerController * pick = [[UIImagePickerController alloc] init];
    if(item == 1000){
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    pick.delegate = self;
    pick.allowsEditing = YES;
    __weak typeof(self) wself = self;
    [pick setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *ac) {
        [vc dismissViewControllerAnimated:YES completion:nil];
        LWLog(@"%@",ac );
        LWLog(@"%@",[NSThread currentThread]);
        [wself.imagepic setImage:ac[@"UIImagePickerControllerOriginalImage"]];
        wself.currentpickImage = ac[@"UIImagePickerControllerOriginalImage"];
    }];
    
//    pick.allowsEditing = YES;
//    [pick setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *ac) {
//        [wself.iconView setImage:ac[@"UIImagePickerControllerOriginalImage"]];
//        [vc dismissViewControllerAnimated:YES completion:nil];
//        LWLog(@"%@",ac );
//        [wself uploadHeadImage:ac[@"UIImagePickerControllerOriginalImage"]];
//        
//    }];
    
    
    [pick setBk_didCancelBlock:^(UIImagePickerController * vc) {
        [vc dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [self presentViewController:pick animated:YES completion:nil];
    
}

- (IBAction)tijiao:(id)sender {
    
    if (self.imagepic.image == nil) {
        [self showErrorWithTitle:@"凭证不能为空" autoCloseTime:1];
        return;
    }
    self.dataImage[@"customer"] = self.customName.text;
    self.dataImage[@"mobile"] = self.phone.text;
    self.dataImage[@"price"] = self.priceName.text;
    self.dataImage[@"memo"] = self.addtionInfo.text;
    if ([self.delegate respondsToSelector:@selector(uploadImage:andImage:)]) {
        [self.delegate uploadImage:self.dataImage andImage:self.currentpickImage];
    }
   
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LWLog(@"%@",[self.model mj_keyValues]);
    
    
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
