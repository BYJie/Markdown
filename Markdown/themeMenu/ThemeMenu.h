//
//  ThemeMenu.h
//  Markdown
//
//  Created by 白云杰 on 17/1/10.
//  Copyright © 2017年 白云杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ThemeMenuDelegate <NSObject>

- (void)btnClickWithIndex:(NSInteger)index;

@end

@interface ThemeMenu : UIView

@property (nonatomic, assign) id<ThemeMenuDelegate> delegate;

- (void)show;


@end
