//
//  QTGuokeCollectionController.m
//  QTGuoke
//
//  Created by Cass on 16/1/13.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTGuokeCollectionController.h"
#import "QTCollectCell.h"
#import "QTIntro.h"
#import "QTIntroFrame.h"
#import "QTGuokeArticleViewController.h"

@interface QTGuokeCollectionController ()
@property (nonatomic,strong) NSMutableArray *mutableArr;
@end

@implementation QTGuokeCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mutableArr = [[QTDBTool shareDB]readArticle];

    [self.tableView registerClass:[QTCollectCell class] forCellReuseIdentifier:@"collectCell"];
    self.title = @"我的收藏";
    [self setUpNavigationBarItem];
}

- (void)setUpNavigationBarItem
{
    //navigationItem back button
    //解决导航栏返回按钮靠右问题
    UIBarButtonItem *spaceLeftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceLeftItem.width = -15;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 50, 30);
    [btn setBackgroundImage:[UIImage imageNamed:@"nav_menuBtn"] forState:UIControlStateNormal];
    [btn  addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItems = @[spaceLeftItem,backItem];
    
}

- (void)toggleMenu
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.mutableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QTCollectCell *cell = (QTCollectCell *)[tableView dequeueReusableCellWithIdentifier:@"collectCell" forIndexPath:indexPath];

    // Configure the cell...
    cell.intro = self.mutableArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QTIntro *intro = self.mutableArr[indexPath.row];
    QTGuokeArticleViewController *articleVc = [[QTGuokeArticleViewController alloc]initWithIntro:intro];
    [self.navigationController pushViewController:articleVc animated:YES];

}



#pragma mark - getter
- (NSMutableArray *)mutableArr
{
    if (!_mutableArr) {
        _mutableArr = [NSMutableArray array];
    }
    return _mutableArr;
}

@end
