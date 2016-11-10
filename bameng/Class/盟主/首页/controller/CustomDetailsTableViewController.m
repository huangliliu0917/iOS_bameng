//
//  CustomDetailsTableViewController.m
//  bameng
//
//  Created by 刘琛 on 16/10/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CustomDetailsTableViewController.h"

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

@end

@implementation CustomDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    

    
    self.submit.layer.masksToBounds = YES;
    self.submit.layer.cornerRadius = 5;
    

   
    self.picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, KScreenHeight , KScreenWidth, 216)];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.picker.backgroundColor = [UIColor whiteColor];
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self.picker];
    
    
    

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    self.name.text = self.customModel.Name;
    self.phone.text = self.customModel.Mobile;
    self.address.text = self.customModel.Addr;
    self.remarks.text = self.customModel.Remark;
    if (self.customModel.Status == 1) {
        self.reviewStatus.text = @"已同意";
    }else if (self.customModel.Status == 2) {
        self.reviewStatus.text = @"已拒绝";
    }else if (self.customModel.Status == 0) {
        self.reviewStatus.text = @"审核中";
    }
    
    if (_customModel.InShop) {
        self.submit.hidden = YES;
        self.comeStatus.text = @"已进店";
    }else {
        self.submit.hidden = NO;
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
            return 44;
            break;
        }
        case 1:{
            return 44;
            break;
        }
        case 2:{
            
            CGSize size = [self getLabelSizeFormSize:CGSizeMake(KScreenWidth - 136 - 20, MAXFLOAT) AndStr:self.customModel.Addr];
            return 44 + size.height - 20.5;
            break;
        }
        case 3:{
            return 44;
            break;
        }
        case 4:{
            CGSize size = [self getLabelSizeFormSize:CGSizeMake(KScreenWidth - 136 - 20, MAXFLOAT) AndStr:self.customModel.Remark];
            return 44 + size.height - 20.5;
            break;
        }
        case 5:{
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
    if (indexPath.row == 5) {
        [UIView animateWithDuration:0.25 animations:^{
            self.picker.frame = CGRectMake(0, KScreenHeight - 216 , KScreenWidth, 216);
        }];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        self.selcetIndex = 1;
        [UIView animateWithDuration:0.25 animations:^{
            self.picker.frame = CGRectMake(0, KScreenHeight , KScreenWidth, 216);
        }];
    }else {
        self.selcetIndex = 2;
        [UIView animateWithDuration:0.25 animations:^{
            self.picker.frame = CGRectMake(0, KScreenHeight , KScreenWidth, 216);
        }];
    }
}




#pragma mark 动态高度计算

- (CGSize)getLabelSizeFormSize:(CGSize ) size AndStr :(NSString *) str{
    
    CGSize transSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}  context:nil].size;
    return transSize;
}

@end
