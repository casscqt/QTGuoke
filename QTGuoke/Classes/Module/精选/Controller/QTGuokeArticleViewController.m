//
//  QTGuokeArticleViewController.m
//  QTGuoke
//
//  Created by Cass on 16/1/14.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTGuokeArticleViewController.h"

@interface QTGuokeArticleViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) NSString *url;
@end

@implementation QTGuokeArticleViewController

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setChildView];
    
    [self setUpNavigationBarItems];
    


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


#pragma mark -按钮响应
- (void)pushBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)pushToCommentVc
{

}

- (void)setChildView
{
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, KScreenSize.width, KScreenSize.height-50)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.view addSubview:webview];
    [webview loadRequest:request];
    
    
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenSize.height-50, KScreenSize.width, 50)];
    footView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];

    
    UIButton *commentBtn = [[UIButton alloc]init];
    UIButton *shareBtn = [[UIButton alloc]init];
    UIButton *likeBtn = [[UIButton alloc]init];

    [footView addSubview:commentBtn];
    [footView addSubview:likeBtn];
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
        make.right.equalTo(likeBtn.mas_left).with.offset(-15);

    }];
    [shareBtn setImage:[UIImage imageNamed:@"article_btn_share"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"article_btn_share_press"] forState:UIControlStateHighlighted];
    
    //likeBtn
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.right.equalTo(footView).with.offset(-15);

    }];
    [likeBtn setImage:[UIImage imageNamed:@"article_btn_like"] forState:UIControlStateNormal];
    [likeBtn setImage:[UIImage imageNamed:@"article_btn_like_press"] forState:UIControlStateHighlighted];
    
    


    
}

@end
