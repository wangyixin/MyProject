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
    return [UIImage resizedImageWithName:name left:0.5 top:0.5];
}

+(UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top{
    UIImage *image = [self imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

/**
 *  切圆图
 *
 *  @param bg 图片
 *
 *  @return 新的图片
 */

+(instancetype)getCirlImage:(NSString *)imageName{
    UIImage *backImage=[UIImage imageNamed:imageName];
    CGFloat imageX=4;
    CGFloat imageY=4;
    CGFloat imageW=backImage.size.height+2*imageX;
    CGFloat imageH=backImage.size.height+2*imageY;
    CGSize imageSize=CGSizeMake(imageW, imageH);
    //创建一个Bitmap的ImageView对象(尺寸，是否透明，缩放比例)
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    //获取上下文
    CGContextRef context= UIGraphicsGetCurrentContext();
    CGFloat bigRadius=imageH*0.5;
    CGFloat bigCirlX=bigRadius;
    CGFloat bigCirlY=bigRadius;
    [[UIColor whiteColor]set];
    CGContextAddArc(context, bigCirlX, bigCirlY, bigRadius, 0, M_PI*2, 0);
    CGContextFillPath(context);
    
    //小圆
    CGFloat smallRadis=bigRadius-imageX;
    CGContextAddArc(context, bigCirlX, bigCirlY, smallRadis, 0, M_PI*2, 0);
    CGContextClip(context);
    
    [backImage drawInRect:CGRectMake(imageX, imageY, backImage.size.width, backImage.size.height)];
    
    //生成新的图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;

}
@end
