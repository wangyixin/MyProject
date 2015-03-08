//
//  NSString+Extension.h
//  QQ
//
//  Created by 亦心 on 15/1/1.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**
 *  获取文字尺寸
 *
 *  @param text text description
 *
 *  @return
 */
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
@end
