//
//  CZWebViewController.m
//  网易彩票
//
//  Created by apple on 15-1-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZWebViewController.h"
#import "CZHtmlPage.h"

@interface CZWebViewController ()<UIWebViewDelegate>

@property(nonatomic,weak)UIWebView *webView;

@end

@implementation CZWebViewController

-(void)loadView{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    self.view = webView;
    self.webView = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"网页控制器";
    
    //设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //给个返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(btnClick)];
    
    //显示网页数据 UIWebView
    //URL 统一资源路径
    
    //加载 "远程" 的网站
    //NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    
    //加载 "本地" 的网页信息
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.htmlPage.html withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //加载一个请求
    [self.webView loadRequest:request];
    
    
    //如果在调用javascript ，要设置webView的代理，设置webview一个方法
    
}

#pragma mark 网页加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    if (!self.htmlPage.ID) return;
    
    
    //执行javascript
    
    NSString *jsStr = [NSString stringWithFormat:@"window.location.href = '#%@'",self.htmlPage.ID];
    
    [webView stringByEvaluatingJavaScriptFromString:jsStr];
}

-(void)btnClick{
    //隐藏 模态窗口
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
