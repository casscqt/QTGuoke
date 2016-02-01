//
//  QTCommentViewController.m
//  QTGuoke
//
//  Created by Cass on 16/1/20.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTCommentViewController.h"
#import "QTComment.h"
#import "QTCommentViewCell.h"

float heightText;
float currentLineNum=1;
CGFloat currentHeight=40;

@interface QTCommentViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *commentArr;
@property (nonatomic,copy) NSString *id;

@property (nonatomic,strong) UIView *commentView;
@property (nonatomic,strong) UITextView *commentTextField;



@end

@implementation QTCommentViewController

- (instancetype)initWithId:(NSString *)Id
{
    self = [super init];
    if (self) {
        self.id = Id;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:20.0]};
    CGSize contentSize=[@"我" sizeWithAttributes:dict];
    heightText=contentSize.height;
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.frame = CGRectMake(0, 0, KScreenSize.width, KScreenSize.height-50);
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.view addSubview:self.tableView];

    // 注册cell
    [self.tableView registerClass:[QTCommentViewCell class] forCellReuseIdentifier:@"commentCell"];
    
    [self setUpNavigationItem];

    [self setUpCommentView];
    [self setUpBottomView];
    
    [self sendRequest];
    
    
    //注册监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}



- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat transformY = keyboardFrame.origin.y - self.view.frame.size.height ;
    
    [UIView animateWithDuration:duration animations:^{
        self.commentView.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
    

//    NSLog(@"%@",note);
}


-(void)dealloc
{
//    [NSNotificationCenter defaultCenter]re
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



#pragma mark -请求
//http://apis.guokr.com/handpick/reply.json?article_id=17179

//初次请求
- (void)sendRequest
{

    
    //1.创建请求者
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    //2.创建一个字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"article_id"] = self.id;

    
    //4.发送请求
    [manger GET:@"http://apis.guokr.com/handpick/reply.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *commentArr = [NSArray array];
        commentArr = [QTComment mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        self.commentArr = commentArr;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}




#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QTCommentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    
    cell.comment = self.commentArr[indexPath.row];

    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



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
    
    [commentBtn addTarget:self action:@selector(pushCommentView) forControlEvents:UIControlEventTouchDown];
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




#pragma mark - textView
-(void)textViewDidChange:(UITextView *)textView
{

    CGFloat newHeight = self.commentTextField.contentSize.height;
    
    
    if (currentHeight > 100) {
        return;
    }
    
    if(currentHeight < newHeight ){
        //如果发现当前文字长度对应的行数超过。 文本框高度，则先调整当前view的高度和位置，然后调整输入框的高度，最后修改currentLineNum的值
        self.commentView.frame = CGRectMake(self.commentView.frame.origin.x, self.commentView.frame.origin.y-(newHeight - currentHeight), self.commentView.frame.size.width, self.commentView.frame.size.height+(newHeight - currentHeight));
        textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, textView.frame.size.height+(newHeight - currentHeight));
        currentHeight = newHeight;
    }else if (currentHeight > newHeight ){
        //次数为删除的时候检测文字行数减少的时候
        self.commentView.frame = CGRectMake(self.commentView.frame.origin.x, self.commentView.frame.origin.y+(currentHeight-newHeight), self.commentView.frame.size.width, self.commentView.frame.size.height-(currentHeight-newHeight));
        textView.frame = CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, textView.frame.size.height-(currentHeight-newHeight));
        currentHeight = newHeight;
    }
    
}






- (void)pushCommentView
{
    [self.commentTextField becomeFirstResponder];
}


- (void)setUpCommentView
{
    UIView *commentView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenSize.height -50, KScreenSize.width, 50)];
    commentView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];

    UITextView *commentTextField = [[UITextView alloc]init];
    UIButton *commentBtn = [[UIButton alloc]init];
    commentTextField.backgroundColor = [UIColor greenColor];
    commentTextField.delegate = self;
    commentTextField.scrollEnabled = YES;
    commentTextField.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    commentTextField.backgroundColor = [UIColor grayColor];
    commentTextField.font = [UIFont systemFontOfSize:20];
    commentBtn.backgroundColor = [UIColor redColor];
    [commentView addSubview:commentTextField];
    [commentView addSubview:commentBtn];
    self.commentTextField = commentTextField;
    

    self.commentView = commentView;
    [self.view addSubview:commentView];
    
    //commmentLabel
    [commentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commentView);
        make.left.equalTo(commentView.mas_left).with.offset(10);
        make.right.equalTo(commentBtn.mas_left).with.offset(-10);
        make.top.equalTo(commentView).with.offset(10);
        make.bottom.equalTo(commentView).with.offset(-10);
    }];
    
    //commentBtn
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(commentView);
        make.right.equalTo(commentView).with.offset(-10);
        make.width.equalTo(@60);
        make.top.equalTo(commentTextField);
        make.bottom.equalTo(commentTextField);
    }];
    
//    [commentBtn addTarget:self action:@selector(pushCommentView) forControlEvents:UIControlEventTouchDown];
    [commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    commentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [commentBtn setTitle:@"发表" forState:UIControlStateNormal];

}


#pragma mark -设置默认空图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *nullView = [[UIView alloc]init];
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



    return nullView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.commentArr.count == 0) {
        self.tableView.bounces = NO;
        return KScreenSize.height -64 -50;
    }else{
        self.tableView.bounces = YES;
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
