//
//  StatusToolbar.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/31.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "StatusToolbar.h"
#import "UIImage+Extension.h"
#import "Status.h"

@interface StatusToolbar ()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *reweetBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation StatusToolbar

- (instancetype)initWithCoder:(NSCoder *)coder{
    if ([super initWithCoder:coder]) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

-(NSMutableArray *)btns{
    if (_btns==nil) {
        _btns=[NSMutableArray array];
    }
    return _btns;
}

-(NSMutableArray *)dividers{
    if (_dividers==nil) {
        _dividers=[NSMutableArray array];
    }
    return _dividers;
}

-(void)setStauts:(Status *)stauts{
    _stauts=stauts;
    
    [self setBtn:self.reweetBtn originalTitle:@"转发" count:stauts.reposts_count];
    [self setBtn:self.commentBtn originalTitle:@"评论" count:stauts.comments_count];
    [self setBtn:self.attitudeBtn originalTitle:@"赞" count:stauts.attitudes_count];
}

-(void)setBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count{
    /**
     0 -> @"转发"
     <10000  -> 完整的数量, 比如个数为6545,  显示出来就是6545
     >= 10000
     * 整万(10100, 20326, 30000 ....) : 1万, 2万
     * 其他(14364) : 1.4万
     */
    if (count) {
        NSString *title=nil;
        if (count<10000) {
            title=[NSString stringWithFormat:@"%d",count];
            
        }else{
            double doubleCount=count/10000.0;
            title=[NSString stringWithFormat:@"%.1f万",doubleCount];
            title=[title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}

-(void)initView{
    self.userInteractionEnabled=YES;
    //设置背景图片
    self.image=[UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
    
    
    //转发微博的按钮
    self.reweetBtn=[self setBtnWithTilte:@"转发" imageName:@"timeline_icon_retweet" bgImageName:@"timeline_card_leftbottom_highlighted"];
    
    //评论微博的按钮
    self.commentBtn=[self setBtnWithTilte:@"评论" imageName:@"timeline_icon_comment" bgImageName:@"timeline_card_middlebottom_highlighted"];
    
    //点赞微博的按钮
    self.attitudeBtn=[self setBtnWithTilte:@"赞" imageName:@"timeline_icon_unlike" bgImageName:@"timeline_card_rightbottom_highlighted"];
    
    //添加分割线
    [self initDivider];
    [self initDivider];
    
}

/**
 *  初始化分割线
 */
-(void)initDivider{
    UIImageView *divider=[[UIImageView alloc]init];
    divider.image=[UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 *  初始化按钮
 *
 *  @param title   按钮的文字
 *  @param imageName   按钮的小图片
 *  @param bgImageName 按钮的背景
 */

-(UIButton *)setBtnWithTilte:(NSString *)title imageName:(NSString *)imageName bgImageName:(NSString *)bgImageName{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.titleEdgeInsets=UIEdgeInsetsMake(0, 5, 0, 0);
    btn.adjustsImageWhenHighlighted=NO;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:bgImageName] forState:UIControlStateHighlighted];
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置按钮的位置
    NSInteger dividerCount=self.dividers.count;
    CGFloat imageW=2;
    
    NSInteger btnCount=self.btns.count;
    CGFloat btnY=0;
    CGFloat btnW=(self.frame.size.width-dividerCount*imageW)/btnCount;
    CGFloat btnH=self.frame.size.height;
    
    for (int index=0; index<btnCount; index++) {
        UIButton *btn=self.btns[index];
        CGFloat btnX=index*(btnW+imageW);
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    //设置分割线的位置
    CGFloat imageY=0; 
    CGFloat imageH=btnH;
    for (int index=0; index<dividerCount; index++) {
        UIImageView *image=self.dividers[index];
        CGFloat imageX=(index+1)*btnW;
        image.frame=CGRectMake(imageX, imageY, imageW, imageH);
    }
}
@end
