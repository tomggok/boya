//
//  UIImage+DragonCategory.h
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-7.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DragonCategory)

//根据颜色返回图片
+(UIImage*)imageWithColor:(UIColor *)color;

//截取当前view为图片
+ (UIImage *)cutScreenImg:(UIView *)viewImg;
@end
