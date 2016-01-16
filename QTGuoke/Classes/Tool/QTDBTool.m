//
//  QTDBTool.m
//  QTGuoke
//
//  Created by Cass on 16/1/16.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTDBTool.h"
#import "QTArticle.h"

@interface QTDBTool()
@property (nonatomic,strong) FMDatabase *dataBase;
@end



@implementation QTDBTool
static QTDBTool *dbTool = nil;


#pragma mark - 创建单例
+ (instancetype)shareDB
{

    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        dbTool = [[QTDBTool alloc]init];
    });
    return dbTool;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self createDB];
    }
    return self;
}

#pragma mark - 创建数据库
- (void)createDB
{

    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [docDir stringByAppendingPathComponent:@"db_guoke.sqlite"];
    
    self.dataBase = [FMDatabase databaseWithPath:dbPath];
    if ([_dataBase open]) {
        NSLog(@"数据创建打开成功...");
        [self createTable];
    }else{
        NSLog(@"数据打开失败");
    }
}

#pragma mark - 创建数据库表
- (void)createTable
{
    //收藏表
    NSString *createLikeSQL = @"create table if not exists article_like (id integer primary key autoincrement,article_id text,title text,source_name text,summary text,date_picked text)";
    if ([_dataBase executeUpdate:createLikeSQL]) {
        NSLog(@"成功创建收藏表article_like");
    }else{
        NSLog(@"失败创建收藏表article_like");
    }
}

#pragma mark - 插入数据和删除数据
- (void)likeArticle:(QTArticle *)article
{
    NSString *insertSQL = @"insert into article_like (article_id, title, source_name, summary, date_picked) values (?, ?, ?, ?, ?)";
    if ([_dataBase executeUpdate:insertSQL, article.id, article.title, article.source_name, article.summary, article.date_picked]) {
        NSLog(@"成功添加收藏");
    }else{
        NSLog(@"失败添加收藏");
    }
}

- (void)unlikeArticle:(QTArticle *)article
{
    NSString * deleteSQL = @"delete from article_like where article_id = ?";
    if ([_dataBase executeUpdate:deleteSQL, article.id]) {
        NSLog(@"成功取消收藏");
    }else{
        NSLog(@"失败取消收藏");
    }
}

#pragma mark -查询数据
- (BOOL)isExistArticleWithId:(NSString *)article_id
{
    NSString * querySQL = @"select * from article_like where article_id = ?";

    return [[_dataBase executeQuery:querySQL,article_id]next];
}

@end
