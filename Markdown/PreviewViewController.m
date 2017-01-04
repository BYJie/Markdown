//
//  PreviewViewController.m
//  Markdown
//
//  Created by 白云杰 on 17/1/4.
//  Copyright © 2017年 白云杰. All rights reserved.
//

#import "PreviewViewController.h"
//https://github.com/younghz/Markdown/blob/master/README.md


typedef NS_ENUM(NSInteger, CSSStyle) {
    
    CSSStyleDefault = 1,
    
    CSSStyleWhite = 2,
    
    CSSStyleBlack = 3,
    
    CSSStyleOld = 4,
};

@interface PreviewViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *cssString;
    
    if (_style == 2) {
        cssString = whiteStyle;
    } else if (_style == 3) {
        cssString = blackStyle;
    } else if (_style == 4) {
        cssString = oldStyle;
    } else {
        cssString = defaultStyle;
    }
    
    NSString *value = [cssString stringByAppendingString:_content];
    [self.webView loadHTMLString:value baseURL:[[NSBundle mainBundle] bundleURL]];
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
