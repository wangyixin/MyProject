//
//  BadgeButton.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/8.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "BadgeButton.h"
#import "UIImage+Extension.h"
#import "NSString+Extension.h"

@implementation BadgeButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBadgeButton];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initBadgeButton];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue=[badgeValue copy];
    
    //设置提示数字
    if (badgeValue) {
        self.hidden=NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        //设置按钮的尺寸和位置
        CGFloat badH=self.currentBackgroundImage.size.height;
        CGFloat badW=self.currentBackgroundImage.size.width;
        //计算文字的尺寸
        if (badgeValue.length>1) {
            CGSize fontSize=[badgeValue sizeWithFont:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            badW=fontSize.width+10;
        }
        //设置提示按钮的大小
        CGRect frame=self.frame;
        frame.size.width=badW;
        frame.size.height=badH;
        self.frame=frame;
    }else{
        self.hidden=YES;
    }
}

-(void)initBadgeButton{
    self.hidden=YES;
    [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge_os7"] forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont systemFontOfSize:11];
}
@end
