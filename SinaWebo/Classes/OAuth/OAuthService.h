//
//  OAuthService.h
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthRequest.h"
#import "OAuthResponse.h"
#import "Account.h"

@interface OAuthService : NSObject
+(void)getOAuthDataWithRequest:(OAuthRequest *)request success:(void (^)(Account *response))success failure:(void (^)(NSError *error))failure;
@end
