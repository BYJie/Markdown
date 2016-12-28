//
//  AppDelegate.h
//  MarkdownKeybord-iOS
//
//  Created by MexiQQ on 14/11/27.
//  Copyright (c) 2014年 MexiQQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol keyboardDelegate <NSObject>

- (void)keyboardPopup;

@end

typedef void(^keybordBlock)(NSInteger index);

@interface MXKeyboardToolbar : UIView 

+ (instancetype)toolbarViewWithTextView:(UITextView *)textView keybordBlock:(keybordBlock )block;

/** 代理 */
@property (nonatomic, assign) id<keyboardDelegate> delegate;

@end
