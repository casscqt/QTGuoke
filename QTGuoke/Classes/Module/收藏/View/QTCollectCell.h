//
//  QTCollectCell.h
//  QTGuoke
//
//  Created by Cass on 16/1/17.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QTIntro;
@interface QTCollectCell : UITableViewCell

//intro模型
@property (nonatomic,strong) QTIntro *intro;
//标题
@property (nonatomic,strong) UILabel *titleLabel;
//简述
@property (nonatomic,strong) UILabel *summaryLabel;
//类别
@property (nonatomic,strong) UIButton *sourceBtn;
//时间
@property (nonatomic,strong) UIButton *timeBtn;
//线条
@property (nonatomic,strong) UIView *lineView;

@end
