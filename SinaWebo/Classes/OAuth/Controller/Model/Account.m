//
//  Account.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/14.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "Account.h"

@implementation Account

+(instancetype)accountWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self=[super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.uid=[aDecoder decodeInt64ForKey:@"uid"];
        self.expires_in=[aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in=[aDecoder decodeInt64ForKey:@"remind_in"];
        self.access_token=[aDecoder decodeObjectForKey:@"access_token"];
        self.expiresTime=[aDecoder decodeObjectForKey:@"expiresTime"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeObject:self.expiresTime forKey:@"expiresTime"];
}
@end
