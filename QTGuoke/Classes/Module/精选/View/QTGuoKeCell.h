//
//  QTGuoKeCell.h
//  QTGuoke
//
//  Created by Cass on 15/12/8.
//  Copyright © 2015年 Cass. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QTIntroFrame.h"
#import "QTIntro.h"

@interface QTGuoKeCell : UICollectionViewCell
/**
 *  精选图片
 */
@property (nonatomic,strong) UIImageView *iconView;
/**
 *  精选标题
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  精选类别
 */
@property (nonatomic,strong) UIButton *categoryBtn;
/**
 *  时间
 */
@property (nonatomic,strong) UIButton *timeBtn;
/**
 *  灰线
 */
@property (nonatomic,strong) UIView *line;



/**
 *  introF
 */
@property (nonatomic,strong) QTIntroFrame *introF;


@end
