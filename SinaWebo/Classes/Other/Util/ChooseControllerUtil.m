//
//  MyTool.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "ChooseControllerUtil.h"
#import "TabBarViewController.h"
#import "NewFeatureViewController.h"

@implementation ChooseControllerUtil

+(void)chooseRootController{
    NSString *version=@"CFBundleVersion";
    NSUserDefaults *defaul=[NSUserDefaults standardUserDefaults];
    NSString *lastVersion=[defaul stringForKey:version];
    NSString *currenVersion=[NSBundle mainBundle].infoDictionary[version];
    //设置窗口的根控制器
    if ([lastVersion isEqualToString:currenVersion]) {
       [UIApplication sharedApplication].keyWindow.rootViewController=[[TabBarViewController alloc]init];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController=[[NewFeatureViewController alloc]init];
        //存储新版本
        [defaul setObject:currenVersion forKey:version];
        [defaul synchronize];
    }
}
@end
