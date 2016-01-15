//
//  QTIntroFrame.m
//  QTGuoke
//
//  Created by Cass on 15/12/15.
//  Copyright © 2015年 Cass. All rights reserved.
//

#import "QTIntroFrame.h"
#import "QTIntro.h"

@implementation QTIntroFrame


- (void)setIntro:(QTIntro *)intro
{
    _intro = intro;
    //计算每个collection item
    [self setUpIntroView];

}


- (void)setUpIntroView
{
    
    //精选图片 frame
    int width = KScreenSize.width - 3*10;
    int height = width *192/288;
    if ([_intro.headline_img_tb rangeOfString:@"imageView2/1/"].location != NSNotFound) {
        NSArray * strArr = [_intro.headline_img_tb componentsSeparatedByString:@"/"]; //截取字符串
        width = [[strArr objectAtIndex:strArr.count-3]intValue];
        height = [[strArr objectAtIndex:strArr.count-1]intValue];
        
        height = height*(KScreenSize.width-3*10)/width;
        width = KScreenSize.width - 3*10;
    }
    _imageViewFrame = CGRectMake(0, 0, width/2, height/2);
    

    //标题 frame
    CGFloat textX = 10;
    CGFloat textY = _imageViewFrame.size.height + 15;
    CGSize titleSize = CGSizeMake(_imageViewFrame.size.width - 2*textX, MAXFLOAT);
    CGSize textSize = [_intro.title boundingRectWithSize:titleSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _titleLabelF = (CGRect){{textX,textY},{_imageViewFrame.size.width - 2*textX,textSize.height}};
    
    //line frame
    CGFloat lineX = 0;
    CGFloat lineY = CGRectGetMaxY(_titleLabelF) + 10;
    CGFloat lineW = _imageViewFrame.size.width;
    CGFloat lineH = 1/[[UIScreen mainScreen] scale];
    _lineF = CGRectMake(lineX, lineY , lineW, lineH);
    
    //类别按钮 frame
    CGFloat ctgBtnX = 0;
    CGFloat ctgBtnY = CGRectGetMaxY(_lineF);
    CGFloat ctgBtnW = _imageViewFrame.size.width/2;
    CGFloat ctnBtnH = 25;
    _ctgBtnF = CGRectMake(ctgBtnX, ctgBtnY, ctgBtnW, ctnBtnH);
    
    
    //时间按钮 frame
    CGFloat timeBtnX = _imageViewFrame.size.width/2;
    CGFloat timeBtnY = CGRectGetMaxY(_lineF);
    CGFloat timeBtnW = _imageViewFrame.size.width/2;
    CGFloat timeBtnH = 25;
    _timeBtnF = CGRectMake(timeBtnX, timeBtnY, timeBtnW, timeBtnH);
    

    //itemSize size
    _cellSize = CGSizeMake(_imageViewFrame.size.width, CGRectGetMaxY(_ctgBtnF));

    

}



@end
