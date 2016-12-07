//
//  SettingTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/25.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "SettingTableViewController.h"
#import "LoginController.h"
#import "PushWebViewController.h"
#import "BassModel.h"
#import "ChangePassWdViewController.h"
#import "SDImageCache.h"

@interface SettingTableViewController ()


@property(nonatomic,weak)  UIButton * loginBtn;


@property (weak, nonatomic) IBOutlet UILabel *rightLable;

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.logOutButton.layer.masksToBounds = YES;
    self.logOutButton.layer.cornerRadius = 5;

   
    
    
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    LWLog(@"%f",tmpSize/1024);
    self.rightLable.text = [NSString stringWithFormat:@"%.2fM",tmpSize/1024/1024];
    
    UIWindow * win =  [[UIApplication sharedApplication].windows lastObject];
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, KScreenHeight - 44, KScreenHeight, 44)];
    btn.backgroundColor = LWColor(252, 84, 83);
    self.loginBtn = btn;
    [self.view.window addSubview:btn];
    
    [self.loginBtn addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.loginBtn removeFromSuperview];
}

- (void)loginOut{
    
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"帐号退出" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginController *login = [story instantiateViewControllerWithIdentifier:@"LoginController"];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }];
    [alertVC addAction:ac];
    UIAlertAction * bc = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:bc];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BassModel * model = [BassModel GetBassModel];
    if (indexPath.row == 0) {
        LWLog(@"xxxxx");
       ChangePassWdViewController * vc =  [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChangePassWdViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        [[SDImageCache sharedImageCache] clearDisk];
        
        [[SDImageCache sharedImageCache] clearMemory];//可有可无
        
        self.rightLable.text = @"0M";
    }else if(indexPath.row == 2){
        PushWebViewController *push = [[PushWebViewController alloc] init];
        push.openUrl = model.aboutUrl;
        [self.navigationController pushViewController:push animated:YES];
    }else{
        PushWebViewController *push = [[PushWebViewController alloc] init];
        push.openUrl = model.agreementUrl;
        [self.navigationController pushViewController:push animated:YES];
    }
}
//
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
