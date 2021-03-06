    //
    //  KNSemiModalViewController.m
    //  KNSemiModalViewController
    //
    //  Created by Kent Nguyen on 2/5/12.
    //  Copyright (c) 2012 Kent Nguyen. All rights reserved.
    //

#import "UIViewController+KNSemiModal.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Gesture.h"
#import "UIView+DragonCategory.h"

@interface UIViewController (KNSemiModalInternal)
-(UIView*)parentTarget;
-(CAAnimationGroup*)animationGroupForward:(BOOL)_forward;
@end

@implementation UIViewController (KNSemiModalInternal)

-(UIView*)parentTarget {
        // To make it work with UINav & UITabbar as well
    UIViewController * target = self;
    while (target.parentViewController != nil) {
        target = target.parentViewController;
    }
    return target.view;
}

-(CAAnimationGroup*)animationGroupForward:(BOOL)_forward {
        // Create animation keys, forwards and backwards
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f*M_PI/180.0f, 1, 0, 0);
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = t1.m34;
    t2 = CATransform3DTranslate(t2, 0, [self parentTarget].frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:t1];
    animation.duration = kSemiModalAnimationDuration/2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation2.toValue = [NSValue valueWithCATransform3D:(_forward?t2:CATransform3DIdentity)];
    animation2.beginTime = animation.duration;
    animation2.duration = animation.duration;
    animation2.fillMode = kCAFillModeForwards;
    animation2.removedOnCompletion = NO;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [group setDuration:animation.duration*2];
    [group setAnimations:[NSArray arrayWithObjects:animation,animation2, nil]];
    return group;
}
@end

@implementation UIViewController (KNSemiModal)

-(void)presentSemiViewController:(UIViewController*)vc 
{
    [self presentSemiView:vc.view];
}

    //显示立体视图
-(void)presentSemiView:(UIView*)vc/*包含scrollV的视图*/ 
{
        // Determine target
    UIView * target = [self parentTarget];//本视图控制器的view,包含nav,不包含顶部状态栏
    
    if (![target.subviews containsObject:vc]) {
            // Calulate all frames
        CGRect sf = vc.frame;
        CGRect vf = target.frame;
        CGRect f  = CGRectMake(0, vf.size.height-sf.size.height-kH_UINavigationController, vf.size.width, sf.size.height);
        CGRect of = CGRectMake(0, 0, vf.size.width, /*vf.size.height-sf.size.height*/ screen.size.height);
        
            // Add semi overlay
        UIView * overlay = [[UIView alloc] initWithFrame:target.bounds];
        overlay.backgroundColor = [UIColor blackColor];
        
            // Take screenshot and scale
        UIGraphicsBeginImageContext(target.bounds.size);
        [target.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIImageView * ss = [[UIImageView alloc] initWithImage:image];
        [overlay addSubview:ss];
        [target addSubview:overlay];
        
            // Dismiss button
            // Don't use UITapGestureRecognizer to avoid complex handling
        UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [dismissButton addTarget:self action:@selector(dismissSemiModalView) forControlEvents:UIControlEventTouchUpInside];
        dismissButton.backgroundColor = [UIColor clearColor];
        dismissButton.frame = of;
        [overlay addSubview:dismissButton];
//        LogRect(__FUNCTION__, dismissButton.frame);
        
            // 展示图的背景controller往后退
        [ss.layer addAnimation:[self animationGroupForward:YES] forKey:@"pushedBackAnimation"];
        [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
            ss.alpha = 0.5;
        }];
        
            // Present view animated
//        vc.frame = CGRectMake(0, vf.size.height, vf.size.width, sf.size.height);
//        [target addSubview:vc];
//        LogRect(__FUNCTION__, target.frame);
//        vc.layer.shadowColor = [[UIColor blackColor] CGColor];
//        vc.layer.shadowOffset = CGSizeMake(0, -2);
//        vc.layer.shadowRadius = 5.0;
//        vc.layer.shadowOpacity = 0.8;
//        [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
//            vc.frame = f;
////            LogRect(__FUNCTION__, vc.frame);
////            [DeBug moveView:vc toFrame:CGRectMake(vc.frame.origin.x, vc.frame.origin.y-kH_UINavigationController, vc.frame.size.width, vc.frame.size.height) Duration:kSemiModalAnimationDuration target:self AnimationsID:@"vc" AnimationDidStopSelector:nil]; 
////            UIImageView *imgV=(UIImageView *)[vc viewWithTag:-111];
////            [imgV setFrame:vc.bounds];
////            LogRect(__FUNCTION__, imgV.frame);
//            
//            [DeBug CreatTapGeture:self selector:@selector(dismissSemiModalView) addInView:vc numberOfTouchesRequired:1 numberOfTapsRequired:1];
//        }];
        
        {//从大到小按Z轴推入
            vc.frame = f;
            [target addSubview:vc];
            vc.hidden=YES;
            [self fadeIn:vc];
//            [DeBug CreatTapGeture:self selector:@selector(dismissSemiModalView) addInView:vc numberOfTouchesRequired:1 numberOfTapsRequired:1];
            [vc CreatTapGeture:self selector:@selector(dismissSemiModalView) numberOfTouchesRequired:1 numberOfTapsRequired:1];
        }
    }
}

-(void)dismissSemiModalView
{
    UIView * target = [self parentTarget];
    UIView * modal/*本项目里ShowDetailsViewController.view*/ = [target.subviews objectAtIndex:target.subviews.count-1];
    UIView * overlay = [target.subviews objectAtIndex:target.subviews.count-2];
    
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
//        modal.frame = CGRectMake(0, target.frame.size.height, modal.frame.size.width, modal.frame.size.height);
//        LogRect(__FUNCTION__, modal.frame);
//        [DeBug GradientByUIView:modal Duration:kSemiModalAnimationDuration target:self AnimationsID:@"modal" AnimationDidStopSelector:nil alpha:0];
        
        modal.transform = CGAffineTransformMakeScale(4, 4);
        modal.alpha=0;
    } completion:^(BOOL finished) {
        [overlay removeFromSuperview];
        [modal removeFromSuperview];
//        [[target viewController] release];
//        [self release];
    }];
    
        // Begin overlay animation
    UIImageView * ss = (UIImageView*)[overlay.subviews objectAtIndex:0];
    [ss.layer addAnimation:[self animationGroupForward:NO] forKey:@"bringForwardAnimation"];
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
        ss.alpha = 1;
    }];
}

- (void)fadeIn:(UIView *)v
{
    v.transform = CGAffineTransformMakeScale(4, 4);
    v.alpha = 0.5;
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
        v.alpha = 1;
        v.transform = CGAffineTransformMakeScale(1, 1);
        v.hidden=NO;
    }];
    
}

- (void)fadeOut
{
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
//        self.transform = CGAffineTransformMakeScale(2, 2);
//        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
//            [_overlayView removeFromSuperview];
//            [self removeFromSuperview];
        }
    }];
}

@end
