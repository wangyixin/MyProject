//
//  UserPerfenceUtil.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Account;

@interface UserPerfenceUtil : NSObject
/**
 *保存用户信息
 */
+(void)saveAccount:(Account*)account;

+(Account *)account;
@end
