//
//  QTDBTool.h
//  QTGuoke
//
//  Created by Cass on 16/1/16.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QTArticle;
@interface QTDBTool : NSObject
+ (instancetype)shareDB;

- (BOOL)isExistArticleWithId:(NSString *)article_id;
- (void)likeArticle:(QTArticle *)article;
- (void)unlikeArticle:(QTArticle *)article;
@end
