//
//  QTGuokeArticleViewController.m
//  QTGuoke
//
//  Created by Cass on 16/1/14.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTGuokeArticleViewController.h"
#import "QTArticle.h"

@interface QTGuokeArticleViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic,copy) NSString *id;
@property (nonatomic,strong) UIButton *likeBtn;
@property (nonatomic,strong) QTArticle *article;

@end

@implementation QTGuokeArticleViewController

- (instancetype)initWithId:(NSString *)id
{
    self = [super init];
    if (self) {
        self.id = id;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self checkLikeBtnStatus];
    
    [self setChildView];
    
    [self setUpNavigationBarItems];
    
    [self getArticleInfo];

}


#pragma mark
- (void)getArticleInfo
{
    //1.创建请求者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //2.创建一个字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"pick_id"] = self.id;

    //4.发送请求
    [manger GET:@"http://apis.guokr.com/handpick/article.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *resultArr = [NSArray array];
        resultArr = [QTArticle mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        self.article = [resultArr lastObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    

}


- (void)checkLikeBtnStatus
{
    if ([[QTDBTool shareDB] isExistArticleWithId:self.id]) {
        self.likeBtn.selected = YES;
    }else{
        self.likeBtn.selected = NO;
    }
}

- (void)setUpNavigationBarItems
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back_press"] forState:UIControlStateHighlighted];
    backBtn.frame = CGRectMake(0, 0, 22, 24);
    [backBtn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"article_nav_review"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"article_nav_review_press"] forState:UIControlStateHighlighted];
    rightBtn.frame = CGRectMake(0, 0, 20, 18);
    [rightBtn addTarget:self action:@selector(pushToCommentVc) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    static float lastOffY  = 0;
    float curOffY = scrollView.contentOffset.y;
    
    if (scrollView.frame.size.height >= scrollView.contentSize.height ||     //内容高度低于scrollView高度，不隐藏
        fabs(curOffY)  +KScreenSize.height> scrollView.contentSize.height || //拉至最底部时，不做处理
        curOffY < 0                                                          //拉至最顶部时，不做处理
        )
    {
        return;
    }
    if (curOffY - lastOffY > 40)
    {
        //向上
        lastOffY = curOffY;
        self.navigationController.navigationBar.hidden = YES;
        
    }
    else if(lastOffY -curOffY >40)
    {
        //向下
        lastOffY = curOffY;
        self.navigationController.navigationBar.hidden = NO;
    }
}




#pragma mark -按钮响应
- (void)pushBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)pushToCommentVc
{

}


- (void)touchLikeBtn
{
    self.likeBtn.selected = !self.likeBtn.selected;
    
    if (self.likeBtn.selected) {
        [[QTDBTool shareDB] likeArticle:self.article];
    }else{
        [[QTDBTool shareDB] unlikeArticle:self.article];
    }
}

- (void)setChildView
{
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenSize.width, KScreenSize.height-50)];
    NSString *urlString = [NSString stringWithFormat:@"http://jingxuan.guokr.com/pick/v2/%@",self.id];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    webview.delegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    [webview loadRequest:request];
    
    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenSize.height-50, KScreenSize.width, 50)];
    footView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];

    
    UIButton *commentBtn = [[UIButton alloc]init];
    UIButton *shareBtn = [[UIButton alloc]init];


    [footView addSubview:commentBtn];
    [footView addSubview:self.likeBtn];
    [footView addSubview:shareBtn];
    [self.view addSubview:footView];
    //commentBtn
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.left.equalTo(footView.mas_left).with.offset(10);
        make.right.equalTo(shareBtn.mas_left).with.offset(-15);
        make.top.equalTo(footView).with.offset(5);
        make.bottom.equalTo(footView).with.offset(-5);

    }];
    
    [commentBtn setAdjustsImageWhenHighlighted:NO];
    [commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [commentBtn setTitle:@"写评论" forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [commentBtn setImage:[UIImage imageNamed:@"article_btn_review"] forState:UIControlStateNormal];
    [commentBtn setImage:[UIImage imageNamed:@"article_btn_review_press"] forState:UIControlStateHighlighted];
    UIImage *image2 = [UIImage imageNamed:@"comment_btn_send_disabled"];
    image2 = [image2 stretchableImageWithLeftCapWidth:floorf(image2.size.width/2) topCapHeight:floorf(image2.size.height/2)];
    [commentBtn setBackgroundImage:image2 forState:UIControlStateNormal];
    
    //forwardBtn
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.right.equalTo(self.likeBtn.mas_left).with.offset(-15);

    }];
    [shareBtn setImage:[UIImage imageNamed:@"article_btn_share"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"article_btn_share_press"] forState:UIControlStateSelected];
    
    //likeBtn
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.right.equalTo(footView).with.offset(-15);

    }];
    [self.likeBtn addTarget:self action:@selector(touchLikeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.likeBtn setImage:[UIImage imageNamed:@"article_btn_like"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"article_btn_like_press"] forState:UIControlStateSelected];
    
    


    
}


-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc]init];
    }
    return _likeBtn;

}

- (QTArticle *)article
{
    if (!_article) {
        _article = [[QTArticle alloc]init];
    }
    return _article;
}

@end
