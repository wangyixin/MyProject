//
//  ComposeViewController.m
//  SinaWebo
//
//  Created by 亦心 on 15/4/7.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "ComposeViewController.h"
#import "MyTextView.h"
#import "MBProgressHUD+MJ.h"
#import "UserPerfenceUtil.h"
#import "Account.h"
#import "AFNetworking.h"

@interface ComposeViewController ()
@property (nonatomic, weak) MyTextView *textView;
@end

@implementation ComposeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏
    [self initNavigation];
    //设置TextView
    [self initTextView];
}

/**
 *设置状态栏
 */
-(void)initNavigation{
    //取消按钮
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    //发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    //设置中间按钮
    self.title=@"发微博";
    //设置背景颜色
    self.view.backgroundColor=[UIColor whiteColor];
}

/**
 *设置导航栏
 */
-(void)initTextView{
    MyTextView *textView=[[MyTextView alloc]init];
    textView.frame=self.view.bounds;
    textView.placeholder=@"分享新鲜事";
    //设置垂直方向可以拖拽
    textView.alwaysBounceVertical=YES;
    [self.view addSubview:textView];
    self.textView=textView;
    //监听TextView文字改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [textView becomeFirstResponder];
}

/**
 *监听TextView文字改变
 */
-(void)textDidChange{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length;
}

/**
 *取消按钮的点击事件
 */
-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
/**
 *发送微博数据
 */
-(void)send{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [UserPerfenceUtil account].access_token;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [MBProgressHUD showSuccess:@"发送成功"];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showError:@"发送失败"];
      }];
    
    // 4.关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    //移除监听器
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
