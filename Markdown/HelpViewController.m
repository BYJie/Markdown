//
//  HelpViewController.m
//  Markdown
//
//  Created by 白云杰 on 17/1/4.
//  Copyright © 2017年 白云杰. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL* url = [NSURL URLWithString:@"https://github.com/younghz/Markdown/blob/master/README.md"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    self.webView.delegate = self;
    [self.webView loadRequest:request];
    
    // 初始化样式
    self.webView.backgroundColor = [UIColor whiteColor];
    
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
        _webView.backgroundColor = [UIColor clearColor];
        [_webView setOpaque:NO];
        [self.view addSubview:_webView];
    }
    return _webView;
}


@end
