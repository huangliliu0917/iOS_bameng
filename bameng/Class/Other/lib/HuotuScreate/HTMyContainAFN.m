//
//  HTMyContainAFN.m
//  123-213
//
//  Created by lhb on 16/3/24.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "HTMyContainAFN.h"
#import "AsignLibrary.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "MainNavViewController.h"

@implementation HTMyContainAFN




+ (void)AFN:(NSString  * )url with:(NSMutableDictionary *)parames Success:(void (^)(NSDictionary   *responseObject))success failure:(void (^)(NSError *  error))failure{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:AppToken];
    [manager.requestSerializer setValue:token?token:@"" forHTTPHeaderField:@"Authorization"];
    
    NSMutableDictionary * parame = [AsignLibrary AsignLibraryWithNecessaryParame:parames];
    

    [manager POST:[NSString stringWithFormat:@"%@%@", MainUrl ,url] parameters:parame progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        
        if([responseObject[@"status"] intValue] == 200){
            success(responseObject);
        }else if([responseObject[@"status"] intValue] == 70035){

            [self showLogginOut:responseObject[@"statusText"]];
        }else{
            [MBProgressHUD showError:responseObject[@"statusText"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failure(error);
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
    
}

+ (void)showLogginOut:(NSString *)tip{
    
    AppDelegate * appde = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"帐号异常" message:tip preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ac = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginController *login = [story instantiateViewControllerWithIdentifier:@"LoginController"];
        MainNavViewController * nav = [[MainNavViewController alloc] initWithRootViewController:login];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    }];
    [alertVC addAction:ac];
    [appde.currentVc presentViewController:alertVC animated:YES completion:nil];
}

+ (void)AFNUpLoadImage:(NSString * )url with:(NSMutableDictionary *)parames andImage:(UIImage *)pic Success:(void (^)(NSDictionary  *responseObject))success failure:(void (^)(NSError *  error))failure{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:AppToken];
    [manager.requestSerializer setValue:token?token:@"" forHTTPHeaderField:@"Authorization"];
    NSData *imageData =UIImageJPEGRepresentation(pic,1);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =@"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    
    NSMutableDictionary * parame = [AsignLibrary AsignLibraryWithNecessaryParame:parames];
    [manager POST:[NSString stringWithFormat:@"%@%@", MainUrl ,url] parameters:parame constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"status"] intValue] == 200){
            success(responseObject);
        }else if([responseObject[@"status"] intValue] == 70035){
            
            [self showLogginOut:responseObject[@"statusText"]];
        }else{
            [MBProgressHUD showError:responseObject[@"statusText"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [MBProgressHUD showError:@"服务器开小差了"];
    }];
    
}

@end
