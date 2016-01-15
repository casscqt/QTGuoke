//
//  QTGuoKeViewController.m
//  QTGuoke
//
//  Created by Cass on 15/12/8.
//  Copyright © 2015年 Cass. All rights reserved.
//

#import "QTGuoKeViewController.h"
#import "QTGuoKeCell.h"
#import "QTIntro.h"
#import "QTGuokeArticleViewController.h"


#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"

@interface QTGuoKeViewController ()

@property (nonatomic,strong) NSMutableArray *introFArr;
@property (nonatomic,strong) NSMutableArray *hArr;
@property (nonatomic,strong) UIWebView *webview;

@property (nonatomic,copy) NSString *since;

@end

@implementation QTGuoKeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"果壳精选";
    // 初始化布局
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.minimumColumnSpacing    = 10;  // cell之间的水平间距
    layout.minimumInteritemSpacing = 10;  // cell之间的垂直间距
    // 初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                         collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource       = self;
    _collectionView.delegate         = self;
    _collectionView.backgroundColor  = [UIColor colorWithRed:242.0/255 green:242.0/255 blue:242.0/255 alpha:1];
    // 注册cell
    [_collectionView registerClass:[QTGuoKeCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER];
    
    [self.view addSubview:self.collectionView];
    [self sendRequest];
    
    [self setUpNavigationBarItem];
    
    
    //上拉加载更多
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRequest)];

   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


//初次请求
- (void)sendRequest
{
    //初始化参数变量
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    long long dTime = [[NSNumber numberWithDouble:timeInterval] longLongValue]; // 将double转为long long型
    NSString *tempTime = [NSString stringWithFormat:@"%llu",dTime]; // 输出long long型

    
    //1.创建请求者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //2.创建一个字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"retrieve_type"] = @"by_since";
    params[@"since"] = tempTime;
    params[@"orientation"] = @"before";
    params[@"category"] = @"all";
    params[@"ad"] = @"1";
    
    //4.发送请求
    [manger GET:@"http://apis.guokr.com/handpick/article.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
                NSArray *introArr = [NSArray array];
                introArr = [QTIntro mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
                for (QTIntro *intro in introArr) {
                    QTIntroFrame *introF = [[QTIntroFrame alloc]init];
                    introF.intro = intro;
                    [self.introFArr addObject:introF];
                }
                
                [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    

}

//加载更多  http://apis.guokr.com/handpick/article.json?retrieve_type=by_since&since=1451988005&orientation=before
- (void)loadMoreRequest
{
    //1.创建请求者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //2.创建一个字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    QTIntroFrame *introF = [self.introFArr lastObject];
    self.since = introF.intro.date_picked;

    params[@"retrieve_type"] = @"by_since";
    params[@"since"] = self.since;
    params[@"orientation"] = @"before";
    //4.发送请求
    [manger GET:@"http://apis.guokr.com/handpick/article.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSArray *introArr = [NSArray array];
                introArr = [QTIntro mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
                QTIntroFrame *introF = [self.introFArr lastObject];
                self.since = introF.intro.date_picked;
        
                for (QTIntro *intro in introArr) {
                    QTIntroFrame *introF = [[QTIntroFrame alloc]init];
                    introF.intro = intro;
                    [self.introFArr addObject:introF];
                }
        
                [self.collectionView reloadData];
                [self.collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _introFArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QTGuoKeCell *cell =
    (QTGuoKeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];

    cell.introF = self.introFArr[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    QTIntroFrame *introF = self.introFArr[indexPath.row];
    QTIntro *intro = introF.intro;
    QTGuokeArticleViewController *articleVc = [[QTGuokeArticleViewController alloc]initWithUrl:intro.link_v2];
    [self.navigationController pushViewController:articleVc animated:YES];

}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    QTIntroFrame *introF = self.introFArr[indexPath.row];

    return introF.cellSize;
}



#pragma mark - getter

- (NSMutableArray *)introFArr
{
    if (!_introFArr) {
        _introFArr = [NSMutableArray array];
    }
    return _introFArr;
}

- (NSMutableArray *)hArr
{
    if (!_hArr) {
        _hArr = [NSMutableArray array];
        for (QTIntroFrame *introF in self.introFArr) {
            NSString *height = [NSString stringWithFormat:@"%f",introF.cellSize.height];
            [_hArr addObject:height];
        }
    }
    return _hArr;

}

- (NSString *)since
{
    if (!_since) {
        _since = [[NSString alloc]init];
    }
    return _since;
}


@end
