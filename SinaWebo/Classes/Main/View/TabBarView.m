//
//  TabBarView.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/7.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarButton.h"

@interface TabBarView ()
@property (nonatomic, weak) TabBarButton *selectButton;
@property (nonatomic, weak) UIButton *centerButton;
@property (nonatomic, strong) NSMutableArray *tabBarArray;
@end
@implementation TabBarView

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super initWithCoder:aDecoder]) {
        [self setTabBarBackground];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setTabBarBackground];
    }
    return self;
}

-(NSMutableArray *)tabBarArray{
    if (_tabBarArray==nil) {
        _tabBarArray=[NSMutableArray array];
    }
    return _tabBarArray;
}
/**
 *  设置中间按钮
 *
 */
-(void)addCenterButton{
  UIButton *centerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_os7"] forState:UIControlStateNormal];
    [centerBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateSelected];
    [centerBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_os7"] forState:UIControlStateNormal];
    [centerBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted_os7"] forState:UIControlStateSelected];
    centerBtn.bounds=CGRectMake(0, 0, centerBtn.currentBackgroundImage.size.width, centerBtn.currentBackgroundImage.size.height);
    
    self.centerButton=centerBtn;
    [self addSubview:centerBtn];
    
}

/**
 *  设置TabBar的背景
 */
-(void)setTabBarBackground{
    //self.backgroundColor=[UIColor blueColor];
    [self addCenterButton];
}

-(void)addTabBarButtonWith:(UITabBarItem *)barItem{
    TabBarButton *btn=[[TabBarButton alloc]init];
    btn.item=barItem;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:btn];
    //将TabBar添加到数组中
    [self.tabBarArray addObject:btn];
    //设置默认第一个被选中
    if (self.tabBarArray.count==1) {
        [self buttonClick:btn];
    }
}

-(void)buttonClick:(TabBarButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectButton.tag to:button.tag];
    }
    self.selectButton.selected=NO;
    button.selected=YES;
    self.selectButton=button;
}

/**
 *  设置按钮的位置
 */
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat tabBarH=self.frame.size.height;
    CGFloat tabBarW=self.frame.size.width;
    CGFloat btnH=tabBarH;
    CGFloat btnW=tabBarW/self.subviews.count;
    CGFloat btnY=0;
    //设置中间按钮的位置
    self.centerButton.center=CGPointMake(tabBarW*0.5, tabBarH*0.5);
    for (int index=0; index<self.tabBarArray.count; index++) {
        TabBarButton *btn=self.tabBarArray[index];
        CGFloat btnX=btnW*index;
        if (index>1) {
            btnX+=btnW;
        }
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        //绑定Tag
        btn.tag=index;
    }
}
@end
