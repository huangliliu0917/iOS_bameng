//
//  MYOrderDetailTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/11/2.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MYOrderDetailTableViewController.h"
#import "OrderDetailModel.h"


@interface MYOrderDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *customName;
@property (weak, nonatomic) IBOutlet UILabel *contantNumber;
@property (weak, nonatomic) IBOutlet UILabel *addressLable;
@property (weak, nonatomic) IBOutlet UILabel *beizhuLable;
@property (weak, nonatomic) IBOutlet UILabel *statusLable;

@end

@implementation MYOrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self.tableView removeSpaces];
    
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"id"] = self.model.orderId;
    __weak typeof(self) wself = self;
    [HTMyContainAFN AFN:@"order/details" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            OrderDetailModel * model = [OrderDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            [wself setData:model];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];

//    self.orderNumber.text = [NSString stringWithFormat:@"%@",self.model.orderId];
   // self.timeLable.text = [NSString stringWithFormat:@"%@",self.model.time];
}

- (void)setData:(OrderDetailModel *)model{
    self.orderNumber.text = model.orderId;
    self.timeLable.text = model.orderTime;
    self.customName.text = model.userName;
    self.contantNumber.text = model.mobile;
    self.addressLable.text = model.address;
    self.beizhuLable.text = model.remark;
    if(model.status == 0){
        self.statusLable.text = @"未成交";
    }else if(model.status == 1){
        self.statusLable.text = @"成交";

    }
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
