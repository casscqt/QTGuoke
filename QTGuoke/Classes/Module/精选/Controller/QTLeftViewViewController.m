//
//  QTLeftViewViewController.m
//  QTGuoke
//
//  Created by Cass on 16/1/12.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTLeftViewViewController.h"
#import "QTLeftViewCell.h"

#import "QTGuokeCollectionController.h"

@interface QTLeftViewViewController ()<UITableViewDelegate,UITableViewDataSource,IIViewDeckControllerDelegate>
@property (nonatomic,strong) NSArray *menuTitles;
@property (nonatomic,strong) NSArray *menuImages;
@property (nonatomic,strong) NSArray *menuHightlightImages;
@property (nonatomic,strong) NSMutableArray *menuStateArray;


@end

@implementation QTLeftViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpLeftView];

    
}


//初始化leftView
- (void)setUpLeftView
{
    UITableView *leftTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    [leftTableView registerClass:[QTLeftViewCell class] forCellReuseIdentifier:@"tableCell"];
    leftTableView.backgroundColor = [UIColor colorWithRed:38.0/255 green:38.0/255 blue:38.0/255 alpha:1];
    leftTableView.separatorStyle = NO;
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    
    self.leftTableView = leftTableView;
    [self.view addSubview:leftTableView];
}




#pragma mark -tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QTLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[QTLeftViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableCell"];
    }
    [cell configCellWithTitle:self.menuTitles[indexPath.row] image:self.menuImages[indexPath.row] forState:self.menuStateArray[indexPath.row]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewDeckController toggleLeftViewAnimated:YES];
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){
        QTGuokeCollectionController *collectionVc = [[QTGuokeCollectionController alloc]init];
        collectionVc.view.backgroundColor = [UIColor greenColor];
        self.viewDeckController.centerController = nil;
        self.viewDeckController.centerController = collectionVc;
    }else if (indexPath.row == 2){
        
    
    }

    
    



    
    for (int i = 0; i < 5; i++) {
        [self.menuStateArray replaceObjectAtIndex:i withObject:@"normal"];
    }
    [self.menuStateArray replaceObjectAtIndex:indexPath.row withObject:@"highLight"];
    [self.leftTableView reloadData];

}

- (UITableView *)leftTableView{
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]init];
    }
    return _leftTableView;
}

#pragma mark - getter and setter
- (NSArray *)menuTitles
{
    if (!_menuTitles) {
        _menuTitles = [[NSArray alloc]init];
        _menuTitles = @[@"首页",@"我的收藏",@"设置",@"请吐槽",@"来个好评吧"];
    }
    return _menuTitles;
}

- (NSArray *)menuImages
{
    if (!_menuImages) {
        _menuImages = [[NSArray alloc]init];
        _menuImages = @[@"menu_home",@"menu_collection",@"menu_settings",@"menu_mail",@"menu_comments"];
    }
    return _menuImages;
}

- (NSMutableArray *)menuStateArray
{
    if (!_menuStateArray) {
        _menuStateArray = [NSMutableArray arrayWithObjects:@"highLight",@"normal",@"normal",@"normal",@"normal",nil];
    }
    return _menuStateArray;
}


@end
