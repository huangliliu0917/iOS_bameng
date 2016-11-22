//
//  BassModel.m
//  bameng
//
//  Created by 刘琛 on 16/11/4.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "BassModel.h"

@implementation BassModel
MJCodingImplementation


+ (instancetype)GetBassModel{
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"BassModel"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
}

+ (void)BassModelSave:(BassModel *)model{
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName = [path stringByAppendingPathComponent:@"BassModel"];
    [NSKeyedArchiver archiveRootObject:model toFile:fileName];
}
@end
