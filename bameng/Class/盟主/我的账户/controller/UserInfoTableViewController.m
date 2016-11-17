//
//  UserInfoTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/26.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "UserInfoTableViewController.h"
#import "UIImagePickerController+BlocksKit.h"
@interface UserInfoTableViewController ()<LXActionSheetDelegate>

/**头像*/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *nickName;

@property (weak, nonatomic) IBOutlet UILabel *phoneNum;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *sex;

@end

@implementation UserInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"个人信息";
    
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
        [action setIconViewSelectItem:^(int item) {
            LWLog(@"%d",item);
            [wself imageSelectItem:item];
        }];
        [action showInView:self.view];
    }else if(indexPath.section == 0 && indexPath.row == 1){
        LXActionSheet * action = [[LXActionSheet alloc] initWithTitle:1 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        __weak typeof(self) wself = self;
        [action setNickNameandNameSelectItem:^(NSInteger type , NSString *content) {
            [wself setNickNameandNameSelectItem:type andContent:content];
        }];
        [action showInView:self.view];
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
       
        [action showInView:self.view];
    }
    
    
}


- (void)setNickNameandNameSelectItem:(NSInteger)type andContent:(NSString *)content{
    
    LWLog(@"%d-----%@",type,content);
    
    if (type == 1) {
        self.nickName.text = content;
    }else if(type == 2){
        self.name.text = content;
        
    }
}


/**
 *  头像
 */
- (void)imageSelectItem:(int)item{
    LWLog(@"%d",item);
    __weak typeof(self) wself = self;
    if(item == 1000){//拍照
        
    }else{//相册
        UIImagePickerController * pick = [[UIImagePickerController alloc] init];
        [pick setBk_didFinishPickingMediaBlock:^(UIImagePickerController *vc, NSDictionary *ac) {
            [wself.iconView setImage:ac[@"UIImagePickerControllerOriginalImage"]];
            [vc dismissViewControllerAnimated:YES completion:nil];
            LWLog(@"%@",ac );
            
        }];
        [pick setBk_didCancelBlock:^(UIImagePickerController * vc) {
            [vc dismissViewControllerAnimated:YES completion:nil];

        }];
        [self presentViewController:pick animated:YES completion:nil];
    }
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
