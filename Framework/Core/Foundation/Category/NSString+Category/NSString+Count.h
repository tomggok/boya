//
//  NSString+Count.h
//  DragonFramework
//
//  Created by zhangchao on 13-4-12.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

    //计算相关
@interface NSString (Count)

-(NSString *)TrimmingStringBywhitespaceCharacterSet/*:(NSString *)str*/;
-(NSArray *)separateStrToArrayBySeparaterChar:(NSString *)str1;
+(NSString *)joinedArrayToStr:(NSArray *)array separaterChar:(NSString *)separaterChar;
-(int)CountStrWord/*:(NSString *)str*/;
- (NSString *)getSubStringWithCharCounts:(NSInteger)number;
-(NSString *)changeStrToBeChangesStr:(NSArray *)array/*要被替换的几种字符串*/ ByStr:(NSString *)ByStr/*要替换成的字符串*/;
-(NSMutableString *)deleteEscapeCharacter:(NSString *)EscapeCharacter/*要被去掉的转义符*/;
-(NSString *)stringByAddingPercentEscapesUsingEncoding;
+(BOOL)isContainsEmoji:(NSString *)string;//禁止输入表情

@end

@interface NSMutableString (Count)

-(void)deleteEscapeCharacterByEscapeCharacter:(NSString *)EscapeCharacter/*要被去掉的转义符*/;

@end

