//
//  AsignLibrary.h
//  AsignLibrary
//
//  Created by lhb on 16/7/11.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface AsignLibrary : NSObject
/**
 *  签名通过字典通过键从小到大排序，key1=value1&key2=value2+Screat
 *
 *  @param parame 必要参数
 *
 *  @return sign
 */
+ (NSMutableDictionary *) AsignLibraryWithNecessaryParame:(NSDictionary *)parame;

//md5加密-32位 (小写)
+ (NSString *)md5by32:(NSString*)input;



+ (NSString *)urlSign:(NSDictionary * )dict;


@end
