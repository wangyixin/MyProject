//
//  UIBarButtonItem+Extension.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/9.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  快速创建一个显示图片的item
 *
 *  @param action   监听方法
 */
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end
