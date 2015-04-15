//
//  TitleButton.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/10.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "TitleButton.h"
#import "UIImage+Extension.h"

#define TitleButtonImagW 20

@implementation TitleButton

+(instancetype)titleButton{
    return  [[self alloc]init];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setButtonStyle];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setButtonStyle];
    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgY=0;
    CGFloat imgW=TitleButtonImagW;
    CGFloat imgX=contentRect.size.width-imgW-10;
    CGFloat imgH=contentRect.size.height;
    return CGRectMake(imgX, imgY, imgW, imgH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titX=0;
    CGFloat titY=0;
    CGFloat titW=contentRect.size.width-TitleButtonImagW;
    CGFloat titH=contentRect.size.height;
    return  CGRectMake(titX, titY, titW, titH);
}

-(void)setButtonStyle{
    //设置高亮时的背景图片
    [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    //设置图片居中
    self.imageView.contentMode=UIViewContentModeCenter;
    //设置位置居右
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
    //设置高亮时不让图片变灰
    self.adjustsImageWhenHighlighted=NO;
}
@end
