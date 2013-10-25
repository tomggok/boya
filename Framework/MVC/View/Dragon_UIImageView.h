//
//  Dragon_UIImageView.h
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-8.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DragonViewSignal.h"

@interface DragonUIImageView : UIImageView <UIGestureRecognizerDelegate>
AS_SIGNAL(TAP)       //单击信号

//添加信号
- (void)addSignal:(NSString *)signal object:(NSObject *)object;
@end
