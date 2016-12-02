//
//  AsignLibrary.m
//  AsignLibrary
//
//  Created by lhb on 16/7/11.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "AsignLibrary.h"
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@implementation AsignLibrary


+ (NSMutableDictionary *)AsignLibraryAdditionParame:(NSDictionary *)parame{
    
    NSMutableDictionary * innerParame = nil;
    if (parame) {
        innerParame  = [[NSMutableDictionary alloc] initWithDictionary:parame];
    }else{
        innerParame = [[NSMutableDictionary alloc] init];
    }
    //timestamp(时间戳)，version(版本号,格式1.0.0)，os(操作系统[android,iphone])
    NSString * aa = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [innerParame setObject:aa forKey:@"version"];
    [innerParame setObject:@"iphone" forKey:@"os"];
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.f", a];
    [innerParame setObject:timeString forKey:@"timestamp"];
    
    return innerParame;
    
}

+ (NSString *)urlSign:(NSDictionary * )dict{
    NSArray * arr = [dict allKeys];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [[obj1 lowercaseString] compare:[obj2 lowercaseString]] == NSOrderedDescending;
    }];
    NSMutableString * signCap = [[NSMutableString alloc] init];
    //进行asign拼接
    
    for (NSString * dicKey in arr) {
        
        if ([dict objectForKey:dicKey]) {
            NSString *str = [NSString stringWithFormat:@"%@", [dict objectForKey:dicKey]];
            if (str.length == 0) {
                continue;
            }else {
                [signCap appendString:[NSString stringWithFormat:@"%@=%@&",[dicKey lowercaseString] ,[dict objectForKey:dicKey]]];
            }
        }
    }
    LWLog(@"%@",signCap);
    NSString * aa = [signCap substringToIndex:signCap.length-1];
    NSString * cc  = [NSString stringWithFormat:@"%@%@",aa,MainUrlScreate];
    return [NSString stringWithFormat:@"%@&sign=%@",aa,[self md5by32:cc]];

    
    
}


+ (NSMutableDictionary *) AsignLibraryWithNecessaryParame:(NSDictionary *)parame{
    
    NSMutableDictionary * innerParame = [self AsignLibraryAdditionParame:parame];
   
    
    NSArray * arr = [innerParame allKeys];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
        return [[obj1 lowercaseString] compare:[obj2 lowercaseString]] == NSOrderedDescending;
    }];
    NSMutableString * signCap = [[NSMutableString alloc] init];
    //进行asign拼接
    
    for (NSString * dicKey in arr) {
        
        if ([innerParame objectForKey:dicKey]) {
            NSString *str = [NSString stringWithFormat:@"%@", [innerParame objectForKey:dicKey]];
            if (str.length == 0) {
                continue;
            }else {
                [signCap appendString:[NSString stringWithFormat:@"%@=%@&",[dicKey lowercaseString] ,[innerParame objectForKey:dicKey]]];
            }
        }
    }
    LWLog(@"%@",signCap);
    NSString * aa = [signCap substringToIndex:signCap.length-1];
    NSString * cc  = [NSString stringWithFormat:@"%@%@",aa,MainUrlScreate];
//    NSString *unicodeStr = [NSString stringWithCString:[cc  UTF8String] encoding:NSUTF8StringEncoding];
    [innerParame setObject:[self md5by32:cc] forKey:@"sign"];
    LWLog(@"%@",innerParame);
    return innerParame;
}


//md5加密-32位 (小写)
+ (NSString *)md5by32:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

//md5 16位加密 （大写）
- (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}




@end
