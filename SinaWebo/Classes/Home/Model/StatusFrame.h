//
//  StatusFrame.h
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  assign,readonlyright (c) 2015年 亦心. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+Extension.h"
#import <UIKit/UIKit.h>
#import "NSString+Extension.h"
#import "UIImageView+WebCache.h"

@class Status;
@interface StatusFrame : NSObject

@property (nonatomic, strong) Status *status;

/** 顶部的view */
@property (nonatomic, assign,readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign,readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign,readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign,readonly) CGRect photoViewF;
/** 昵称 */
@property (nonatomic, assign,readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign,readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign,readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign,readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign,readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign,readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign,readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign,readonly) CGRect retweetPhotoViewF;

/** 微博的工具条 */
@property (nonatomic, assign,readonly) CGRect statusToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;

@end
