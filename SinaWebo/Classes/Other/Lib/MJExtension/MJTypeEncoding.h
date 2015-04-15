//
//  MJTypeEncoding.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJTypeEncoding : NSObject
extern NSString *const MJTypeInt;
extern NSString *const MJTypeFloat;
extern NSString *const MJTypeDouble;
extern NSString *const MJTypeLong;
extern NSString *const MJTypeLongLong;
extern NSString *const MJTypeChar;
extern NSString *const MJTypeBOOL;
extern NSString *const MJTypePointer;

extern NSString *const MJTypeIvar;
extern NSString *const MJTypeMethod;
extern NSString *const MJTypeBlock;
extern NSString *const MJTypeClass;
extern NSString *const MJTypeSEL;
extern NSString *const MJTypeId;

/**
 *  返回值类型
 */
extern NSString *const MJReturnTypeVoid;
extern NSString *const MJReturnTypeObject;
@end
