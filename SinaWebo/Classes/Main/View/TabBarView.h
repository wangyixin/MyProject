//
//  TabBarView.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/7.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TabBarView;

@protocol TabBarViewDelegage <NSObject>

@optional
- (void)tabBar:(TabBarView *)tabBar didSelectedButtonFrom:(int)from to:(int)to;
@end

@interface TabBarView : UIView

//设置TabBar的属性
-(void)addTabBarButtonWith:(UITabBarItem *)barItem;
//代理
@property (nonatomic, weak) id<TabBarViewDelegage> delegate;
@end
