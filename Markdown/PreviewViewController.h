//
//  PreviewViewController.h
//  Markdown
//
//  Created by 白云杰 on 17/1/4.
//  Copyright © 2017年 白云杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreviewViewController : UIViewController

/** 主题 */
@property (nonatomic, assign) NSInteger style;
/** 内容 */
@property (nonatomic, copy) NSString *content;

@end
