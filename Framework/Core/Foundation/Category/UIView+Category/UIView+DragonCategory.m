//
//  UIView+DragonCategory.m
//  DragonFramework
//
//  Created by NewM on 13-3-6.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "UIView+DragonCategory.h"
#import <objc/runtime.h>

@implementation UIView(DragonCategory)

@dynamic _originFrame;

static char _c_originFrame;
-(CGRect)_originFrame
{
    return [objc_getAssociatedObject(self, &_c_originFrame) CGRectValue];
    
}

-(void)set_originFrame:(CGRect)frame
{
    objc_setAssociatedObject(self, &_c_originFrame, [NSValue valueWithCGRect:frame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//获得
- (UIViewController *)viewController
{
	if (self.superview)
    {
		return nil;
    }
    
	id nextResponder = [self nextResponder];
	if ( [nextResponder isKindOfClass:[UIViewController class]] )
	{
		return (UIViewController *)nextResponder;
	}else
	{
		return nil;
	}
}

//在父视图的位置
-(void)changePosInSuperViewWithAlignment:(NSUInteger)Alignment
{
    switch (Alignment) {
        case 0://左右居中
        {
            [self setFrame:CGRectMake(self.superview.frame.size.width/2-self.frame.size.width/2, self.frame.origin.y, self.frame.size.width, self.frame.size.height)];
        }
            break;
        case 1://上下居中
        {
            [self setFrame:CGRectMake(self.frame.origin.x, self.superview.frame.size.height/2-self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
        }
            break;
        case 2://中心
        {
            [self setFrame:CGRectMake(self.superview.frame.size.width/2-self.frame.size.width/2, self.superview.frame.size.height/2-self.frame.size.height/2, self.frame.size.width, self.frame.size.height)];
        }
            break;
        default:
            break;
    }
    
}

@end
