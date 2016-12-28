//
//  AppDelegate.h
//  MarkdownKeybord-iOS
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import "MXToolbarButton.h"

#define RGB(r,g,b,a)                [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]

#define YouYouNormalFont @"PingFangSC-Regular"
#define YouYouThinFont @"PingFangSC-Thin"
#define YouYouBoldFont @"PingFangSC-Semibold"
#define YouYouNormalFont1 @"PingFangSC-Regular"
#define YouYouNavFont @"PingFangSC-Medium"
#define YouYouLightFont @"PingFangSC-Light"

@interface MXToolbarButton ()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, copy) eventHandlerBlock buttonPressBlock;

@end

@implementation MXToolbarButton

+ (instancetype)buttonWithImage:(NSString *)imageName {
    return [[self alloc] initwithImage:imageName];
}

+ (instancetype)buttonWithTitle:(NSString *)title {
    return [[self alloc] initwithTitle:title];
}

- (id)initwithImage:(NSString *)imageName{
    _imageName = imageName;
    return [self init];
}

- (id)initwithTitle:(NSString *)title{
    _title = title;
    return [self init];
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 40, 40)];
    if (self) {
        self.backgroundColor = [self getUIColor:@"FFFFFF"];
        
        self.layer.cornerRadius = 5.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        //设置下阴影
        CALayer *line = [[CALayer alloc] init];
        line.borderWidth=1.0f;
        line.cornerRadius = 5.0f;
        line.borderColor = [self getUIColor:@"848588"].CGColor;
        [line setFrame:CGRectMake(0,0,self.layer.bounds.size.width,self.layer.bounds.size.height+1)];
        [self.layer addSublayer:line];
        
        UIImage *img = [UIImage imageNamed:_imageName];
        [self setImage:img forState:UIControlStateNormal];
        
        if (_title) {
            [self setTitle:_title forState:UIControlStateNormal];
            [self setTitleColor:RGB(155, 155, 155, 1) forState:UIControlStateNormal];
            self.titleLabel.font = [UIFont fontWithName:YouYouNavFont size:17];
        }
    }

    return self;
}

- (void)addEventHandler:(eventHandlerBlock)eventHandler forControlEvents:(UIControlEvents)controlEvent {
    self.buttonPressBlock = eventHandler;
    [self addTarget:self action:@selector(buttonPressed) forControlEvents:controlEvent];
}

- (void)buttonPressed {
    self.buttonPressBlock();
}

- (UIColor *)getUIColor:(NSString*)hexColorString
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColorString substringWithRange:range]]scanHexInt:&blue];
    
    //要进行颜色的RGB设置，要进行对255.0的相除（与其他语言不同）
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green / 255.0f) blue:(float)(blue / 255.0f)alpha:1.0f];
    
}


@end
