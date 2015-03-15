//
//  CheckBoxButton.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/11.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "CheckBoxButton.h"
#define kScreenW self.view.frame.size.width
#define kScreeH self.view.frame.size.height

@implementation CheckBoxButton

+(instancetype)checkBoxButton{
    return [[self alloc]init];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initCheckBox];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCheckBox];
    }
    return self;
}


-(void)initCheckBox{
    self.selected = YES;
    [self setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)checkboxClick:(UIButton *)checkBox{
    checkBox.selected=!checkBox.isSelected;
}
@end
