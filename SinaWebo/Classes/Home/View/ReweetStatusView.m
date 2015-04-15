//
//  ReweetStatusView.m
//  SinaWebo
//
//  Created by 亦心 on 15/4/2.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "ReweetStatusView.h"
#import "PhotosView.h"
#import "StatusFrame.h"
#import "Status.h"
#import "User.h"

@interface ReweetStatusView ()
/** 被转发微博作者的昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, weak) PhotosView *retweetPhotoView;
@end
@implementation ReweetStatusView

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
    self.userInteractionEnabled=YES;
    //设置背景图片
    self.image=[UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.5];
    
    /** 被转发微博作者的昵称 */
    UILabel *retweetNameLabel=[[UILabel alloc]init];
    retweetNameLabel.textColor = MyColor(67, 107, 163);
    retweetNameLabel.backgroundColor=[UIColor clearColor];
    retweetNameLabel.font=StatusFrameNameLabelFont;
    self.retweetNameLabel=retweetNameLabel;
    [self addSubview:retweetNameLabel];
    
    /** 被转发微博的正文\内容 */
    UILabel *retweetContentLabel=[[UILabel alloc]init];
    retweetContentLabel.textColor = MyColor(90, 90, 90);
    retweetContentLabel.backgroundColor=[UIColor clearColor];
    retweetContentLabel.font=StatusFramecontentLabelFont;
    retweetContentLabel.numberOfLines=0;
    self.retweetContentLabel=retweetContentLabel;
    [self addSubview:retweetContentLabel];
    
    /** 被转发微博的配图 */
    PhotosView *retweetPhotoView=[[PhotosView alloc]init];
    self.retweetPhotoView=retweetPhotoView;
    [self addSubview:retweetPhotoView];
    
    
}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame=statusFrame;
    Status *retweetStatus=statusFrame.status.retweeted_status;
    User *retweetUser=retweetStatus.user;
    /** 被转发微博作者的昵称 */
    self.retweetNameLabel.text=[NSString stringWithFormat:@"@%@",retweetUser.name];
    self.retweetNameLabel.frame=self.statusFrame.retweetNameLabelF;
    /** 被转发微博的正文\内容 */
    self.retweetContentLabel.frame=self.statusFrame.retweetContentLabelF;
    self.retweetContentLabel.text=retweetStatus.text;
    if (retweetStatus.pic_urls.count) {
        /** 被转发微博的配图 */
        self.retweetPhotoView.hidden=NO;
        self.retweetPhotoView.frame=self.statusFrame.retweetPhotoViewF;
        self.retweetPhotoView.photos=retweetStatus.pic_urls;
    }else{
        self.retweetPhotoView.hidden=YES;
    }
}
@end
