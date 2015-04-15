//
//  UIImage+My.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/8.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

/**
 *  返回一张圆角的图片
 */
+(instancetype) getCirlImage:(NSString *)imageName;
@end
