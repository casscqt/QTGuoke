//
//  QTCommentViewCell.m
//  QTGuoke
//
//  Created by Cass on 16/1/21.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTCommentViewCell.h"
#import "QTComment.h"


@implementation QTCommentViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void)setComment:(QTComment *)comment
{
    _comment = comment;
    
    [self setUpchildView];
    [self setUpChildViewFrame];
    
    _nicknameLabel.text = [comment.author objectForKey:@"nickname"];
    _timeLabel.text = comment.date_created;
    _floorLabel.text = [NSString stringWithFormat:@"%@楼",comment.floor];
    _commentLabel.text = comment.content;
    
    
}

- (void)setUpchildView
{

    self.nicknameLabel.font = [UIFont systemFontOfSize:14];
    self.nicknameLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:12];
    self.timeLabel.textColor = [UIColor grayColor];
    self.floorLabel.font= [UIFont systemFontOfSize:12];
    self.floorLabel.textColor = [UIColor grayColor];
    self.floorLabel.textAlignment = NSTextAlignmentCenter;
    self.commentLabel.font = [UIFont systemFontOfSize:14];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    
    
    [self.contentView addSubview:self.nicknameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.floorLabel];
    [self.contentView addSubview:self.commentLabel];
    [self.contentView addSubview:self.lineView];
    
}

- (void)setUpChildViewFrame
{
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(KCellEdgeMargin);
        make.left.equalTo(self).with.offset(KCellEdgeMargin);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nicknameLabel);
        make.left.equalTo(_nicknameLabel.mas_right).with.offset(10);
        make.height.equalTo(_nicknameLabel);
        make.width.equalTo(@80);
    }];
    
    [_floorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.right.equalTo(self.mas_right).with.offset(-KCellEdgeMargin);
        make.top.equalTo(_nicknameLabel);
        make.height.equalTo(_nicknameLabel);
    }];

    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nicknameLabel.mas_bottom);
        make.left.equalTo(self).with.offset(KCellEdgeMargin);
        make.right.equalTo(self).with.offset(-KCellEdgeMargin);
        make.bottom.equalTo(self).with.offset(-KCellEdgeMargin);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@1);
        make.left.equalTo(_commentLabel);
        make.right.equalTo(_commentLabel);
    }];
}

- (UILabel *)nicknameLabel
{
    if (!_nicknameLabel) {
        _nicknameLabel = [[UILabel alloc]init];
    }
    return _nicknameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
    }
    return _timeLabel;
}

- (UILabel *)floorLabel
{
    if (!_floorLabel) {
        _floorLabel = [[UILabel alloc]init];
    }
    return _floorLabel;
}

-(UILabel *)commentLabel
{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc]init];
    }
    return _commentLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
    }
    return _lineView;
}

@end
