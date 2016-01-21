//
//  QTCommentViewCell.h
//  QTGuoke
//
//  Created by Cass on 16/1/21.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QTComment;
@interface QTCommentViewCell : UITableViewCell

//comment模型
@property (nonatomic,strong) QTComment *comment;
//昵称
@property (nonatomic,strong) UILabel *nicknameLabel;
//时间
@property (nonatomic,strong) UILabel *timeLabel;
//楼层
@property (nonatomic,strong) UILabel *floorLabel;
//评论内容
@property (nonatomic,strong) UILabel *commentLabel;
//底部线
@property (nonatomic,strong) UIView *lineView;

@end
