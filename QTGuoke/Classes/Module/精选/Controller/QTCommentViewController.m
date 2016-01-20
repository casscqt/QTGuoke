//
//  QTCommentViewController.m
//  QTGuoke
//
//  Created by Cass on 16/1/20.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTCommentViewController.h"
#import "QTComment.h"

@interface QTCommentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *commentArr;

@end

@implementation QTCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setUpNavigationItem];
    [self setUpBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpNavigationItem
{
    self.title = @"评论页面";
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back_press"] forState:UIControlStateHighlighted];
    backBtn.frame = CGRectMake(0, 0, 22, 24);
    [backBtn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)pushBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

#pragma mark -底部评论条
- (void)setUpBottomView
{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenSize.height-50, KScreenSize.width, 50)];
    footView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    
    UIButton *commentBtn = [[UIButton alloc]init];
    [footView addSubview:commentBtn];
    [self.view addSubview:footView];
    //commentBtn
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footView);
        make.left.equalTo(footView.mas_left).with.offset(10);
        make.right.equalTo(footView.mas_right).with.offset(-10);
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
}

#pragma mark -设置默认空图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *nullView = [[UIView alloc]initWithFrame:self.view.frame];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"comment_sofa"]];
    UILabel *label = [[UILabel alloc]init];
    
    [nullView addSubview:imageView];
    [nullView addSubview:label];
    
    label.text = @"暂时没有评论，快去抢沙发吧!";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(nullView);
        make.centerY.equalTo(nullView);
    }];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom);
        make.centerX.equalTo(nullView);
        make.height.equalTo(@30);
        
    }];
    nullView.backgroundColor = [UIColor greenColor];
    self.tableView.bounces = NO;

    return nullView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.commentArr.count == 0) {
        return KScreenSize.height -64;
    }else{
        return 0;
    }
}



-(NSArray *)commentArr
{
    if (!_commentArr) {
        _commentArr = [NSArray array];
    }
    return _commentArr;
}


@end
