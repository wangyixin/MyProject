//
//  NSData+Extension.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/31.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "NSData+Extension.h"

@implementation NSDate (Extension)
/**
 *  是否为今天
 */
- (BOOL)isToday{
    return [[NSCalendar currentCalendar] isDateInToday:self];
}
/**
 *  是否为昨天
 */
- (BOOL)isYesterday{
    return [[NSCalendar currentCalendar] isDateInYesterday:self];
}
/**
 *  是否为今年
 */
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}
@end
