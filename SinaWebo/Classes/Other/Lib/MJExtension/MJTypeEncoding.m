//
//  MJTypeEncoding.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "MJTypeEncoding.h"

@implementation MJTypeEncoding
NSString *const MJTypeInt = @"i";
NSString *const MJTypeFloat = @"f";
NSString *const MJTypeDouble = @"d";
NSString *const MJTypeLong = @"q";
NSString *const MJTypeLongLong = @"q";
NSString *const MJTypeChar = @"c";
NSString *const MJTypeBOOL = @"c";
NSString *const MJTypePointer = @"*";

NSString *const MJTypeIvar = @"^{objc_ivar=}";
NSString *const MJTypeMethod = @"^{objc_method=}";
NSString *const MJTypeBlock = @"@?";
NSString *const MJTypeClass = @"#";
NSString *const MJTypeSEL = @":";
NSString *const MJTypeId = @"@";

/**
 *  返回值类型(如果是unsigned，就是大写)
 */
NSString *const MJReturnTypeVoid = @"v";
NSString *const MJReturnTypeObject = @"@";

@end