//
//  TabBarButton.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/8.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "TabBarButton.h"
#import "BadgeButton.h"
//获得RGB颜色
#define MyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 图标的比例
#define TabBarButtonImageRatio 0.6
// 按钮的默认文字颜色
#define  TabBarButtonTitleColor [UIColor blackColor]
// 按钮的选中文字颜色
#define  TabBarButtonTitleSelectedColor MyColor(234, 103, 7)

@interface TabBarButton ()
@property (nonatomic, weak) BadgeButton *badgeButton;
@end

@implementation TabBarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setButtonStyle];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setButtonStyle];
    }
    return self;
}

/**
 *  设置Buton的属性
 *
 */
-(void)setButtonStyle{
    //设置图片居中
    self.imageView.contentMode=UIViewContentModeCenter;
    //设置文字居中
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    //设置文字大小
    self.titleLabel.font=[UIFont systemFontOfSize:11];
    //设置文字颜色
    [self setTitleColor:TabBarButtonTitleColor forState:UIControlStateNormal];
    //设置选中时的颜色
    [self setTitleColor:TabBarButtonTitleSelectedColor forState:UIControlStateSelected];
    
    //设置提醒按钮
    BadgeButton *badgeButton=[[BadgeButton alloc]init];
    badgeButton.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:badgeButton];
    self.badgeButton=badgeButton;
}


-(void)setItem:(UITabBarItem *)item{
    _item=item;
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    //设置提示按钮的值
    self.badgeButton.badgeValue=self.item.badgeValue;
    //设置提示按钮的位置
    CGRect badgeRect=self.badgeButton.frame;
    CGFloat badX=self.frame.size.width-self.badgeButton.frame.size.width-5;
    CGFloat badY=0;
    badgeRect.origin.x=badX;
    badgeRect.origin.y=badY;
    self.badgeButton.frame=badgeRect;
}

/**
 *  覆盖按钮的高亮状态
 *
 */
-(void)setHighlighted:(BOOL)highlighted{
}

/**
 *  设置Button内部的图片
 */
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imgX=0;
    CGFloat imaY=0;
    CGFloat imgH=contentRect.size.height*TabBarButtonImageRatio;
    CGFloat imgW=contentRect.size.width;
    return CGRectMake(imgX, imaY, imgW, imgH);
}

/**
 *  设置Button内部的文字
 */
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titX=0;
    CGFloat titY=contentRect.size.height*TabBarButtonImageRatio;
    CGFloat titH=contentRect.size.height-titY;
    CGFloat titW=contentRect.size.width;
    return CGRectMake(titX, titY, titW, titH);
}
-(void)dealloc{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}
@end
