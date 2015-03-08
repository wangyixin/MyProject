//
//  UIImage+My.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/8.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
/**
*  返回一张自由拉伸的图片
*/
+ (UIImage *)resizedImageWithName:(NSString *)name{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}
@end
