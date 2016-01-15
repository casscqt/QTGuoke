//
//  QTIntroFrame.h
//  QTGuoke
//
//  Created by Cass on 15/12/15.
//  Copyright © 2015年 Cass. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QTIntro;
@interface QTIntroFrame : NSObject

/**
 *  精选数据
 */
@property (nonatomic,strong) QTIntro *intro;
/**
 *  精选图Frame
 */
@property (nonatomic,assign) CGRect imageViewFrame;

/**
 *  titleLabel Frame
 *
 */
@property (nonatomic,assign) CGRect titleLabelF;

/**
 *  ctgBtn Frame
 */
@property (nonatomic,assign) CGRect ctgBtnF;

/**
 *  timeBtn Frame
 */
@property (nonatomic,assign) CGRect timeBtnF;

/**
 *  timeBtn Frame
 */
@property (nonatomic,assign) CGRect lineF;

/**
 *  itemSize size
 */
@property (nonatomic,assign) CGSize cellSize;

@end
