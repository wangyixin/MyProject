//
//  HomeStatusService.h
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HomeRequest.h"
#import "HomeResponse.h"

@interface HomeStatusService : NSObject
/**
 *  获取首页数据
 *
 *  @param request 请求参数
 *  @param success 成功时回调
 *  @param failure 失败时回调
 */
+(void)getHomeStatusDataWith:(HomeRequest *)request success:(void (^)(HomeResponse *response))success failure:(void (^)(NSError *error))failure;
@end
