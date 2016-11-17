//
//  UserModel.m
//  bameng
//
//  Created by 刘琛 on 16/11/3.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
MJCodingImplementation

+ (instancetype) GetUserModel{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
}

+ (void)SaveUserModel:(UserModel *)user{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:UserInfomation];
    [NSKeyedArchiver archiveRootObject:user toFile:fileName];
}

@end
