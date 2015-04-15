//
//  HomeStatusService.m
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "HomeStatusService.h"
#import "HttpUtil.h"
#import "MJExtension.h"

@implementation HomeStatusService
+(void)getHomeStatusDataWith:(HomeRequest *)request success:(void (^)(HomeResponse *))success failure:(void (^)(NSError *))failure{
    [HttpUtil getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:request.keyValues success:^(id responseObject) {
        if (success) {
            HomeResponse *result=[HomeResponse objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
