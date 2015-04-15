//
//  StatusFrame.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "StatusFrame.h"
#import "NSString+Extension.h"
#import "Status.h"
#import "User.h"
#import "PhotosView.h"

@implementation StatusFrame
-(void)setStatus:(Status *)status{
    _status=status;

    //cell的高度
    CGFloat cellW=[UIScreen mainScreen].bounds.size.width-kCellMargin*2;
    //TopView
    CGFloat topViewX=0;
    CGFloat topViewY=0;
    CGFloat topViewW=cellW;
    CGFloat topViewH=0;
    
    
    //头像
    CGFloat iconViewX=StatusFrameMargin;
    CGFloat iconViewY=StatusFrameMargin;
    CGFloat iconViewWH=50;
    _iconViewF=CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
     //昵称
    CGFloat nameLabelX=CGRectGetMaxX(_iconViewF)+StatusFrameMargin;
    CGFloat nameLabelY=iconViewY;
    CGSize nameLabelSize=[status.user.name sizeWithFont:StatusFrameNameLabelFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLabelF=(CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    //会员图标
    if (status.user.mbtype) {
        CGFloat vipViewX=CGRectGetMaxX(_nameLabelF)+StatusFrameMargin;
        CGFloat vipViewY=nameLabelY;
        CGFloat vipViewW=14;
        CGFloat vipViewH=nameLabelSize.height;
        _vipViewF=CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //时间
    CGFloat timeLabelX=CGRectGetMaxX(_iconViewF)+StatusFrameMargin;
    CGFloat timeLabelY=CGRectGetMaxY(_nameLabelF)+StatusFrameMargin*0.5;
    CGSize timeLabelSize=[status.created_at sizeWithFont:StatusFrameNameLabelFont];
    _timeLabelF=(CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    //来源
    CGFloat sourceLabelX=CGRectGetMaxX(_timeLabelF)+StatusFrameMargin;
    CGFloat sourceLabelY=timeLabelY;
    CGSize sourceLabelSize=[status.source sizeWithFont:StatusFrameNameLabelFont];
    _sourceLabelF=(CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //正文
    CGFloat contentLabelX=iconViewX;
    CGFloat contentLabelY=MAX(CGRectGetMaxY(_timeLabelF)+StatusFrameMargin, CGRectGetMaxY(_iconViewF)+StatusFrameMargin);
    CGFloat contentMaxW=topViewW-2*StatusFrameMargin;
    CGSize contentLabelSize=[status.text sizeWithFont:StatusFramecontentLabelFont maxSize:CGSizeMake(contentMaxW, MAXFLOAT)];
    _contentLabelF=(CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    
    //配图
    if (status.pic_urls.count) {
        CGSize photoViewSize=[PhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photoViewX=contentLabelX;
        CGFloat photoViewY=CGRectGetMaxY(_contentLabelF)+StatusFrameMargin;
        _photoViewF=(CGRect){{photoViewX,photoViewY},photoViewSize};
    }
    
    //被转发微博
    if (status.retweeted_status) {
        CGFloat retweetViewX=contentLabelX;
        CGFloat retweetViewY=CGRectGetMaxY(_contentLabelF)+StatusFrameMargin*0.5;
        CGFloat retweetViewW=contentMaxW;
        CGFloat retweetViewH=0;
        
        //被转发微博的昵称
        CGFloat retweetNameLabelX=StatusFrameMargin;
        CGFloat retweetNameLabelY=StatusFrameMargin;
        CGSize retweetNameLabelSize = [[NSString stringWithFormat:@"@,%@",status.retweeted_status.user.name] sizeWithFont:StatusFrameNameLabelFont];
        _retweetNameLabelF=(CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
        
        //被转发微博的正文\内容
        CGFloat retweetContentLabelX=retweetViewX;
        CGFloat retweetContentLabelY=CGRectGetMaxY(_retweetNameLabelF);
        CGFloat retweetContentLabelMaxW=retweetViewW-2*StatusFrameMargin;
        CGSize retweetContentLabelSize=[status.retweeted_status.text sizeWithFont:StatusFramecontentLabelFont maxSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF=(CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        
        //被转发微博的配图
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetPhotoViewX=retweetContentLabelX;
            CGFloat retweetPhotoViewY=CGRectGetMaxY(_retweetContentLabelF)+StatusFrameMargin;
            CGSize retweetPhotoView=[PhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            _retweetPhotoViewF=(CGRect){{retweetPhotoViewX,retweetPhotoViewY},retweetPhotoView};
            
            //有配图时被转发微博的高度
            retweetViewH=CGRectGetMaxY(_retweetPhotoViewF)+StatusFrameMargin;
        }else{
            //没有配图时被转发微博的高度
            retweetViewH=CGRectGetMaxY(_retweetContentLabelF)+StatusFrameMargin;
        }
        _retweetViewF=CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        //有转发微博时微博的高度
        topViewH=CGRectGetMaxY(_retweetViewF)+StatusFrameMargin;
    }else{
        //没有转发微博时微博的高度
        //有配图时微博的高度
        if (status.thumbnail_pic) {
            topViewH=CGRectGetMaxY(_photoViewF)+StatusFrameMargin;
        }else{
            //有配图时微博的高度
            topViewH=CGRectGetMaxY(_contentLabelF)+StatusFrameMargin;
        }
    }
    _topViewF=CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    //工具条
    CGFloat statusToolbarX=topViewX;
    CGFloat statusToolbarY=CGRectGetMaxY(_topViewF);
    CGFloat statusToolbarW=topViewW;
    CGFloat statusToolbarH=36;
    _statusToolbarF=CGRectMake(statusToolbarX, statusToolbarY, statusToolbarW, statusToolbarH);
    
    //cell的高度
    _cellHeight=CGRectGetMaxY(_statusToolbarF)+kCellMargin;
}
@end
