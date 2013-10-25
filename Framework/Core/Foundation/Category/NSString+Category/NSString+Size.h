//
//  NSString+Size.h
//  DragonFramework
//
//  Created by zhangchao on 13-4-11.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

    //字符串size相关
@interface NSString (Size)

-(CGSize)createActiveFrameByfontSize:(UIFont *)font constrainedSize:(CGSize)constrainedSize/*在此size的边界内*/ lineBreakMode:(UILineBreakMode)lineBreakMode/*换行模式,一般都是按UILineBreakModeCharacterWrap字符换行,如果按单词换行,可能出现最右边空出来*/;

@end
