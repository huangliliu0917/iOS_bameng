//
//  HTMyContainAFN.m
//  123-213
//
//  Created by lhb on 16/3/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "HTMyContainAFN.h"
#import "AsignLibrary.h"


@implementation HTMyContainAFN




+ (void)AFN:(NSString  * )url with:(NSMutableDictionary *)parames Success:(void (^)(id   responseObject))success failure:(void (^)(NSError *  error))failure{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    NSString * token = [[NSUserDefaults standardUserDefaults] stringForKey:AppToken];
    [manager.requestSerializer setValue:token?[NSString stringWithFormat:@"Bearer %@",token]:@"" forHTTPHeaderField:@"Authorization"];
    
    NSMutableDictionary * parame = [AsignLibrary AsignLibraryWithNecessaryParame:parames];
    

    [manager POST:[NSString stringWithFormat:@"%@%@", MainUrl ,url] parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
    }];
    
}

@end
