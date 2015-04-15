//
//  TabBarViewController.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/7.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "TabBarView.h"
#import "NavigationController.h"
#import "ComposeViewController.h"

@interface TabBarViewController ()<TabBarViewDelegage>
@property (nonatomic, weak) TabBarView *customTabBar;
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加自定义TabBar
    [self initTabBar];
    //添加所有的子控件
    [self initAllViewController];
    
}

//删除默认的TabBar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIView *childView in self.tabBar.subviews) {
        if ([childView isKindOfClass:[UIControl class]]) {
            [childView removeFromSuperview];
        }
    }
}
/**
 *  自定义TabBar
 */
-(void)initTabBar{
    TabBarView *customTabBar=[[TabBarView alloc]init];
    customTabBar.frame=self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar=customTabBar;
    //设置代理
    customTabBar.delegate=self;
}

/**
 *  TabBar的代理切换控制器
 *
 *  @param tabBar tabBar
 *  @param from   当前的控制器
 *  @param to     要跳转的控制器
 */
-(void)tabBar:(TabBarView *)tabBar didSelectedButtonFrom:(long)from to:(long)to{
    self.selectedIndex=to;
}

/**
 *  TabBar的代理,监听+按钮的点击

 */
-(void)tabBarDidClickedPlusButton:(TabBarView *)tabBar{
    NavigationController *nc=[[NavigationController alloc]initWithRootViewController:[[ComposeViewController alloc]init]];
    [self presentViewController:nc animated:YES completion:nil];
}

/**
 *  创建所有子控件
 */
-(void)initAllViewController{
    //首页
    HomeViewController *homVc=[[HomeViewController alloc]init];
    [self initChickViewController:homVc title:@"首页" imageName:@"tabbar_home_os7" selectImageName:@"tabbar_home_selected_os7"];
    
    //消息
    MessageViewController *messVc=[[MessageViewController alloc]init];
    [self initChickViewController:messVc title:@"消息" imageName:@"tabbar_message_center_os7" selectImageName:@"tabbar_message_center_selected_os7"];
    //广场
    DiscoverViewController *desVc=[[DiscoverViewController alloc]init];
    [self initChickViewController:desVc title:@"广场" imageName:@"tabbar_discover_os7" selectImageName:@"tabbar_discover_selected_os7"];
    
    //我
    MeViewController *mcVc=[[MeViewController alloc]init];
    [self initChickViewController:mcVc title:@"我" imageName:@"tabbar_profile_os7" selectImageName:@"tabbar_profile_selected_os7"];
}
/**
 *  创建一个子控件
 *
 *  @param childVc         子控件名称
 *  @param title           标题
 *  @param imageName       默认图片
 *  @param selectImageName 选中时的图片
 */
-(void)initChickViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName{
    //设置子控制器的属性
    childVc.title=title;
    childVc.tabBarItem.image=[UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage=[[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //将子控制器添加到导航控制器中
    NavigationController *nc=[[NavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nc];
    
    [self.customTabBar addTabBarButtonWith:childVc.tabBarItem];
}
@end
