//
//  LXActionSheet.m
//  LXActionSheetDemo
//
//  Created by lixiang on 14-3-10.
//  Copyright (c) 2014年 lcolco. All rights reserved.
//

#import "LXActionSheet.h"
#import "pickView.h"
#import "TZImagePickerController.h"
#import "SaveCanclePickView.h"
#import "SexPick.h"
#import "turnView.h"

#define CANCEL_BUTTON_COLOR                     [UIColor colorWithRed:53/255.00f green:53/255.00f blue:53/255.00f alpha:1]
#define DESTRUCTIVE_BUTTON_COLOR                [UIColor colorWithRed:185/255.00f green:45/255.00f blue:39/255.00f alpha:1]
#define OTHER_BUTTON_COLOR                      [UIColor whiteColor]
#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:106/255.00f green:106/255.00f blue:106/255.00f alpha:0.8]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define CORNER_RADIUS                           5

#define BUTTON_INTERVAL_HEIGHT                  20
#define BUTTON_HEIGHT                           40
#define BUTTON_INTERVAL_WIDTH                   30
#define BUTTON_WIDTH                            260
#define BUTTONTITLE_FONT                        [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
#define BUTTON_BORDER_WIDTH                     0.5f
#define BUTTON_BORDER_COLOR                     [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8].CGColor


#define TITLE_INTERVAL_HEIGHT                   15
#define TITLE_HEIGHT                            35
#define TITLE_INTERVAL_WIDTH                    30
#define TITLE_WIDTH                             260
#define TITLE_FONT                              [UIFont fontWithName:@"Helvetica-Bold" size:14]
#define SHADOW_OFFSET                           CGSizeMake(0, 0.8f)
#define TITLE_NUMBER_LINES                      2

#define ANIMATE_DURATION                        0.25f

@interface LXActionSheet ()<pickViewDelegate,TZImagePickerControllerDelegate,SaveCanclePickViewDelegate,SexPickDelegate,turnViewDelegate>

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) NSString *actionTitle;
@property (nonatomic,assign) NSInteger postionIndexNumber;
@property (nonatomic,assign) BOOL isHadTitle;
@property (nonatomic,assign) BOOL isHadDestructionButton;
@property (nonatomic,assign) BOOL isHadOtherButton;
@property (nonatomic,assign) BOOL isHadCancelButton;
@property (nonatomic,assign) CGFloat LXActionSheetHeight;
//@property (nonatomic,assign) id<LXActionSheetDelegate>delegate;







@end

@implementation LXActionSheet

#pragma mark - Public method

- (id)initWithTitle:(int)styleType delegate:(id<LXActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
    self = [super init];
    if (self) {
    
        //初始化背景视图，添加手势
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
    
        if (delegate) {
            self.delegate = delegate;
        }
    
        [self creatButtonsWithTitle:styleType cancelButtonTitle:cancelButtonTitle destructionButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitlesArray];

    }
    return self;
}

- (void)showInView:(UIView *)view
{
    [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:self];
}

#pragma mark - CreatButtonAndTitle method

- (void)creatButtonsWithTitle:(int )styleType cancelButtonTitle:(NSString *)cancelButtonTitle destructionButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitlesArray
{
        //生成LXActionSheetView
    self.backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 160)];
    self.backGroundView.backgroundColor = [UIColor redColor];
    
    //给LXActionSheetView添加响应事件
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedBackGroundView)];
    [self.backGroundView addGestureRecognizer:tapGesture];
    
    [self addSubview:self.backGroundView];
    
    
    if (styleType == 0) {
        
        pickView * pc = [pickView pickViewShare];
        pc.delegate = self;
        [self.backGroundView addSubview:pc];
        
    }
    if (styleType == 1) {//昵称
        
        LWLog(@"%d",self.isNickName);
        SaveCanclePickView * pc = [SaveCanclePickView SaveCanclePickViewShare];
        pc.type = 1;
        pc.delegate = self;
        [self.backGroundView addSubview:pc];
        
    }
    if (styleType == 2) {//名称
        
        SaveCanclePickView * pc = [SaveCanclePickView SaveCanclePickViewShare];
        pc.type = 2;
       
        pc.delegate = self;
        [self.backGroundView addSubview:pc];
        
    }
    if (styleType == 3) {// 性别
        
        SexPick * pc = [SexPick SexPickShare];
        pc.delegate = self;
        [self.backGroundView addSubview:pc];
        
    }
    
    if(styleType == 4){ //盟主分享
        turnView * turn = [turnView shareturnView];
        turn.delegate = self;
        [self.backGroundView addSubview:turn];
    }
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-160, [UIScreen mainScreen].bounds.size.width, 160)];
    } completion:^(BOOL finished) {
    }];
}


- (void)turnClick:(int)item{
    
    [self tappedCancel];
    LWLog(@"%d",item);
    [self.delegate myorMengzhu:item];
    
}
- (void)SexPickDelegate:(NSInteger)item{
    [self tappedCancel];
    if (item!=1003) {
        if (self.sexPickItem) {
            self.sexPickItem(item);
        }
    }
}

- (void)pickViewOption:(NSInteger)item{
    [self tappedCancel];
    LWLog(@"%ld",(long)item);
    if (item == 1000 || item == 1001) {
        if (self.iconViewSelectItem) {
           self.iconViewSelectItem(item);
        }
    }
}

- (void)SaveCanclePickViewDelegate:(NSInteger)item withContent:(NSString *)content{
    [self tappedCancel];
    LWLog(@"%ld",(long)item);
    
    if (self.nickNameandNameSelectItem) {
        self.nickNameandNameSelectItem(item,content);
    }
    
}



- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)tappedBackGroundView
{
    //
}

@end
