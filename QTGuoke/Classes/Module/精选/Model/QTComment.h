//
//  QTComment.h
//  QTGuoke
//
//  Created by Cass on 16/1/21.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTComment : NSObject
//author
@property (nonatomic,copy) NSDictionary *author;
//时间
@property (nonatomic,copy) NSString *date_created;
//楼层
@property (nonatomic,copy) NSString *floor;
//评论内容
@property (nonatomic,copy) NSString *content;
//id
@property (nonatomic,copy) NSString *id;
@end
