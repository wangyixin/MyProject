//
//  NewFeatureViewController.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/10.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "CheckBoxButton.h"
#import "TabBarViewController.h"

#define kScreenW self.view.frame.size.width
#define kScreeH self.view.frame.size.height
#define kPageNumber 3

//获得RGB颜色
#define MyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


@interface NewFeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation NewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加ScrollerView
    [self addScrollerView];
    //添加PageControl
    [self addPageControl];
}

/**
 *  添加PageControl
 *
 */
-(void)addPageControl{
    UIPageControl *pageControl=[[UIPageControl alloc]init];
    //设置中点的位置
    pageControl.center=CGPointMake(kScreenW*0.5, kScreeH-30);
    //设置圆的个数
    pageControl.numberOfPages=kPageNumber;
    //设置尺寸
    pageControl.bounds=CGRectMake(0, 0, kScreenW*0.5, 30);
    //设置当前点的颜色
    pageControl.currentPageIndicatorTintColor=MyColor(253, 98, 42);
    //设置其它点的颜色
    pageControl.pageIndicatorTintColor=MyColor(189, 189, 189);
    self.pageControl=pageControl;
    [self.view addSubview:pageControl];
}

/**
 *  设置ScrollerView
 */

-(void)addScrollerView{
    UIScrollView *scrollView=[[UIScrollView alloc]init];
    //设置ScrollView的代理
    scrollView.delegate=self;
    scrollView.frame=self.view.bounds;
    CGFloat imgW=self.view.frame.size.width;
    CGFloat imgH=self.view.frame.size.height;
    CGFloat imgY=0;
    //设置滑动图片
    for (int index=0; index<kPageNumber; index++) {
        UIImageView *imageView=[[UIImageView alloc]init];
        NSString *imageName=[NSString stringWithFormat:@"new_feature_%d",index+1];
        UIImage *image=[UIImage imageNamed:imageName];
        imageView.image=image;
        CGFloat imgX=index*imgW;
        imageView.frame=CGRectMake(imgX, imgY, imgW, imgH);
        [scrollView addSubview:imageView];
        
        if (index==kPageNumber-1) {
            [self setLastImage:imageView];
        }
    }
    scrollView.contentSize=CGSizeMake(kPageNumber*imgW, 0);
    //设置分页
    scrollView.pagingEnabled=YES;
    //设置滑动条不显示
    scrollView.showsHorizontalScrollIndicator=NO;
    self.view.backgroundColor=MyColor(244, 244, 244);
    [self.view addSubview:scrollView];
}

/**
 *  设置最后一个页面
 */
-(void)setLastImage:(UIImageView *)imageView{
    imageView.userInteractionEnabled=YES;
    //添加开始按钮
    UIButton *startButton=[[UIButton alloc]init];
    //设置背景
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    //设置位置和尺寸
    startButton.center=CGPointMake(kScreenW*0.5, kScreeH*0.6);
    startButton.bounds=(CGRect){CGPointZero,startButton.currentBackgroundImage.size};
    //设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startButton];
    
    //添加CheckBox
    CheckBoxButton *checkbox = [[CheckBoxButton alloc] init];
    [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
    checkbox.bounds = CGRectMake(0, 0, 200, 50);
    checkbox.center = CGPointMake(kScreenW*0.5, kScreeH*0.5);
    
    [imageView addSubview:checkbox];
}

/**
 *  跳转到首页
 */
-(void)startClick{
    self.view.window.rootViewController=[[TabBarViewController alloc]init];
}

#pragma UIScrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
   //水平方向的位置
    CGFloat offsetX=scrollView.contentOffset.x;
    double pageDouble=offsetX/kScreenW;
    int pageInt=(int)(pageDouble+0.5);
    self.pageControl.currentPage=pageInt;
}
@end
