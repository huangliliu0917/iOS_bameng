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
#import "NewInfomationViewController.h"
#import "InfomationViewController.h"
#import "WorkUpdateTableViewController.h"
#import "AppDelegate.h"
#import "MessageRedPoint.h"


@interface MyAccountTableViewController ()

@property (nonatomic, strong) UserModel *userInfo;


@property (weak, nonatomic) IBOutlet UIView *myliuyanLable;

@property (weak, nonatomic) IBOutlet UIView *mymessageLable;
@end

@implementation MyAccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.myliuyanLable.layer.cornerRadius = self.myliuyanLable.frame.size.width * 0.5;
    
    self.mymessageLable.layer.cornerRadius = self.myliuyanLable.frame.size.width * 0.5;
    
    [self.headImage setImage:[UIImage imageNamed:@"mrtx"]];
    
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
    
    
    self.mymessageLable.hidden = YES;
    self.myliuyanLable.hidden = YES;
    
    
    
    [self setTabalViewRefresh];
    
    
    AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
    
    
    if (app.messageRed.messagePushCount + app.messageRed.messagePullCount > 0) {
        self.mymessageLable.hidden = NO;
    }else{
       self.mymessageLable.hidden = YES;
    }
    
    if (app.messageRed.messageCount > 0) {
        self.myliuyanLable.hidden = NO;
    }else{
        self.myliuyanLable.hidden = YES;
    }
    
    [app.messageRed addObserver:self forKeyPath:@"messagePullCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [app.messageRed addObserver:self forKeyPath:@"messagePushCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [app.messageRed addObserver:self forKeyPath:@"messageCount" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

//    [self.tableView.mj_footer beginRefreshing];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
    
    
    if([keyPath isEqualToString:@"messagePullCount"] || [keyPath isEqualToString:@"messagePushCount"])
    {
        if(app.messageRed.messagePullCount + app.messageRed.messagePushCount > 0){
            self.mymessageLable.hidden = NO;
            
        }else{
             self.mymessageLable.hidden = YES;
        }
        
        
    }else if([keyPath isEqualToString:@"messageCount"])
    {
        
        NSLog(@"赋值后--%d",app.messageRed.messageCount);
        
        if (app.messageRed.messageCount > 0) {
            self.myliuyanLable.hidden = NO;
        }else{
            self.myliuyanLable.hidden = YES;
            
        }
        
    }
}

- (void)dealloc{
    
    AppDelegate * app =  (AppDelegate * )[UIApplication sharedApplication].delegate;
    [app.messageRed removeObserver:self forKeyPath:@"messagePullCount"];
    [app.messageRed removeObserver:self forKeyPath:@"messagePushCount"];
    [app.messageRed removeObserver:self forKeyPath:@"messageCount"];
}

- (void)setDate:( UserModel *)user{
    
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:user.UserHeadImg] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        if (!error) {
            [self.headImage setImage:image];
        }else{
            [self.headImage setImage:[UIImage imageNamed:@"mrtx"]];
        }
    }];
    self.headImage.layer.cornerRadius = self.headImage.frame.size.width / 2;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.borderWidth = 2;
    self.headImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Level.text = user.LevelName;
    self.nickName.text = user.NickName;
    self.mengdouLable.text = [NSString stringWithFormat:@"%@",user.MengBeans];
    LWLog(@"%@",user.TempMengBeans);
    self.daijiesuanLable.text = [NSString stringWithFormat:@"%@",user.TempMengBeans];
    self.keyongjifenLable.text = [NSString stringWithFormat:@"%@",user.Score];

    
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

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setDate:[UserModel GetUserModel]];
}



- (void)setTabalViewRefresh {
    __weak typeof(self) wself = self;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [wself GetUserData];
    }];
  
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
        }else if(indexPath.row == 3){
           
            InfomationViewController * vc = [[InfomationViewController alloc] init];
            vc.isLiuyan = 2;
            vc.navigationItem.title = @"我的留言";
            [self.navigationController pushViewController:vc animated:YES];
            
            
            
        }else if(indexPath.row == 4){
            NewInfomationViewController * newe = [[NewInfomationViewController alloc] init];
            [self.navigationController pushViewController:newe animated:YES];
        }else if(indexPath.row == 5){
            WorkUpdateTableViewController * worl = [[WorkUpdateTableViewController alloc] init];
            [self.navigationController pushViewController:worl animated:YES];
        }
        
       
        
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
