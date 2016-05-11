//
//  DetailViewController.m
//  Demo
//
//  Created by hukezhu on 16/5/10.
//  Copyright © 2016年 hukezhu. All rights reserved.
//

#import "DetailViewController.h"
#import "MJRefresh.h"
#import "AFNetWorking.h"
#import "NetTipView.h"

@interface DetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    self.title = @"新闻详情";
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view
    .bounds];
    [self.view addSubview:webView];
    webView.delegate = self;
    self.webView = webView;


    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];

    [self.webView.scrollView.mj_header beginRefreshing];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[self.urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [self.webView loadRequest:request];
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    if (manager.isReachable) {
        [self.webView hideNetTipView];
    }else{
        
        [self.webView.scrollView.mj_header endRefreshing];
        [self.webView showNetTipViewWithToDoBlock:^{
            [self.webView.scrollView.mj_header beginRefreshing];
        }];
    }
}

- (void)loadData{

    if (self.webView.isLoading) {
        return;
    }
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
}

#pragma mark delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{

    [self.webView hideNetTipView];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    [self.webView.scrollView.mj_header endRefreshing];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{

    [self.webView.scrollView.mj_header endRefreshing];

    [self.webView showNetTipViewWithToDoBlock:^{
        [self.webView.scrollView.mj_header beginRefreshing];
    }];
}

@end
