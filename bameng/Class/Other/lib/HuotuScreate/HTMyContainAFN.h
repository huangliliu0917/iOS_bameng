//
//  HTMyContainAFN.h
//  123-213
//
//  Created by lhb on 16/3/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HTMyContainAFN : NSObject



+ (void)AFN:(NSString * )url with:(NSMutableDictionary *)parames Success:(void (^)(id  responseObject))success failure:(void (^)(NSError *  error))failure;


@end
