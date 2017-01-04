//
//  MYCustomDetailTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/2.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYCustomDetailTableViewController.h"

@interface MYCustomDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@property (weak, nonatomic) IBOutlet UILabel *addre;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *beizhu;
@property (weak, nonatomic) IBOutlet UILabel *custominfo;

@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;


@property (weak, nonatomic) IBOutlet UIImageView *customImage;



@end

@implementation MYCustomDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.customImage.contentMode = UIViewContentModeScaleAspectFill;
    self.customImage.clipsToBounds = YES;
    [self.tableView removeSpaces];
    
    LWLog(@"%@",[self.model mj_keyValues]);
    
    if (self.model.isSave==0) {
        self.firstCell.hidden = YES;
        
    }else{
        [self.customImage sd_setImageWithURL:[NSURL URLWithString:self.model.DataImg] placeholderImage:nil];
    }
    
    self.name.text = self.model.Name;
    self.phone.text = self.model.Mobile;
    self.addre.text = self.model.Addr;
    
    NSString * statusst = @"未审核";
    if (self.model.Status == 1) {
        statusst = @"同意";
    }else if(self.model.Status == 2){
        statusst = @"拒绝";
    }
    self.status.text = statusst;
    self.beizhu.text = self.model.Remark;
    
    if(self.model.InShop){
        self.custominfo.text = @"已进店";
    }else{
        self.custominfo.text = @"未进店";
    }
    
}





#pragma mark - Table view data source
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 变高行数
    if (indexPath.row == 0) {
        if (self.model.isSave == 0) {
            // 假设改行原来高度为200
            return 0;
        } else {
            return 160;
        }
    } else {
        /** 返回静态单元格故事板中的高度 */
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

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
