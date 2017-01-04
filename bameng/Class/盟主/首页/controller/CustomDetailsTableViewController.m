//
//  CustomDetailsTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CustomDetailsTableViewController.h"
#import "NewOrderTableViewController.h"

@interface CustomDetailsTableViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *reviewStatus;
@property (strong, nonatomic) IBOutlet UILabel *remarks;
@property (strong, nonatomic) IBOutlet UILabel *comeStatus;
@property (strong, nonatomic) IBOutlet UIButton *submit;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, assign) NSInteger selcetIndex;

@property (nonatomic, strong) UIPickerView *picker;

@property (weak, nonatomic) IBOutlet UILabel *belongTo;

@property (weak, nonatomic) IBOutlet UITableViewCell *accessstatus;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;


@property (weak, nonatomic) IBOutlet UIButton *CNewOrderbtn;


@end

@implementation CustomDetailsTableViewController


/**新建订单*/
- (IBAction)CreateOrderBtn:(id)sender {
    
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"MengZhu" bundle:nil];
    NewOrderTableViewController *newOrder = [story instantiateViewControllerWithIdentifier:@"NewOrderTableViewController"];
    newOrder.customModel = self.customModel;
    [self.navigationController pushViewController:newOrder animated:YES];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    self.CNewOrderbtn.layer.masksToBounds = YES;
    self.CNewOrderbtn.layer.cornerRadius = 5;
    
    self.submit.layer.masksToBounds = YES;
    self.submit.layer.cornerRadius = 5;
    

   
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, KScreenHeight , KScreenWidth, 216)];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.backgroundColor = [UIColor whiteColor];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.picker];
    
    
    self.submit.hidden = YES;

    if (self.customModel.InShop) {
        self.CNewOrderbtn.hidden = NO;
    }else{
        self.CNewOrderbtn.hidden = YES;
    }
    
    
    if (self.customModel.isSave == 1) {
        
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:self.customModel.DataImg] placeholderImage:[UIImage imageNamed:@"mrtx"]];
    }
}

/**
 *  设置datepicker的工具条
 */
- (void)setupDatePicker
{
    
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 44)];
    toolBar.backgroundColor = [UIColor grayColor];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectClick)];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[item1,item3,item2];
//    self.comeStatus.inputAccessoryView = toolBar;
}

- (void)selectClick{
    
    
}

- (void)cancleClick{
    
    
}
- (IBAction)btnClick:(id)sender {
    
    
    LWLog(@"xxxxx");
    
    NSMutableDictionary *parme = [NSMutableDictionary dictionary];
    parme[@"cid"] = self.customModel.ID;
    
    //1进店 0未进店
    parme[@"status"] = @(self.selcetIndex - 1);
    LWLog(@"%@",parme);
    [HTMyContainAFN AFN:@"customer/UpdateInShop" with:parme Success:^(NSDictionary *responseObject) {
        LWLog(@"%@", responseObject);
        [MBProgressHUD showSuccess:responseObject[@"statusText"]];
    } failure:^(NSError *error) {
        LWLog(@"%@",error);
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    
    LWLog(@"%@",[self.customModel mj_keyValues]);
    
    self.belongTo.text = self.customModel.BelongOneName;
    self.name.text = self.customModel.Name;
    self.phone.text = self.customModel.Mobile;
    self.address.text = self.customModel.Addr;
    self.remarks.text = self.customModel.Remark;
    if (self.customModel.Status == 1) {
        self.reviewStatus.text = @"已同意";
    }else if (self.customModel.Status == 2) {
        self.reviewStatus.text = @"已拒绝";
    }else if (self.customModel.Status == 0) {
        self.reviewStatus.text = @"未审核";
    }
    
    if (_customModel.InShop) {
        self.accessstatus.accessoryType = UITableViewCellAccessoryNone;
        self.comeStatus.text = @"已进店";
    }else {
        
        self.comeStatus.text = @"未进店";
    }
    
}

- (void)updateInshop {
    if (_selcetIndex != 2) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"cid"] = _customModel.ID;
        dic[@"status"] = @(self.selcetIndex);
        
    }
}



#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            
            if (self.customModel.isSave == 0) {
               return 0;
                break;
            }else{
                return 180;
                break;
            }
            
           
        }
        case 1:{
            return 44;
            break;
        }
        case 2:{
            return 44;
            break;
        }
        case 3:{
            
            CGSize size = [self getLabelSizeFormSize:CGSizeMake(KScreenWidth - 136 - 20, MAXFLOAT) AndStr:self.customModel.Addr];
            return 44 + size.height - 20.5;
            break;
        }
        case 4:{
            return 44;
            break;
        }
        case 5:{
            CGSize size = [self getLabelSizeFormSize:CGSizeMake(KScreenWidth - 136 - 20, MAXFLOAT) AndStr:self.customModel.Remark];
            return 44 + size.height - 20.5;
            break;
        }
        case 6:{
            if (self.customModel.Status == 2) {
                self.submit.hidden = YES;
                return 0;
            }
            return 44;
            break;
        }
        default:
            break;
    }
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 7) {
        
        if(!_customModel.InShop){
            [UIView animateWithDuration:0.25 animations:^{
                self.picker.frame = CGRectMake(0, KScreenHeight - 216 , KScreenWidth, 216);
            }];
        }
        
    }
}

#pragma mark pickerView 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row == 0) {
        return @"未进店";
    }else if (row == 1) {
        return @"已进店";
    }
    return @"";
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    LWLog(@"xxxx");
    [UIView animateWithDuration:0.25 animations:^{
        self.picker.frame = CGRectMake(0, KScreenHeight , KScreenWidth, 216);
    }];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    LWLog(@"%ld",(long)row);
    if (row == 0) {
        self.selcetIndex = 1;
        self.submit.hidden = YES;
        self.comeStatus.text = @"未进店";
        [UIView animateWithDuration:0.25 animations:^{
            self.picker.frame = CGRectMake(0, KScreenHeight , KScreenWidth, 216);
        }];
    }else {
        self.selcetIndex = 2;
        self.submit.hidden = NO;
        self.comeStatus.text = @"已进店";
        [UIView animateWithDuration:0.25 animations:^{
            self.picker.frame = CGRectMake(0, KScreenHeight , KScreenWidth, 216);
        }];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.picker removeFromSuperview];
}


#pragma mark 动态高度计算

- (CGSize)getLabelSizeFormSize:(CGSize ) size AndStr :(NSString *) str{
    
    CGSize transSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}  context:nil].size;
    return transSize;
}

@end
