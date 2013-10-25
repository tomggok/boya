//
//  NSString+Size.m
//  DragonFramework
//
//  Created by zhangchao on 13-4-11.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

#pragma mark-根据内容和内容的字体还有换行模式在指定的size里创建一个新size
-(CGSize)createActiveFrameByfontSize:(UIFont *)font constrainedSize:(CGSize)constrainedSize/*在此size的边界内*/ lineBreakMode:(UILineBreakMode)lineBreakMode/*换行模式,一般都是按UILineBreakModeCharacterWrap字符换行,如果按单词换行,可能出现最右边空出来*/
{
    return [self sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
}

@end
