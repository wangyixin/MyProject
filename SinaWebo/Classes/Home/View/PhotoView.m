//
//  PhotoView.m
//  SinaWebo
//
//  Created by 亦心 on 15/4/3.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"

@interface PhotoView ()
@property (nonatomic, weak) UIImageView *gifView;
@end

@implementation PhotoView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if ([super initWithCoder:coder]) {
        [self initView];
    }
    return self;
}

-(void)initView{
    // 添加一个GIF小图片
    UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
    UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:gifView];
    self.gifView=gifView;
}

-(void)setPhoto:(Photo *)photo{
    _photo=photo;
    // 控制gifView的可见性
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
//     NSString *photoUrl = [photo.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic ]placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.gifView.layer.anchorPoint=CGPointMake(1, 1);
    self.gifView.layer.position=CGPointMake(self.frame.size.width, self.frame.size.height);
}
@end
