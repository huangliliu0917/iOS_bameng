//
//  LiuXSegmentView.m
//  LiuXSegment
//
//  Created by 刘鑫 on 16/3/18.
//  Copyright © 2016年 liuxin. All rights reserved.
//

#define windowContentWidth  ([[UIScreen mainScreen] bounds].size.width)
#define SFQRedColor [UIColor colorWithRed:255/255.0 green:92/255.0 blue:79/255.0 alpha:1]
#define MAX_TitleNumInWindow 5

#import "LiuXSegmentView.h"

@interface LiuXSegmentView()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) UIButton *titleBtn;
@property (nonatomic,strong) UIScrollView *bgScrollView;
@property (nonatomic,strong) UIView *selectLine;
@property (nonatomic,assign) CGFloat btn_w;


@property (nonatomic,strong) NSArray *titlesData;
@end

@implementation LiuXSegmentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


//-(instancetype)initWithFrame:(CGRect)frame titlesData:(NSArray *)titlesData clickBlick:(btnClickBlock)block{
//    
//    self = [super initWithFrame:frame];
//    if (self) {
//        _btn_w=0.0;
//        if (titlesData.count<MAX_TitleNumInWindow+1) {//5
//            _btn_w=windowContentWidth/titlesData.count;
//        }else{
//            _btn_w=windowContentWidth/MAX_TitleNumInWindow;
//        }
//        _titlesData = titlesData;
//        _defaultIndex=1;
//        _titleFont=[UIFont systemFontOfSize:15];
//        _btns=[[NSMutableArray alloc] initWithCapacity:0];
//        _titleNomalColor=[UIColor blackColor];
//        _titleSelectColor=SFQRedColor;
//        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height)];
//        _bgScrollView.backgroundColor=[UIColor whiteColor];
//        _bgScrollView.showsHorizontalScrollIndicator=NO;
//        _bgScrollView.contentSize=CGSizeMake(_btn_w * titlesData.count, 0);
//        [self addSubview:_bgScrollView];
//        
//        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, _btn_w * titlesData.count, 1)];
//        line.backgroundColor=[UIColor lightGrayColor];
//        [_bgScrollView addSubview:line];
//        
//        _selectLine=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, _btn_w, 2)];
//        _selectLine.backgroundColor=_titleSelectColor;
//        [_bgScrollView addSubview:_selectLine];
//        
//        for (int i=0; i < titlesData.count; i++) {
//            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//            btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, self.frame.size.height-2);
//            btn.tag=i+1;
//            
//            NSDictionary *dict = titlesData[i];
//            [btn setTitle:[dict objectForKey:@"name"] forState:UIControlStateNormal];
//            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
//            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
//            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
//            [btn setBackgroundColor:[UIColor whiteColor]];
//            btn.titleLabel.font=_titleFont;
//            [_bgScrollView addSubview:btn];
//            [_btns addObject:btn];
//            if (i==0) {
//                _titleBtn=btn;
//                btn.selected=YES;
//            }
//            self.block=block;
//            
//        }
//    }
//    
//    return self;
//}


-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titleArray clickBlick:(btnClickBlock)block{
    self = [super initWithFrame:frame];
    if (self) {
        _btn_w=0.0;
        if (titleArray.count<MAX_TitleNumInWindow+1) {//5
            _btn_w=windowContentWidth/titleArray.count;
        }else{
            _btn_w=windowContentWidth/MAX_TitleNumInWindow;
        }
        _titles=titleArray;
        _defaultIndex=1;
        _titleFont=[UIFont systemFontOfSize:15];
        _btns=[[NSMutableArray alloc] initWithCapacity:0];
        _titleNomalColor = [UIColor blackColor];
        _titleSelectColor = SFQRedColor;
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, windowContentWidth, self.frame.size.height)];
        _bgScrollView.backgroundColor=[UIColor whiteColor];
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.contentSize=CGSizeMake(_btn_w*titleArray.count, 0);
        [self addSubview:_bgScrollView];
        
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.7, _btn_w*titleArray.count, 0.7)];
        line.backgroundColor=LWColor(228, 228, 228);
        [_bgScrollView addSubview:line];
        
        _selectLine=[[UIView alloc] initWithFrame:CGRectMake(_btn_w * 0.4 * 0.5, self.frame.size.height-2, _btn_w * 0.6, 2)];
        _selectLine.backgroundColor=_titleSelectColor;
        [_bgScrollView addSubview:_selectLine];
        
        for (int i=0; i<titleArray.count; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(_btn_w*i, 0, _btn_w, self.frame.size.height-2);
            btn.tag=i+1;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
            [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            [btn setBackgroundColor:[UIColor whiteColor]];
            btn.titleLabel.font=_titleFont;
            [_bgScrollView addSubview:btn];
            [_btns addObject:btn];
            if (i==0) {
                _titleBtn=btn;
                btn.selected=YES;
            }
            
            self.block=block;
            
        }
    }
    
    return self;
}

-(void)btnClick:(UIButton *)btn{
    
    if (self.block) {
        self.block(btn.tag);
    }
    
    if (btn.tag==_defaultIndex) {
        return;
    }else{
        
        
        _titleBtn.selected=!_titleBtn.selected;
        [_titleBtn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        _titleBtn=btn;
        _titleBtn.selected=YES;
        [_titleBtn setTitleColor:_titleSelectColor forState:UIControlStateNormal];
        _defaultIndex=btn.tag;
    }
    
    //计算偏移量
    CGFloat offsetX=btn.frame.origin.x - 2*_btn_w;
    if (offsetX<0) {
        offsetX=0;
    }
    CGFloat maxOffsetX= _bgScrollView.contentSize.width-windowContentWidth;
    if (offsetX>maxOffsetX) {
        offsetX=maxOffsetX;
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        [_bgScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        _selectLine.frame=CGRectMake(btn.frame.origin.x + _btn_w * 0.4 * 0.5, self.frame.size.height-2, btn.frame.size.width * 0.6, 2);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void) btnSlideToCurrentPageWithIndex:(NSUInteger)index{
    
    UIButton * btn = [self.btns objectAtIndex:index];
    [self btnClick:btn];
    
}

-(void)setTitleNomalColor:(UIColor *)titleNomalColor{
    _titleNomalColor=titleNomalColor;
    [self updateView];
}

-(void)setTitleSelectColor:(UIColor *)titleSelectColor{
    _titleSelectColor=titleSelectColor;
    [self updateView];
}

-(void)setTitleFont:(UIFont *)titleFont{
    _titleFont=titleFont;
    [self updateView];
}

-(void)setDefaultIndex:(NSInteger)defaultIndex{
    _defaultIndex=defaultIndex;
    [self updateView];
}

-(void)updateView{
    for (UIButton *btn in _btns) {
        [btn setTitleColor:_titleNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectColor forState:UIControlStateSelected];
        btn.titleLabel.font=_titleFont;
        _selectLine.backgroundColor=_titleSelectColor;
        
        if (btn.tag-1==_defaultIndex-1) {
            _titleBtn=btn;
            btn.selected=YES;
        }else{
            btn.selected=NO;
        }
    }
}

@end
