//
//  StatusTopView.m
//  SinaWebo
//
//  Created by 亦心 on 15/4/2.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "StatusTopView.h"
#import "ReweetStatusView.h"
#import "PhotosView.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"

@interface StatusTopView ()
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) PhotosView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) ReweetStatusView *retweetView;
@end

@implementation StatusTopView
- (instancetype)initWithCoder:(NSCoder *)coder{
    if ([super initWithCoder:coder]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}

-(void)initView{
    //设置背景图片
    self.userInteractionEnabled=YES;
    self.image=[UIImage resizedImageWithName:@"timeline_card_top_background"];
    self.highlightedImage=[UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
    
    /** 头像 */
    UIImageView *iconView=[[UIImageView alloc]init];
    self.iconView=iconView;
    [self addSubview:iconView];
    /** 会员图标 */
    UIImageView *vipView=[[UIImageView alloc]init];
    //设置会员图片居中
    vipView.contentMode=UIViewContentModeCenter;
    self.vipView=vipView;
    [self addSubview:vipView];
    /** 配图 */
    PhotosView *photoView=[[PhotosView alloc]init];
    self.photoView=photoView;
    [self addSubview:photoView];
    /** 昵称 */
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.textColor=[UIColor redColor];
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.font=StatusFrameNameLabelFont;
    self.nameLabel=nameLabel;
    [self addSubview:nameLabel];
    /** 时间 */
    UILabel *timeLabel=[[UILabel alloc]init];
    timeLabel.textColor = MyColor(240, 140, 19);
    timeLabel.backgroundColor=[UIColor clearColor];
    timeLabel.font=StatusFrameTimeLabelFont;
    self.timeLabel=timeLabel;
    [self addSubview:timeLabel];
    /** 来源 */
    UILabel *sourceLabel=[[UILabel alloc]init];
    sourceLabel.textColor = MyColor(135, 135, 135);
    sourceLabel.font=StatusFrameTimeLabelFont;
    sourceLabel.numberOfLines=0;
    self.sourceLabel=sourceLabel;
    [self addSubview:sourceLabel];
    /** 正文\内容 */
    UILabel *contentLabel=[[UILabel alloc]init];
    contentLabel.textColor = MyColor(39, 39, 39);
    self.contentLabel=contentLabel;
    contentLabel.font=StatusFramecontentLabelFont;
    contentLabel.numberOfLines=0;
    [self addSubview:contentLabel];
    
    // 2.添加被转发微博内部的子控件
    [self setupRetweetSubviews];
}

/**
 *2.添加被转发微博内部的子控件
 */
-(void)setupRetweetSubviews{
    /** 被转发微博的view(父控件) */
    ReweetStatusView *retweetView=[[ReweetStatusView alloc]init];
    self.retweetView=retweetView;
    [self addSubview:retweetView];
}


-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame=statusFrame;
    Status *status=statusFrame.status;
    User *user=status.user;
    /** 头像 */
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame=self.statusFrame.iconViewF;
    
    /** 会员图标 */
    if (user.mbtype) {
        self.vipView.hidden=NO;
        self.vipView.image=[UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame=self.statusFrame.vipViewF;
    }else{
        self.vipView.hidden=YES;
    }
    
    /** 昵称 */
    self.nameLabel.text=user.name;
    self.nameLabel.frame=self.statusFrame.nameLabelF;
    
    /** 时间 */
    self.timeLabel.text=status.created_at;
    CGFloat timeLabelX=self.nameLabel.frame.origin.x+StatusFrameMargin;
    CGFloat timeLabelY=CGRectGetMaxY(self.nameLabel.frame)+StatusFrameMargin*0.5;
    CGSize timeLabelSize=[status.created_at sizeWithFont:StatusFrameNameLabelFont];
    self.timeLabel.frame=(CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    /** 来源 */
    self.sourceLabel.text=status.source;
    CGFloat sourceLabelX=CGRectGetMaxX(self.timeLabel.frame)+StatusFrameMargin;
    CGFloat sourceLabelY=timeLabelY;
    CGSize sourceLabelSize=[status.source sizeWithFont:StatusFrameNameLabelFont];
    self.sourceLabel.frame=(CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    /** 正文\内容 */
    self.contentLabel.text=status.text;
    self.contentLabel.frame=self.statusFrame.contentLabelF;
    
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photoView.hidden=NO;
        self.photoView.photos=status.pic_urls;
        self.photoView.frame=self.statusFrame.photoViewF;
    }else{
        self.photoView.hidden=YES;
    }
    
    // 2.添加被转发微博内部的数据
    [self setupRetweetData];

}


/**
 *添加被转发微博内部的数据
 */
-(void)setupRetweetData{
    Status *retweetStatus=self.statusFrame.status.retweeted_status;
    self.retweetView.statusFrame=self.statusFrame;
    /** 被转发微博的view(父控件) */
    if (retweetStatus) {
        self.retweetView.hidden=NO;
        self.retweetView.frame=self.statusFrame.retweetViewF;
        
    }else{
        self.retweetView.hidden=YES;
    }
}
@end
