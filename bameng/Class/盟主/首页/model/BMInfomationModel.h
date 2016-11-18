//
//  BMInfomationModel.h
//  bameng
//
//  Created by 刘琛 on 16/11/7.
//  Copyright © 2016年 HT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMInfomationModel : NSObject
@property (nonatomic, strong) NSString *ArticleCover;
@property (nonatomic, strong) NSNumber *ArticleId;
@property (nonatomic, strong) NSString *ArticleIntro;
@property (nonatomic, strong) NSString *ArticleTitle;
@property (nonatomic, strong) NSNumber *BrowseAmount;
@property (nonatomic, strong) NSString *PublishTime;
@property (nonatomic, strong) NSString *ArticleUrl;
@property (nonatomic, strong) NSString *PublishTimeText;

/**判断是否已读*/
@property (nonatomic, assign) BOOL IsRead;
@end
