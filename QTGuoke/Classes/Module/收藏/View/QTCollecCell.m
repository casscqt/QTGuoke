//
//  QTCollectCell.m
//  QTGuoke
//
//  Created by Cass on 16/1/17.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTCollectCell.h"
#import "QTIntro.h"

static CGFloat const kBottomLineHeight           = 1;

@implementation QTCollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubview];
    }
    return self;
}




- (void)setUpSubview
{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.summaryLabel = [[UILabel alloc]init];
    self.summaryLabel.numberOfLines = 2;
    self.summaryLabel.textColor = [UIColor grayColor];
    self.summaryLabel.font = [UIFont systemFontOfSize:10];
    
    
    self.timeBtn = [[UIButton alloc]init];
    self.timeBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    self.timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.timeBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.timeBtn.titleEdgeInsets= UIEdgeInsetsMake(0, 5, 0, 0);
    self.timeBtn.enabled = NO;
    [self.timeBtn setImage:[UIImage imageNamed:@"icon_time"] forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.sourceBtn = [[UIButton alloc]init];
    self.sourceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.sourceBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.sourceBtn.titleLabel.font = [UIFont systemFontOfSize:8];
    self.sourceBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.sourceBtn.enabled = NO;
    [self.sourceBtn setImage:[UIImage imageNamed:@"icon_source"] forState:UIControlStateNormal];
    [self.sourceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor grayColor];
    

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.summaryLabel];
    [self.contentView addSubview:self.timeBtn];
    [self.contentView addSubview:self.sourceBtn];
    [self.contentView addSubview:self.lineView];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(15);
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(self).with.offset(-15);
        make.height.mas_equalTo(@20);
    }];
    
    [_summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(_titleLabel);
        make.height.mas_equalTo(@40);
    }];
    
    [_sourceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom);
        make.left.equalTo(_summaryLabel);
        make.width.equalTo(_timeBtn);
        make.height.mas_equalTo(@20);
    }];
    
    [_timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_summaryLabel.mas_bottom);
        make.width.equalTo(_sourceBtn);
        make.left.equalTo(_sourceBtn.mas_right);
        make.right.equalTo(_summaryLabel);
        make.height.mas_equalTo(@20);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.equalTo(_sourceBtn);
        make.right.equalTo(_timeBtn);
        make.height.mas_equalTo(@(kBottomLineHeight));
    }];
    

    
    
}

- (void)setIntro:(QTIntro *)intro
{
    self.titleLabel.text = intro.title;
    self.summaryLabel.text = intro.summary;
    [self.sourceBtn setTitle:intro.source_name forState:UIControlStateNormal];
    [self.timeBtn setTitle:intro.date_picked forState:UIControlStateNormal];
}






@end
