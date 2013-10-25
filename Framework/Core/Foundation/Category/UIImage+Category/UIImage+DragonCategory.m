//
//  UIImage+DragonCategory.m
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-7.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "UIImage+DragonCategory.h"

@implementation UIImage (DragonCategory)

//根据颜色返回图片
+(UIImage*)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//截取当前view为图片
+ (UIImage *)cutScreenImg:(UIView *)viewImg
{
    UIGraphicsBeginImageContextWithOptions(viewImg.bounds.size, viewImg.opaque, 0.f);
    [viewImg.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
