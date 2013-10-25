//
//  UIView+Animations.h
//  DragonFramework
//
//  Created by zhangchao on 13-4-12.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animations)

-(void)moveViewToFrame:(CGRect)toRect Duration:(float)duration target:(id)target/*动画开始之前或之中或结束后触发的事件的接收对象*/ AnimationsID:(NSString *)AnimationsID AnimationDidStopSelector:(SEL/*@selector()的返回值类型,C里的函数指针,取类方法的编号(函数地址)*/)selector;
//-(void)GradientByUIViewDuration:(float)duration target:(id)target/*动画开始之前或之中或结束后触发的事件的接收对象*/ AnimationsID:(NSString *)AnimationsID AnimationDidStopSelector:(SEL/*@selector()的返回值类型,C里的函数指针,取类方法的编号(函数地址)*/)selector alpha:(float)alpha/*要渐变到的alpha值(0-1之间)*/;
-(void)scalOrRotationViewCenter:(CGPoint)center/*缩放中心位置*/ transform:(CGAffineTransform)transform/*CGAffineTransformMakeScale|CGAffineTransformMakeRotation*/ duration:(NSTimeInterval)duration Delay:(NSTimeInterval)Delay delegate:(id)delegate animationID:(NSString *)animationID AnimationDidStopSelector:(SEL/*@selector()的返回值类型,C里的函数指针,取类方法的编号(函数地址)*/)selector AnimationsEnabled:(bool)AnimationsEnabled/*是否使用动画*/;

@end
