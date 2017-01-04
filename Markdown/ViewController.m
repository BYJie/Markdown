//
//  ViewController.m
//  Markdown
//
//  Created by 白云杰 on 16/12/28.
//  Copyright © 2016年 白云杰. All rights reserved.
//
#import "ViewController.h"


@interface ViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, assign) NSInteger style;

@end

@implementation ViewController

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.style = 1;
    [self createTextView];
    [self addKeyboardNotification];
}


#pragma mark - 创建textView
- (void)createTextView {
    
    //markdown输入框
    self.textView = [[UITextView alloc] init];
    self.textView.textColor = RGB(72, 82, 87, 1);
    self.textView.font = [UIFont fontWithName:YouYouNormalFont size:17];
    self.textView.frame = self.view.frame;
    [self.view addSubview:self.textView];
    
    
    __weak typeof(self) weakSelf = self;
    self.textView.inputAccessoryView = [BYMarkdownKeyboard toolbarViewWithTextView:_textView keybordBlock:^(NSInteger index) {
        
        switch (index) {
            case 1:
                [weakSelf.textView resignFirstResponder];
                break;
            case 2:
                [weakSelf helpAction];
                break;
            case 3:
                weakSelf.textView.text = nil;
                break;
            case 4:
                [weakSelf.textView resignFirstResponder];
                [weakSelf changeStyle];
                break;
            case 5:
                [weakSelf previewAction];
                break;
        }
    }];
    
    [self.textView becomeFirstResponder];
}

#pragma mark - 预览
- (void)previewAction {
    
    PreviewViewController *preview = [[PreviewViewController alloc] init];
    preview.style = _style;
    preview.content = [MMMarkdown HTMLStringWithMarkdown:self.textView.text extensions:MMMarkdownExtensionsGitHubFlavored error:NULL];
    
    [self.navigationController pushViewController:preview animated:YES];
}

#pragma mark - markdown语法
- (void)helpAction {
    
    HelpViewController *helpView = [[HelpViewController alloc] init];
    [self.navigationController pushViewController:helpView animated:YES];
}

#pragma mark - 选择主题
- (void)changeStyle {
    
    [BHBPopView showToView:self.view andImages:@[@"images.bundle/tabbar_compose_wbcamera",@"images.bundle/tabbar_compose_wbcamera",@"images.bundle/tabbar_compose_wbcamera",@"images.bundle/tabbar_compose_wbcamera"] andTitles:@[@"默认",@"白色",@"黑色",@"旧"] andSelectBlock:^(BHBItem *item) {
        
        NSLog(@"%@", item.title);
        
        if ([item.title isEqualToString:@"白色"]) {
            self.style = 2;
        } else if ([item.title isEqualToString:@"黑色"]) {
            self.style = 3;
        } else if ([item.title isEqualToString:@"旧"]) {
            self.style = 4;
        } else {
            self.style = 1;
        }
        
        [self.textView becomeFirstResponder];
    }];
}


#pragma mark 键盘的处理
- (void)addKeyboardNotification {
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyBoardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark 这里仅仅移动，可用于textField等
- (void)keyBoardWillShow:(NSNotification *)noti
{
    CGFloat keyboardH = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 获取键盘出现的时间
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 添加键盘位移的动画
    [UIView animateWithDuration:duration animations:^{
//        self.textView.transform =CGAffineTransformMakeTranslation(0, -keyboardH);
        self.textView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - keyboardH);
    }];
}

- (void)keyBoardWillHidden:(NSNotification *)noti{
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
//        self.textView.transform = CGAffineTransformIdentity;
        self.textView.frame = self.view.frame;
    }];
}






























@end
