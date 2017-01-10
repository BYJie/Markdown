//
//  ThemeMenu.m
//  Markdown
//
//  Created by 白云杰 on 17/1/10.
//  Copyright © 2017年 白云杰. All rights reserved.
//

#import "ThemeMenu.h"

@interface ThemeMenu ()

@property (nonatomic, strong)UIView *viewBg;

@end

@implementation ThemeMenu

- (void)show
{
    self.viewBg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.viewBg addGestureRecognizer:singleTap];
    
    UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - 60, 300)];
    shareView.center = CGPointMake(ScreenWidth / 2, ScreenHeight/2);
    shareView.backgroundColor = [UIColor whiteColor];
    shareView.layer.masksToBounds = YES;
    shareView.layer.cornerRadius = 5;
    shareView.userInteractionEnabled = YES;
    [self.viewBg addSubview:shareView];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = shareView.bounds;
    //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
    [shareView.layer addSublayer:gradientLayer];
    //设置渐变区域的起始和终止位置（范围为0-1）
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    //设置颜色数组
    gradientLayer.colors = @[(__bridge id)RGB(11, 215, 212, 1).CGColor, (__bridge id)RGB(75, 120, 14, 1).CGColor];
    //设置颜色分割点（范围：0-1）
    gradientLayer.locations = @[@(0.0f), @(1.0f)];
    
    
    NSArray *arr = @[@"黄色主题", @"白色主题", @"黑色主题", @"棕色主题"];

    for (int i = 0; i < 4; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(30, 20 + 70 * i, shareView.frame.size.width - 60, 50);
        btn.backgroundColor = RGB(14, 179, 252, 1);
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.tag = i + 1;
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:btn];
    }
    
    //背景
    [self creatBackgroundView];
    
    [self addSubview:self.viewBg];
    
    self.userInteractionEnabled = YES;
    self.viewBg.userInteractionEnabled = YES;
}

- (void)btnAction:(UIButton *)btn {
    
    if ([self.delegate respondsToSelector:@selector(btnClickWithIndex:)]) {
        [self.delegate btnClickWithIndex:btn.tag];
        [self animateOut];
    }
}


- (void)animateIn
{
    self.viewBg.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        self.viewBg.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (void)animateOut
{
    [UIView animateWithDuration:0.3 animations:^{
        self.viewBg.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.viewBg.alpha = 0.2;
        self.alpha = 0.2;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)creatBackgroundView
{
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    self.opaque = NO;
    
    //这里自定义的View 达到的效果和UIAlterView一样是在Window上添加，UIWindow的优先级最高，Window包含了所有视图，在这之上添加视图，可以保证添加在最上面
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
    
}

- (void)dissMissPresentVC
{
    [self animateOut];
}

#pragma mark - 手势点击
- (void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer {
    
  [self animateOut];
}

@end
