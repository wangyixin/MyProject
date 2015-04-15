//
//  IWStatus.m
//  ItcastWeibo
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "Status.h"
#import "NSData+Extension.h"
#import "MJExtension.h"
#import "Photo.h"

@implementation Status

-(NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[Photo class]};
}

-(void)setSource:(NSString *)source{
    int loc = (int)[source rangeOfString:@">"].location+1;
    if (loc>0) {
        int length = (int)[source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, length)];
        _source = [NSString stringWithFormat:@"来自 %@", source];
    }
}

-(NSString *)created_at{
    //获取微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat=@"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    NSDate *createDate=[fmt dateFromString:_created_at];
    
    //判断距离现在的时间
    if (createDate.isToday) {//是否是今天
        if (createDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%ld小时前", (long)createDate.deltaWithNow.hour];
        } else if (createDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%ld分钟前", (long)createDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    }else if(createDate.isYesterday){//是否时昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createDate];
    }else if(createDate.isThisYear){//是否是今年
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}
@end
