//
//  Dragon_UIImageView.m
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-8.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_UIImageView.h"
#import "UIImageView+Init.h"
#import "UIView+Gesture.h"

@implementation DragonUIImageView

DEF_SIGNAL(TAP)       //单击消息

//添加信号
- (void)addSignal:(NSString *)signal object:(NSObject *)object
{
    if ([signal isEqualToString:[DragonUIImageView TAP]]) {
        self.userInteractionEnabled=YES;
        [self CreatTapGeture:self selector:@selector(handleSingleFingerEvent:) numberOfTouchesRequired:1 numberOfTapsRequired:1];
    }
}

//处理单指事件
- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)sender
{
    if (sender.numberOfTapsRequired == 1) {
        //单指单击
        [self sendViewSignal:[DragonUIImageView TAP] withObject:nil];
        
    }
}


@end
