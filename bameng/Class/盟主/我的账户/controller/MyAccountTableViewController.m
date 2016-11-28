//
//  MyAccountTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyAccountTableViewController.h"
#import "SettingTableViewController.h"
#import "MengDouTableViewController.h"
#import "DaijiesuanTableViewController.h"
#import "IntegralTableViewController.h"
#import "UserInfoTableViewController.h"
#import "MyWalletTableViewController.h"
#import "PushWebViewController.h"

@interface MyAccountTableViewController ()

@property (nonatomic, strong) UserModel *userInfo;

@end

@implementation MyAccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    

    
    //self.headImage.backgroundColor = [UIColor whiteColor];
    
    self.Level.layer.masksToBounds = YES;
    self.Level.layer.cornerRadius = 3;
    
    self.tableView.separatorColor = [UIColor colorWithRed:232/255.0 green:234/255.0 blue:235/255.0 alpha:1];
    [self.tableView removeSpaces];
    
    self.navigationItem.title = @"我的账户";
    
    self.setting.userInteractionEnabled = YES;
    [self.setting bk_whenTapped:^{
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        
        SettingTableViewController *setting = [story instantiateViewControllerWithIdentifier:@"SettingTableViewController"];
        [self.navigationController pushViewController:setting animated:YES];
    }];
    
    [self.mengdou bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        MengDouTableViewController *mengdou = [story instantiateViewControllerWithIdentifier:@"MengDouTableViewController"];
        [self.navigationController pushViewController:mengdou animated:YES];
    }];
    
    [self.daijiesuan bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        DaijiesuanTableViewController *jiesuan = [story instantiateViewControllerWithIdentifier:@"DaijiesuanTableViewController"];
        [self.navigationController pushViewController:jiesuan animated:YES];
    }];
    
    [self.keyongjifen bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        IntegralTableViewController *jifen = [story instantiateViewControllerWithIdentifier:@"IntegralTableViewController"];
        [self.navigationController pushViewController:jifen animated:YES];
    }];
    
    self.headImage.contentMode = UIViewContentModeScaleAspectFill;
    self.headImage.clipsToBounds = YES;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    UserModel * user = [UserModel GetUserModel];
    
    LWLog(@"%@",user.UserHeadImg);
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:user.UserHeadImg] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width / 2;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.borderWidth = 0.7;
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Level.text = user.LevelName;
    self.nickName.text = user.NickName;
    self.mengdouLable.text = [NSString stringWithFormat:@"%@",user.MengBeans];
    LWLog(@"%@",user.TempMengBeans);
    self.daijiesuanLable.text = [NSString stringWithFormat:@"%@",user.TempMengBeans];
    self.keyongjifenLable.text = [NSString stringWithFormat:@"%@",user.Score];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        MyWalletTableViewController *wallet = [story instantiateViewControllerWithIdentifier:@"MyWalletTableViewController"];
        [self.navigationController pushViewController:wallet animated:YES];
    }
    if (indexPath.section == 1) {
        
        if(indexPath.row == 0){
            [self signIn];
        }else if(indexPath.row == 1){
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
            UserInfoTableViewController *user = [story instantiateViewControllerWithIdentifier:@"UserInfoTableViewController"];
            [self.navigationController pushViewController:user animated:YES];
        }else if(indexPath.row == 2){
            UserModel * user = [UserModel GetUserModel];
            PushWebViewController *push = [[PushWebViewController alloc] init];
            push.openUrl = user.myqrcodeUrl;
            [self.navigationController pushViewController:push animated:YES];
        }
        
    }
    
    
}


- (void)signIn{
    NSMutableDictionary * parame = [NSMutableDictionary dictionary];
    [HTMyContainAFN AFN:@"user/signin" with:parame Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] integerValue] == 200) {
            [self showRightWithTitle: responseObject[@"statusText"] autoCloseTime: 1.5];
        }else{
            [self showErrorWithTitle:responseObject[@"statusText"] autoCloseTime: 1.5];
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
