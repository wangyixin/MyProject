//
//  StatusViewCell.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/15.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "StatusViewCell.h"
#import "Status.h"
#import "User.h"
#import "StatusFrame.h"
#import "StatusToolbar.h"
#import "StatusTopView.h"

@interface StatusViewCell ()
/** 顶部的view */
@property (nonatomic, weak) StatusTopView *topView;

/** 微博的工具条 */
@property (nonatomic, weak) StatusToolbar *statusToolbar;
@end

@implementation StatusViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"cell";
    StatusViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[StatusViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //清除默认的颜色
        self.backgroundColor=[UIColor clearColor];
        //设置选中时的背景
        self.selectedBackgroundView=[[UIView alloc]init];
        
        // 1.添加原创微博内部的子控件
        [self setTopViewSubviews];
        
        // 2.添加微博的工具条
        [self setupStatusToolBar];
    }
    return self;
}

/**
 *设置每个Cell的边距
 */
-(void)setFrame:(CGRect)frame{
    frame.origin.x=kCellMargin;
    frame.origin.y+=kCellMargin;
    frame.size.width-=kCellMargin*2;
    frame.size.height-=kCellMargin;
    [super setFrame:frame];
}

/**
 *1.添加原创微博内部的子控件
 */
-(void)setTopViewSubviews{
    /** 顶部的view */
    StatusTopView *topView=[[StatusTopView alloc]init];
    self.topView=topView;
    [self.contentView addSubview:topView];
}


/**
 *2.添加微博的工具条
 */
-(void)setupStatusToolBar{
    StatusToolbar *statusToolbar=[[StatusToolbar alloc]init];
    self.statusToolbar=statusToolbar;
    [self.contentView addSubview:statusToolbar];
}

-(void)setStatusFrame:(StatusFrame *)statusFrame{
    _statusFrame=statusFrame;
    // 1.添加原创微博内部数据
    [self setTopViewData];
    
    // 2.添加微博的工具条数据
    [self setupStatusToolBarData];
}

/**
 *添加原创微博内部数据
 */
-(void)setTopViewData{
    /** 顶部的view */
    self.topView.statusFrame=self.statusFrame;
    self.topView.frame=self.statusFrame.topViewF;
}

/**
 *添加微博的工具条数据
 */
-(void)setupStatusToolBarData{
    /** 微博的工具条 */
    self.statusToolbar.frame=self.statusFrame.statusToolbarF;
    /** 微博的工具条数据 */
    self.statusToolbar.stauts=self.statusFrame.status;
}

@end
