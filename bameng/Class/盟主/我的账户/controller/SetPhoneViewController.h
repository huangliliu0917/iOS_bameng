//
//  SetPhoneViewController.h
//  bameng
//
//  Created by lhb on 16/11/23.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyViewController.h"


@protocol SetPhoneViewControllerDelegate <NSObject>

- (void)savePhoneNumber:(NSString *)phome;


@end


@interface SetPhoneViewController : MyViewController


@property(nonatomic,weak) id <SetPhoneViewControllerDelegate> delegate;

@end
