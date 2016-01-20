//
//  QTLeftViewCell.m
//  QTGuoke
//
//  Created by Cass on 16/1/13.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "QTLeftViewCell.h"



//static CGFloat const kMenuIconTopAndBottomMargin = 15;
static CGFloat const kMenuIconLeftMargin         = 20;
static CGFloat const kMenuIconWidthAndHeight     = 24;

static CGFloat const kMenuIconAndTitleSpace      = 10;

static CGFloat const kIndicatorWidthAndHeight    = 20;

static CGFloat const kBottomLineHeight           = 2;

@interface QTLeftViewCell()


//菜单Btn
@property (nonatomic,strong) UIButton       * menuBtn;
//菜单图片
@property (nonatomic,strong) UIImageView    * menuIcon;
//菜单标题
@property (nonatomic,strong) UILabel        * menuTitle;
//菜单右边箭头
@property (nonatomic,strong) UIImageView    * menuIndicator;
//菜单底部黑线
@property (nonatomic,strong) UIImageView    * menuBottomLine;

@end


@implementation QTLeftViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configCellWithTitle:(NSString *)title image:(NSString *)image forState:(NSString *)cellState
{
    
    if ([cellState isEqualToString:@"normal"]) {
        self.menuIcon.image = [UIImage imageNamed:image];
        self.menuIndicator.image = [UIImage imageNamed:@"menu_arrow"];
        self.menuTitle.text = title;
        self.menuTitle.textColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor colorWithRed:38.0/255 green:38.0/255 blue:38.0/255 alpha:1];
    }else{
        image = [NSString stringWithFormat:@"%@_press",image];
        self.menuIcon.image = [UIImage imageNamed:image];
        self.menuIndicator.image = [UIImage imageNamed:@"menu_arrow_press"];
        self.menuTitle.text = title;
        self.menuTitle.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:29.0/255 green:29.0/255 blue:29.0/255 alpha:1];
    }
    self.menuBottomLine.image = [[UIImage imageNamed:@"menu_line"] stretchableImageWithLeftCapWidth:10 topCapHeight:1];

}


#pragma mark -getter and setter

- (UIImageView *)menuIcon
{
    if (!_menuIcon) {
        _menuIcon = [[UIImageView alloc]init];
        [self.contentView addSubview:_menuIcon];
        //设置frame
        [_menuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.contentView.mas_top).offset(kMenuIconTopAndBottomMargin);
//            make.bottom.equalTo(self.contentView.mas_bottom).offset(-kMenuIconTopAndBottomMargin);
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_left).offset(kMenuIconLeftMargin);
            make.size.mas_equalTo(CGSizeMake(kMenuIconWidthAndHeight, kMenuIconWidthAndHeight));
        }];
    }
    return _menuIcon;
}



- (UILabel *)menuTitle
{
    if (!_menuTitle) {
        _menuTitle = [[UILabel alloc]init];
        _menuTitle.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_menuTitle];
        //设置frame
        [_menuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(_menuIcon.mas_right).offset(kMenuIconAndTitleSpace);
        }];
    }
    return _menuTitle;
}



- (UIImageView *)menuIndicator
{
    if (!_menuIndicator) {
        _menuIndicator = [[UIImageView alloc]init];
        [self.contentView addSubview:_menuIndicator];
    }
    //设置frame
    [_menuIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-(kViewDeckLeftSize + kMenuIconLeftMargin));
        make.size.mas_equalTo(CGSizeMake(kIndicatorWidthAndHeight, kIndicatorWidthAndHeight));
    }];
    return _menuIndicator;
}

- (UIImageView *)menuBottomLine
{
    if (!_menuBottomLine) {
        _menuBottomLine = [[UIImageView alloc]init];
        [self.contentView addSubview:_menuBottomLine];
        //设置frame
        [_menuBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.and.left.and.bottom.equalTo(self.contentView);
            make.height.equalTo(@(kBottomLineHeight));
        }];
        
    }
    return _menuBottomLine;
}






@end
