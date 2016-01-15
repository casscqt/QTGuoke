//
//  NSString+QTString.m
//  QTGuoke
//
//  Created by Cass on 16/1/12.
//  Copyright © 2016年 Cass. All rights reserved.
//

#import "NSString+QTString.h"

@implementation NSString (QTString)

- (NSString *)titleWithTime
{
    // Tue Mar 10 17:32:22 +0800 2015
    // 字符串转换NSDate
    //    _created_at = @"Tue Mar 11 17:48:24 +0800 2015";
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    
    NSDate *date_picked = [NSDate dateWithTimeIntervalSince1970:[self intValue]];
    
    
    if ([date_picked isThisYear]) { // 今年
        
        if ([date_picked isToday]) { // 今天
            
            // 计算跟当前时间差距
            NSDateComponents *cmp = [date_picked deltaWithNow];
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([date_picked isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return  [fmt stringFromDate:date_picked];
            
        }else{ // 前天
            fmt.dateFormat = @"MM-dd";
//            fmt.dateFormat = @"MM-dd HH:mm";
            return  [fmt stringFromDate:date_picked];
        }
        
        
        
    }else{ // 不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd";
//        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        
        return [fmt stringFromDate:date_picked];
        
    }
    
    return [NSString stringWithFormat:@"%@",date_picked];

}

@end
