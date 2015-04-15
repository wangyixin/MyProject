//
//  UserPerfenceUtil.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "UserPerfenceUtil.h"
#import "Account.h"
#define UserPerfenceUtilFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation UserPerfenceUtil
+(void)saveAccount:(Account *)account{
    //计算过期时间
    NSDate *now=[NSDate date];
    account.expiresTime=[now dateByAddingTimeInterval:account.expires_in];
    [NSKeyedArchiver archiveRootObject:account toFile:UserPerfenceUtilFile];
}

+(Account *)account{
    Account *account=[NSKeyedUnarchiver unarchiveObjectWithFile:UserPerfenceUtilFile];
    NSDate *now=[NSDate date];
    if ([now compare:account.expiresTime]==NSOrderedAscending) {
        return account;
    }else{
        return nil;
    }
}
@end
