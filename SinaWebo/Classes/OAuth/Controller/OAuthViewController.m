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
#import "HttpUtil.h"
#import "OAuthService.h"

@interface OAuthViewController ()<UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView=[[UIWebView alloc]init];
    webView.frame=self.view.bounds;
    NSURL *url=[NSURL URLWithString:LoginURL];
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
        return NO;
    }
    return YES;
}

/**
 *  发送网络请求
 */

-(void)accessTokenWithCode:(NSString *)code{
    OAuthRequest *requst=[OAuthRequest request];
    requst.client_id=AppKey;
    requst.client_secret=AppSecret;
    requst.grant_type=@"authorization_code";
    requst.redirect_uri=RedirectURI;
    requst.code=code;
    [OAuthService getOAuthDataWithRequest:requst success:^(Account *response) {
        Account *account=response;
        //存档
        [UserPerfenceUtil saveAccount:account];
        
        //设置要要跳转的控制器
        [ChooseControllerUtil chooseRootController];
    } failure:^(NSError *error) {
        
    }];
}
@end
