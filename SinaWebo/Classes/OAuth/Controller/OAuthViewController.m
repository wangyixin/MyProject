//
//  OAuthViewController.m
//  SinaWebo
//
//  Created by 亦心 on 15/3/13.
//  Copyright (c) 2015年 亦心. All rights reserved.
//

#import "OAuthViewController.h"
#import "AFNetworking.h"
#import "Account.h"
#import "TabBarViewController.h"
#import "NewFeatureViewController.h"
#import "ChooseControllerUtil.h"
#import "UserPerfenceUtil.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView=[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    NSURL *url=[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=482649692&redirect_uri=http://open.weibo.com"];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate=self;
    [self.view addSubview:webView];
}

#pragma UIWebView的代理可以拦截请求的字符串
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //请求的URL路径http://open.weibo.com/?code=d27bab4ae7252f9df0b758c0d5c3ce91
    NSString *urlStr= request.URL.absoluteString;
    
    NSRange range=[urlStr rangeOfString:@"code="];
    if (range.length) {
        long loaction=range.location+range.length;
        NSString *code=[urlStr substringFromIndex:loaction];
        //发送网络请求
        [self accessTokenWithCode:code];
    }
    return YES;
}

/**
 *  发送网络请求
 */

-(void)accessTokenWithCode:(NSString *)code{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    NSMutableDictionary *parames=[NSMutableDictionary dictionary];
    parames[@"client_id"]=@"482649692";
    parames[@"client_secret"]=@"8e29395a0d0a4ac49d137e1e991b20ff";
    parames[@"grant_type"]=@"authorization_code";
    parames[@"code"]=code;
    parames[@"redirect_uri"]=@"http://open.weibo.com";
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:parames success:^(AFHTTPRequestOperation *operation, id responseObject) {
        Account *account=[Account accountWithDict:responseObject];
        //存档
        [UserPerfenceUtil saveAccount:account];
        
        //设置要要跳转的控制器
        [ChooseControllerUtil chooseRootController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
@end
