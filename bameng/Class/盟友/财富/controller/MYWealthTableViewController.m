//
//  MYWealthTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/1.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYWealthTableViewController.h"
#import "MyWalletTableViewController.h"
#import "SettingTableViewController.h"
#import "MengDouTableViewController.h"
#import "DaijiesuanTableViewController.h"
#import "IntegralTableViewController.h"
#import "CashCouponViewController.h"
#import "MyBusinessViewController.h"
#import "MyOrderViewController.h"
#import "UserInfoTableViewController.h"
#import "InfomationViewController.h"
#import "NewInfomationViewController.h"
#import "CustomerTableViewController.h"

@interface MYWealthTableViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *setting;
@property (strong, nonatomic) IBOutlet UIView *mengdou;
@property (strong, nonatomic) IBOutlet UIView *daijiesuan;
@property (strong, nonatomic) IBOutlet UIView *jifen;
@property (strong, nonatomic) IBOutlet UILabel *mengdouLabel;
@property (strong, nonatomic) IBOutlet UILabel *daijiesuanLabel;
@property (strong, nonatomic) IBOutlet UILabel *jifenLabel;

@property (weak, nonatomic) IBOutlet UILabel *leveLable;

@property (weak, nonatomic) IBOutlet UILabel *mengzhuLable;

@end

@implementation MYWealthTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.leveLable.layer.cornerRadius = 5;
    self.leveLable.layer.masksToBounds = YES;
    
    self.mengzhuLable.layer.cornerRadius = 5;
    self.mengzhuLable.layer.masksToBounds = YES;

    
    self.navigationItem.title = @"财富";
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
    
    [self.jifen bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        IntegralTableViewController *jifen = [story instantiateViewControllerWithIdentifier:@"IntegralTableViewController"];
        [self.navigationController pushViewController:jifen animated:YES];
    }];
    
    [self.tableView removeSpaces];
    
    [self setTabalViewRefresh];
    
    
    self.icon.layer.cornerRadius = self.icon.frame.size.height * 0.5;
    self.icon.layer.masksToBounds =  YES;
    self.icon.layer.borderWidth = 1;
    self.icon.layer.borderColor = [UIColor whiteColor].CGColor;
    [self setDate:[UserModel GetUserModel]];
    
}

- (void)setTabalViewRefresh {
    __weak typeof(self) wself = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself GetUserData];
    }];
    
}

- (void)setDate:( UserModel *)user{
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:user.UserHeadImg] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (!error) {
            [self.icon setImage:image];
        }else{
            [self.icon setImage:[UIImage imageNamed:@"mrtx"]];
        }
        
    }];
    self.name.text = user.NickName;
    self.leveLable.text = user.LevelName;
    self.mengdouLabel.text = [NSString stringWithFormat:@"%@",user.MengBeans];
    self.daijiesuanLabel.text = [NSString stringWithFormat:@"%@",user.TempMengBeans];
    self.jifenLabel.text = [NSString stringWithFormat:@"%@",user.Score];
    self.mengzhuLable.text = [NSString stringWithFormat:@" 盟主:%@ ",user.BelongOneUserName];
    
}

- (void)GetUserData{
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    __weak typeof(self) wself = self;
    [HTMyContainAFN AFN:@"user/myinfo" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            UserModel *user = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
            [NSKeyedArchiver archiveRootObject:user toFile:fileName];
            [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
            [wself setDate:user];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.tabBarController.tabBar.hidden = NO;
    
    
    
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
    if (indexPath.section == 1 && indexPath.row == 0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        MyOrderViewController *business = [story instantiateViewControllerWithIdentifier:@"MyOrderViewController"];
        [self.navigationController pushViewController:business animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        CashCouponViewController *cash = [story instantiateViewControllerWithIdentifier:@"CashCouponViewController"];
        [self.navigationController pushViewController:cash animated:YES];
    }
    if (indexPath.section == 1 && indexPath.row == 2) {
        [self signIn];
    }
    
    if (indexPath.section == 1 && indexPath.row == 3) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        UserInfoTableViewController *user = [story instantiateViewControllerWithIdentifier:@"UserInfoTableViewController"];
        [self.navigationController pushViewController:user animated:YES];
    }else if(indexPath.section == 1 && indexPath.row == 4){
        
        InfomationViewController * vc = [[InfomationViewController alloc] init];
        vc.isLiuyan = 2;
        vc.navigationItem.title = @"我的留言";
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else if(indexPath.section == 1 && indexPath.row == 5){
        NewInfomationViewController * newe = [[NewInfomationViewController alloc] init];
        [self.navigationController pushViewController:newe animated:YES];
    }else if(indexPath.section == 1 && indexPath.row == 6){
        
       
        CustomerTableViewController * vc =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomerTableViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)signIn{
    NSMutableDictionary * parame = [NSMutableDictionary dictionary];
    NSString * city =  [[NSUserDefaults standardUserDefaults] objectForKey:@"currentCity"];
    parame[@"addr"] = city.length?@"city":@"";
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
