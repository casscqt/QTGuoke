//
//  QTDBTool.h
//  QTGuoke
//
//  Created by Cass on 16/1/16.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QTIntro;
@interface QTDBTool : NSObject
+ (instancetype)shareDB;

- (BOOL)isExistArticleWithId:(NSString *)intro_id;
- (void)likeArticle:(QTIntro *)intro;
- (void)unlikeArticle:(QTIntro *)intro;
- (NSMutableArray *)readArticle;
@end
