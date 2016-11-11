//
//  MyCoreLocation.h
//  bameng
//
//  Created by lhb on 16/11/11.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyCoreLocationDelegate <NSObject>


- (void) MyCoreLocationTakeBackCity:(NSString *)city;


@end

@interface MyCoreLocation : NSObject

+(instancetype)MyCoreLocationShare;

- (void)MyCoreLocationStartLocal;

- (void)MyCoreLocationStopLocal;


@property(nonatomic,weak) id <MyCoreLocationDelegate> delegate;


@end
