//
//  OAuthService.m
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "OAuthService.h"
#import "HttpUtil.h"
#import "MJExtension.h"
#import "OAuthResponse.h"

@implementation OAuthService
+(void)getOAuthDataWithRequest:(OAuthRequest *)request success:(void (^)(Account *))success failure:(void (^)(NSError *))failure{
    [HttpUtil postWithURL:getTokenURL params:request.keyValues success:^(id responseObject) {
        if (success) {
            Account *result=[Account objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];
}
@end
