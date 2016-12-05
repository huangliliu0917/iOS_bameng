//
//  UserInfoTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UIImagePickerController+BlocksKit.h"
#import "AreaPickerView.h"
#import "SetPhoneViewController.h"

@interface UserInfoTableViewController ()<LXActionSheetDelegate,AreaPickerDelegate,SetPhoneViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/**头像*/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *phoneNum;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *areaLable;


@property (nonatomic, strong) AreaPickerView * areaView;

@end

@implementation UserInfoTableViewController


- (AreaPickerView *)areaView{
    if (_areaView == nil) {
        
        _areaView = [[AreaPickerView alloc] initWithDelegate:self];
    }
    return _areaView;
}

- (void)pickerDidChaneStatus:(AreaPickerView *)picker{
    
    
}

- (void)pickerViewSelectAreaOfCode:(AreaLocation *)locate{
    LWLog(@"%@---%@---%@",locate.province,locate.city,locate.area);
    NSString * city = [NSString stringWithFormat:@"%@_%@_%@",locate.province,locate.city,locate.area];
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"type"] = @"6";
    parme[@"content"] = city;
    [HTMyContainAFN AFN:@"user/UpdateInfo" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    self.areaLable.text = city;
    UserModel * user = [UserModel GetUserModel];
    user.UserCity = city;
    [UserModel SaveUserModel:user];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息";
    /**获取用户信息*/
    [HTMyContainAFN AFN:@"user/myinfo" with:nil Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            UserModel *user = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
            [NSKeyedArchiver archiveRootObject:user toFile:fileName];
            self.nickName.text = user.NickName;
            self.phoneNum.text = user.UserMobile;
            self.name.text = user.RealName;
            if ([user.UserGender isEqualToString:@"f"]) {
                self.sex.text = @"女";
            }else if([user.UserGender isEqualToString:@"m"]){
                self.sex.text = @"男";
            }
            if (user.UserCity.length) {
               self.areaLable.text =  [[user.UserCity componentsSeparatedByString:@"-"] objectAtIndex:1];
            }
            
            
            [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.UserHeadImg] placeholderImage:[UIImage imageNamed:@"mrtx"]];
        }
 
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];

    
    
//    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
//    self.iconView.cli
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LWLog(@"%@",indexPath);
    if (indexPath.section == 0 && indexPath.row == 0) {
        LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:0 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        __weak typeof(self) wself = self;
        [action setIconViewSelectItem:^(NSInteger item) {
            LWLog(@"%ld",(long)item);
            [wself imageSelectItem:item];
        }];
        [action showInView:self.view];
    }else if(indexPath.section == 0 && indexPath.row == 1){
        LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:1 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        __weak typeof(self) wself = self;
        action.isNickName = YES;
        [action setNickNameandNameSelectItem:^(NSInteger type , NSString *content) {
            [wself setNickNameandNameSelectItem:type andContent:content];
        }];
        [action showInView:self.view];
    }else if(indexPath.section == 0 && indexPath.row == 2){
        
        SetPhoneViewController * vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SetPhoneViewController"];
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.section == 1 && indexPath.row == 1){
        
        LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:2 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        __weak typeof(self) wself = self;
        [action setNickNameandNameSelectItem:^(NSInteger type , NSString *content) {
            [wself setNickNameandNameSelectItem:type andContent:content];
        }];
        [action showInView:self.view];
    }else if(indexPath.section == 1 && indexPath.row == 2){
        
        LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:3 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        __weak typeof(self) wself = self;
        [action setSexPickItem:^(NSInteger item) {
            [wself sexSelect:item];
        }];
        [action showInView:self.view];
    }else if(indexPath.section == 1 && indexPath.row == 3){
        
        [self.areaView showInView:self.view.window];
        
    }
    
    
}

- (void)savePhoneNumber:(NSString *)phome{
    self.phoneNum.text= phome;
}

/**
 * 1000 男
 * 1001 女
 */
- (void)sexSelect:(NSInteger)item{
    LWLog(@"%ld-----",(long)item);
    self.sex.text = (item==1000?@"男":@"女");
    UserModel * user = [UserModel GetUserModel];
    user.UserGender = (item==1000?@"m":@"f");
    [UserModel SaveUserModel:user];
}

- (void)setNickNameandNameSelectItem:(NSInteger)type andContent:(NSString *)content{
    
    LWLog(@"%ld-----%@",(long)type,content);
    UserModel * user = [UserModel GetUserModel];
    
    if (type == 1) {
        self.nickName.text = content;
        user.NickName = content;
    }else if(type == 2){
        self.name.text = content;
        user.RealName = content;
    }
    [UserModel SaveUserModel:user];

}


/**
 *  头像
 */
- (void)imageSelectItem:(NSInteger)item{
    LWLog(@"%ld",(long)item);
    __weak typeof(self) wself = self;
    if(item == 1000){//拍照
        UIImagePickerController * pick = [[UIImagePickerController alloc] init];
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        pick.delegate = self;
        pick.allowsEditing = YES;
        [pick setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *ac) {
            [wself.iconView setImage:ac[@"UIImagePickerControllerOriginalImage"]];
            [vc dismissViewControllerAnimated:YES completion:nil];
            LWLog(@"%@",ac );
            [wself uploadHeadImage:ac[@"UIImagePickerControllerOriginalImage"]];
            
        }];
        [pick setBk_didCancelBlock:^(UIImagePickerController * vc) {
            [vc dismissViewControllerAnimated:YES completion:nil];
            
        }];
        [self presentViewController:pick animated:YES completion:nil];
    }else{//相册
        UIImagePickerController * pick = [[UIImagePickerController alloc] init];
        [pick setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *ac) {
            [wself.iconView setImage:ac[@"UIImagePickerControllerOriginalImage"]];
            [vc dismissViewControllerAnimated:YES completion:nil];
            LWLog(@"%@",ac );
            [wself uploadHeadImage:ac[@"UIImagePickerControllerOriginalImage"]];
            
        }];
        [pick setBk_didCancelBlock:^(UIImagePickerController * vc) {
            [vc dismissViewControllerAnimated:YES completion:nil];

        }];
        [self presentViewController:pick animated:YES completion:nil];
    }
}


- (void)uploadHeadImage:(UIImage *)headImage{
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"type"] = @(1);
    
    __weak typeof(self)wself = self;
    [HTMyContainAFN AFNUpLoadImage:@"user/UpdateInfo" with:parme andImage:headImage Success:^(NSDictionary *responseObject) {
        LWLog(@"%@",responseObject);
        if([[responseObject objectForKey:@"status"] integerValue] == 200){
            [wself showRightWithTitle:[responseObject objectForKey:@"statusText"] autoCloseTime:1.4];
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}

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
