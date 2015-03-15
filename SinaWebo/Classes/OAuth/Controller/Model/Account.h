//
//  Account.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/14.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject<NSCoding>
@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;
@property (nonatomic, strong) NSDate *expiresTime; // 账号的过期时间

+(instancetype)accountWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
