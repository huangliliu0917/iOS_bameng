//
//  CashModel.m
//  bameng
//
//  Created by lhb on 16/11/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "CashModel.h"
#import "AsignLibrary.h"
@implementation CashModel


- (NSString *)url{
    UserModel * model = [UserModel GetUserModel];
    NSDictionary * dict = @{@"userid":model.UserId,@"cpid":@(self.ID)};
    LWLog(@"%@",dict);
    LWLog(@"%@",[NSString stringWithFormat:@"%@?%@",_url, [AsignLibrary urlSign:dict]]);
    return [NSString stringWithFormat:@"%@?%@",_url, [AsignLibrary urlSign:dict]];
}
@end
