//
//  AddNewInfomationTableViewController.h
//  bameng
//
//  Created by 刘琛 on 16/10/31.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewInfomationTableViewController : MyTableViewController
@property (strong, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) IBOutlet UITextView *content;
@property (strong, nonatomic) IBOutlet UIButton *sendButton;


/**1 表示留言*/
@property (nonatomic,assign) int type;

@end
