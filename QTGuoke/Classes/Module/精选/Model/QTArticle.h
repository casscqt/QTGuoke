//
//  QTArticle.h
//  QTGuoke
//
//  Created by Cass on 16/1/16.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QTArticle : NSObject
//title
@property (nonatomic,copy) NSString *title;
//summary
@property (nonatomic,copy) NSString *summary;
//source_name
@property (nonatomic,copy) NSString *source_name;
//date_picked
@property (nonatomic,copy) NSString *date_picked;
//id
@property (nonatomic,copy) NSString *id;
@end
