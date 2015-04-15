//
//  HomeResponse.m
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "HomeResponse.h"
#import "MJExtension.h"
#import "Status.h"

@implementation HomeResponse
-(NSDictionary *)objectClassInArray{
    return @{@"statuses":[Status class]};
}
@end
