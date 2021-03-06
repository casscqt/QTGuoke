//
//  QTGuoKeCell.m
//  QTGuoke
//
//  Created by Cass on 15/12/8.
//  Copyright © 2015年 Cass. All rights reserved.
//

#import "QTGuoKeCell.h"

@interface QTGuoKeCell ()


@end



@implementation QTGuoKeCell

#pragma mark -getter and setter


-(void)setIntroF:(QTIntroFrame *)introF
{
    _introF = introF;


    //设置iconView Frame和数据
    self.iconView.frame = _introF.imageViewFrame;
    self.iconView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconView.clipsToBounds  = YES;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.iconView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.iconView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.iconView.layer.mask = maskLayer;
    
    NSURL *url = [NSURL URLWithString:introF.intro.headline_img_tb];
    [self.iconView sd_setImageWithURL:url placeholderImage:nil];    //设置line Frame
    [self.line setFrame:introF.lineF];
    
    

    //设置titleLabel Frame和数据
    [self.titleLabel setFrame:introF.titleLabelF];
    self.titleLabel.text = introF.intro.title;

    //设置categoryBtn Frame和数据
    [self.categoryBtn setFrame:introF.ctgBtnF];
    [self.categoryBtn setTitle:introF.intro.source_name forState:UIControlStateNormal];

    //设置timeBtn Frame和数据
    self.timeBtn.frame = introF.timeBtnF;
    [self.timeBtn setTitle:[introF.intro.date_picked titleWithTime] forState:UIControlStateNormal];

    //设置圆角
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.timeBtn.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    maskLayer2.frame = self.timeBtn.bounds;
    maskLayer2.path = maskPath2.CGPath;
    self.timeBtn.layer.mask = maskLayer2;
    //设置圆角
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.categoryBtn.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.categoryBtn.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.categoryBtn.layer.mask = maskLayer1;
    

//    _introF.cellSize = CGSizeMake(CGRectGetMaxX(self.contentView.frame), CGRectGetMaxY(self.timeBtn.frame));

}




- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc]init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setNumberOfLines:3];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}


- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_line];
    }
    return _line;
}

- (UIButton *)categoryBtn
{
    if (!_categoryBtn) {
        _categoryBtn = [[UIButton alloc]init];
        _categoryBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [_categoryBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _categoryBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _categoryBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        _categoryBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        [_categoryBtn setImage:[UIImage imageNamed:@"icon_source"] forState:UIControlStateNormal];
        [_categoryBtn setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_categoryBtn];
    }
    return _categoryBtn;
}


- (UIButton *)timeBtn
{
    if (!_timeBtn) {
        _timeBtn = [[UIButton alloc]init];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [_timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _timeBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        _timeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        [_timeBtn setImage:[UIImage imageNamed:@"icon_time"] forState:UIControlStateNormal];
        [_timeBtn setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:_timeBtn];
    }
    return _timeBtn;
}









@end
