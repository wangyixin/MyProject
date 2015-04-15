//
//  BaseRequest.m
//  SinaWebo
//
//  Created by Pink Elephant on 15/4/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "BaseRequest.h"
#import "UserPerfenceUtil.h"
#import "Account.h"

@implementation BaseRequest
- (instancetype)init{
    self = [super init];
    if (self) {
        self.access_token=[UserPerfenceUtil account].access_token;
    }
    return self;
}

+(instancetype)request{
    return [[self alloc]init];
}
@end
