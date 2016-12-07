//
//  OrderDetailTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/27.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "OrderDetailTableViewController.h"
#import "PostOrderTableViewController.h"
#import "OrderDetailModel.h"
@interface OrderDetailTableViewController ()<PostOrderTableViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *ordorImage;
@property (strong, nonatomic) IBOutlet UIImageView *addImage;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *postButton;
/**订单号*/
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
/**下单日期*/
@property (weak, nonatomic) IBOutlet UILabel *orderData;
/**客户名称*/
@property (weak, nonatomic) IBOutlet UILabel *customName;


@property (weak, nonatomic) IBOutlet UILabel *contantInfo;
@property (weak, nonatomic) IBOutlet UILabel *customAdd;
@property (weak, nonatomic) IBOutlet UILabel *indoAdd;

@property (weak, nonatomic) IBOutlet UILabel *said;


@property (weak, nonatomic) IBOutlet UITableViewCell *statusCell;



/**上传凭证*/
@property(nonatomic,strong) UIImage * backImage;

@property(nonatomic,strong) NSMutableDictionary * dataDic;


@property(nonatomic,assign) int status;
@end

@implementation OrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) wself = self;
    [self.postButton bk_whenTapped:^{
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
        PostOrderTableViewController *postOrder = [story instantiateViewControllerWithIdentifier:@"PostOrderTableViewController"];
        postOrder.delegate = wself;
        postOrder.model = wself.model;
        
        LWLog(@"%@",wself.dataDic);
        postOrder.havePickImage = wself.backImage;
        postOrder.dict = wself.dataDic;
        [self.navigationController pushViewController:postOrder animated:YES];
        
    }];
    self.ordorImage.contentMode = UIViewContentModeScaleAspectFit;
    self.ordorImage.clipsToBounds = YES;
    
    LWLog(@"%@",[self.model mj_keyValues]);
    //order/details
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"id"] = self.model.orderId;
    //__weak typeof(self) wself = self;
    [HTMyContainAFN AFN:@"order/details" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            OrderDetailModel * model = [OrderDetailModel mj_objectWithKeyValues:responseObject[@"data"]];
            [wself setData:model];
        }
        
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
    self.saveButton.hidden = YES;
    self.postButton.hidden = YES;
    
    if(self.model.status == 0){
        self.statusCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
       self.statusCell.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setModel:(OrderInfoModel *)model{
    _model = model;
    
    
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}

- (void)setData:(OrderDetailModel *)model{
    self.orderNumber.text = model.orderId;
    self.orderData.text = model.orderTime;
    self.customName.text = model.userName;
    self.contantInfo.text = model.mobile;
    self.indoAdd.text = model.note;
    self.customAdd.text = model.address;
    __weak typeof(self) wself = self;
    NSString * imageurl = nil;
    
    
    if (model.status>0) {
        imageurl = model.successUrl;
    }else{
       imageurl = model.pictureUrl;
    }
    
    if(model.status == 0){
        self.said.text = @"未成交";
//        self.saveButton.hidden = YES;
//        self.postButton.hidden = NO;
    }else if(model.status == 1){
        self.said.text = @"成交";
//        self.saveButton.hidden = YES;
//        self.postButton.hidden = YES;
    }else{
        self.said.text = @"退单";
//        self.saveButton.hidden = NO;
//        self.postButton.hidden = YES;
    }
    LWLog(@"%@",imageurl);
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageurl] options:SDWebImageRetryFailed progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        LWLog(@"xxx%@",imageURL);
        if (!error) {
           [wself.ordorImage setImage:image];
            
//            wself.backImage = image;
        }
        
    }];
    
    
    
    
}

/**上传订单*/
- (void)uploadImage:(NSMutableDictionary *)dict andImage:(UIImage *)image{
    
    self.backImage = image;
    self.dataDic = dict;
    LWLog(@"%@",dict);
    self.ordorImage.image = image;
}
#pragma mark - Table view data source


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 6) {
        
        if(self.model.status == 0){
            UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            __weak typeof(self) wself = self;
            UIAlertAction * ac1 = [UIAlertAction actionWithTitle:@"未成交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [wself setsetlect:0];
            }];
            [alertVC addAction:ac1];
            
            UIAlertAction * ac2 = [UIAlertAction actionWithTitle:@"成交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [wself setsetlect:1];
            }];
            [alertVC addAction:ac2];
            
            UIAlertAction * ac3 = [UIAlertAction actionWithTitle:@"退单" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [wself setsetlect:2];
            }];
            [alertVC addAction:ac3];
            
            UIAlertAction * ac4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:nil];
            [alertVC addAction:ac4];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
        
    }
    
    
}


- (void)setsetlect:(int) status{
    if (status == 0) {//未成交
        self.status = 0;
        self.said.text = @"未成交";
        self.saveButton.hidden = YES;
        self.postButton.hidden = YES;
    }else if(status == 1){//成交
        self.status = 1;
        self.said.text = @"成交";
        self.saveButton.hidden = NO;
        self.postButton.hidden = NO;
    }else{//退单
        self.status = 2;
        self.said.text = @"退单";
        self.saveButton.hidden = NO;
        self.postButton.hidden = YES;
    }
    
}


- (IBAction)saveBtnClick:(id)sender {
    
    LWLog(@"xxxxx");
    
    if (self.status == 1 && !self.backImage) {
        [MBProgressHUD showError:@"请上传凭证"];
        return;
    }
    //order/UploadSuccessVoucher
    if (self.status == 1) {
        [self UploadSuccessVoucher];
    }else{
        [self updateOrder];
    }
    
}


- (void)updateOrder{
    
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"orderId"] = self.model.orderId;
    parme[@"status"] = @(self.status);
    
    [HTMyContainAFN AFN:@"order/update" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        if ([responseObject[@"status"] intValue] == 200) {
            
            [MBProgressHUD showSuccess:responseObject[@"statusText"]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
           
        }
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];

}

- (void)UploadSuccessVoucher{

    
    __weak typeof(self) wself = self;
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"orderId"] = self.model.orderId;
    parme[@"customer"] = self.dataDic[@"customer"];
    parme[@"mobile"] = self.dataDic[@"mobile"];
    parme[@"price"] = self.dataDic[@"price"];
    parme[@"memo"] = self.dataDic[@"memo"];
    [HTMyContainAFN AFNUpLoadImage:@"order/UploadSuccessVoucher" with:parme andImage:self.backImage Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [wself updateOrder];
    } failure:^(NSError *error) {
        LWLog(@"%@", error);
    }];
 
}


//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
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
