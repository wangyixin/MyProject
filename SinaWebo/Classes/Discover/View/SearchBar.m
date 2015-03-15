//
//  SearchBar.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/9.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "SearchBar.h"
#import "UIImage+Extension.h"

@implementation SearchBar

+(instancetype)searchBar{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSearchBar];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSearchBar];
    }
    return self;
}

-(void)initSearchBar{
    //设置背景
    self.background=[UIImage resizedImageWithName:@"searchbar_textfield_background_os7"];
    //设置搜索图片
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    imageView.contentMode=UIViewContentModeCenter;
    self.leftViewMode=UITextFieldViewModeAlways;
    self.leftView=imageView;
    //设置搜索的字体
    self.font=[UIFont systemFontOfSize:13];
    //设置提醒文字
    NSMutableDictionary *attrs=[NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName]=[UIColor grayColor];
    self.attributedPlaceholder=[[NSAttributedString alloc]initWithString:@"搜索" attributes:attrs];
    
    //设置右边的清除按钮
    self.clearButtonMode=UITextFieldViewModeAlways;
    
    //设置键盘又下角属性
    self.returnKeyType=UIReturnKeySearch;
    self.enablesReturnKeyAutomatically=YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置背景图片的位置
    self.frame=CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width-40, 30);
    //设置搜索按钮图片的位置
    self.leftView.frame=CGRectMake(0, 0, 30, self.frame.size.height);
}
@end
