//
//  SelectObjectViewController.h
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SelectObjectDelegate <NSObject>

@optional

- (void)selectMengYou:(NSString *) mengYouId;

@end


@interface SelectObjectViewController : UIViewController

@property (retain, nonatomic) id <SelectObjectDelegate>delegate;

@end
