//
//  HTMyContainAFN.h
//  123-213
//
//  Created by lhb on 16/3/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HTMyContainAFN : NSObject



+ (void)AFN:(NSString * )url with:(NSMutableDictionary *)parames Success:(void (^)(NSDictionary  *responseObject))success failure:(void (^)(NSError *  error))failure;


/*
 * 上传图片
 */
+ (void)AFNUpLoadImage:(NSString * )url with:(NSMutableDictionary *)parames andImage:(UIImage *)pic Success:(void (^)(NSDictionary  *responseObject))success failure:(void (^)(NSError *  error))failure;

@end
