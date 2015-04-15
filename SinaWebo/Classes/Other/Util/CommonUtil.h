//
//  CommonUtil.h
//  SinaWebo
//
//  Created by 亦心 on 15/4/6.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#ifndef SinaWebo_CommonUtil_h
#define SinaWebo_CommonUtil_h

// 用户登录相关
#define AppKey @"482649692"
#define AppSecret @"8e29395a0d0a4ac49d137e1e991b20ff"
#define RedirectURI @"http://open.weibo.com"
#define LoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", AppKey, RedirectURI]
//获取Token的URL
#define getTokenURL @"https://api.weibo.com/oauth2/access_token"


//获得RGB颜色
#define MyColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//微博用户昵称的字体
#define StatusFrameNameLabelFont [UIFont systemFontOfSize:18]
//微博正文的字体
#define StatusFrameTimeLabelFont [UIFont systemFontOfSize:12]
//微博图片的间距
#define StatusFrameMargin 10
//微博之间的间距
#define kCellMargin 5
//微博时间和来源的字体
#define StatusFramecontentLabelFont [UIFont systemFontOfSize:16]

//微博图片的设置
#define kPhotoH 90//图片高度
#define kPhotoW 90//图片宽度
#define kMargin 4//图片之间的间距



//导航栏文字大小
#define NavigationTextSize 15
#define NavigationCenterTextSize 19


// 3.自定义Log
#ifdef DEBUG
#define MyLog(...) NSLog(__VA_ARGS__)
#else
#define MyLog(...)
#endif

#endif
