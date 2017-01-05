//
//  MYAddNewMessageTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/1.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYAddNewMessageTableViewController.h"

@interface MYAddNewMessageTableViewController ()
@property (strong, nonatomic) IBOutlet UITextField *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;


@end

@implementation MYAddNewMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type == 1) {
        self.navigationItem.title = @"新增留言";
    }else{
        self.navigationItem.title = @"新增消息";
    }
}
- (IBAction)sendMessage:(id)sender {
    
    if (self.titleLabel.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }else if (self.content.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入咨询内容"];
        return;
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"title"] = self.titleLabel.text;
        dic[@"content"] = self.content.text;
        
        if (self.type == 1) {
            dic[@"ids"] = @"-1";
        }else{
            dic[@"ids"] = @" ";
        }
        [HTMyContainAFN AFN:@"article/create" with:dic Success:^(NSDictionary *responseObject) {
            LWLog(@"user/allylist：%@",responseObject);
            if ([responseObject[@"status"] intValue] == 200) {
                [self showRightWithTitle:@"发送成功" autoCloseTime:1.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
            [self.tableView.mj_header endRefreshing];
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 变高行数
    if (indexPath.section == 2 && indexPath.row == 0 ) {
        if (self.type != 1) {
            // 假设改行原来高度为200
            return 00;
        } else {
            return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    } else {
        /** 返回静态单元格故事板中的高度 */
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}
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
