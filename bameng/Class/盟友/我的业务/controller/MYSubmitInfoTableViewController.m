//
//  MYSubmitInfoTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/1.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYSubmitInfoTableViewController.h"

@interface MYSubmitInfoTableViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextView *remarks;

@end

@implementation MYSubmitInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.remarks.layer.borderWidth = 1;
    self.remarks.layer.borderColor = [UIColor blackColor].CGColor;
    
    self.phone.delegate = self;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phone) {
        if (textField.text.length > 10) return NO;
    }
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    self.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitClick:(id)sender {
    
    
    
//    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
//    parme[@"username"] = phoneText;
//    parme[@"mobile"] = [AsignLibrary md5by32:passwordText];
//    parme[@"address"] = phoneText;
//    parme[@"remark"] = [AsignLibrary md5by32:passwordText];
//
//    [HTMyContainAFN AFN:@"customer/create" with:parme Success:^(NSDictionary *responseObject) {
//        LWLog(@"%@", responseObject);
//        if ([responseObject[@"status"] intValue] == 200) {
//            UserModel *user = [UserModel mj_objectWithKeyValues:responseObject[@"data"]];
//            NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//            NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
//            [NSKeyedArchiver archiveRootObject:user toFile:fileName];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:user.token forKey:AppToken];
//            if (user.UserIdentity == 1) {
//                [[NSUserDefaults standardUserDefaults] setObject:isMengZhu forKey:mengyouIdentify];
//                UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
//                MengzhuTabbarController *tabbar = [story instantiateViewControllerWithIdentifier:@"MengzhuTabbarController"];
//                [UIApplication sharedApplication].keyWindow.rootViewController = tabbar;
//                
//            }else if (user.UserIdentity == 0) {
//                [[NSUserDefaults standardUserDefaults] setObject:isMengYou forKey:mengyouIdentify];
//                UIStoryboard *mengyou = [UIStoryboard storyboardWithName:@"MengYou" bundle:nil];
//                MengYouTabbarViewController *you = [mengyou instantiateViewControllerWithIdentifier:@"MengYouTabbarViewController"];
//                [UIApplication sharedApplication].keyWindow.rootViewController = you;
//            }
//            
//            
//        }
//        
//    } failure:^(NSError *error) {
//        LWLog(@"%@",error);
//    }];
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
