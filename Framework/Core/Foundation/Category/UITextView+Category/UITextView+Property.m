//
//  UITextView+Property.m
//  ShangJiaoYuXin
//
//  Created by cham on 13-5-15.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "UITextView+Property.h"
#import <objc/runtime.h>

@implementation UITextView (Property)

@dynamic _orign_contentInset,_orign_contentSize,_orign_font;

static char c_orign_contentInset;
-(UIEdgeInsets )_orign_contentInset
{
    return [objc_getAssociatedObject(self, &c_orign_contentInset) UIEdgeInsetsValue];

}

-(void)set_orign_contentInset:(UIEdgeInsets)Inset
{
    objc_setAssociatedObject(self, &c_orign_contentInset, [NSValue valueWithUIEdgeInsets:Inset], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char c_orign_contentSize;
-(CGSize )_orign_contentSize
{
    return [objc_getAssociatedObject(self, &c_orign_contentSize) CGSizeValue];

}

-(void)set_orign_contentSize:(CGSize)size
{
    objc_setAssociatedObject(self, &c_orign_contentSize, [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char c_orign_font;
-(UIFont *)_orign_font
{
    return objc_getAssociatedObject(self, &c_orign_font);
    
}

-(void)set_orign_font:(UIFont *)f
{
    objc_setAssociatedObject(self, &c_orign_font, f, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
