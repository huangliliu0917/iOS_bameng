//
//  AddNewInfomationTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "AddNewInfomationTableViewController.h"
#import "SelectObjectViewController.h"

@interface AddNewInfomationTableViewController ()<SelectObjectDelegate>

@property (nonatomic, strong) NSString *userIds;

@property (weak, nonatomic) IBOutlet UILabel *nameLable;

@property (weak, nonatomic) IBOutlet UITableViewCell *addcell;

@end

@implementation AddNewInfomationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
   
    self.userIds = @"";
    
    if (self.type == 1) {
       self.navigationItem.title = @"新增留言";
       self.nameLable.text = @"发送对象: 霸盟";
        self.addcell.accessoryType = UITableViewCellAccessoryNone;
    }else{
      self.navigationItem.title = @"新增消息";
    }
    
    
    [self.sendButton bk_whenTapped:^{
        [self sendMessage];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2 && !self.type) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        SelectObjectViewController *select = [story instantiateViewControllerWithIdentifier:@"SelectObjectViewController"];
        select.delegate = self;
        [self.navigationController pushViewController: select animated:YES];
        
        [self.view endEditing:YES];;
    }
}

- (void)selectMengYou:(NSString *)mengYouId andName:(NSString *)names{
    LWLog(@"%@-----%@",mengYouId,names);
    self.userIds = mengYouId;
    self.nameLable.text = names;
}

#pragma mark 发送按钮

- (void)sendMessage {
    if (self.titleField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }else if (self.content.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入咨询内容"];
        return;
    }else if (!self.type && self.userIds.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择盟友"];
        return;
    }else {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"title"] = self.titleField.text;
        dic[@"content"] = self.content.text;
        if (self.type == 1) {
           dic[@"ids"] = @(-1);
        }else{
            dic[@"ids"] = self.userIds;
        }
        LWLog(@"%@",dic);
        [HTMyContainAFN AFN:@"article/create" with:dic Success:^(NSDictionary *responseObject) {
            LWLog(@"user/allylist：%@",responseObject);
            
            if ([responseObject[@"status"] intValue] == 200) {
                [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self.tableView.mj_header endRefreshing];
        } failure:^(NSError *error) {
            LWLog(@"%@", error);
            [self.tableView.mj_header endRefreshing];
        }];
    }
}

@end
