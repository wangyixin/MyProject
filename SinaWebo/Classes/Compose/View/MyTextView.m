//
//  MyTextView.m
//  SinaWebo
//
//  Created by 亦心 on 15/4/8.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "MyTextView.h"
#import "NSString+Extension.h"

@interface MyTextView ()
@property (nonatomic, weak) UILabel *label;
@end
@implementation MyTextView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self initText];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    if ([super initWithCoder:coder]) {
        [self initText];
    }
    return self;
}

-(void)initText{
    self.font=[UIFont systemFontOfSize:14];
    UILabel *label=[[UILabel alloc]init];
    label.textColor=[UIColor lightGrayColor];
    label.numberOfLines=0;
    label.font=self.font;
    [self addSubview:label];
    self.label=label;
}

-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder=[placeholder copy];
    CGFloat labelX=7;
    CGFloat labelY=8;
    self.label.frame=(CGRect){{labelX,labelY},self.frame.size};
    self.label.text=placeholder;
    [self.label sizeToFit];
    //监听TextView文字改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

/**
 *监听TextView文字改变
 */
-(void)textDidChange{
    self.label.hidden = (self.text.length!=0);
}

/**
 *设置label的字体和TextView的字体相同
 */
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.label.font=font;
    //重新计算label的尺寸
    self.placeholder=self.placeholder;
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    self.label.textColor=placeholderColor;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
