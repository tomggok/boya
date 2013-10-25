//
//  NSString+Count.m
//  DragonFramework
//
//  Created by zhangchao on 13-4-12.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "NSString+Count.h"
#import "RegexKitLite.h" //用于字数统计CountStrWord函数

@implementation NSString (Count)

#pragma mark-去掉字符串中的前后空格和换行
-(NSString *)TrimmingStringBywhitespaceCharacterSet/*:(NSString *)str*/
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark-把字符串用分割数切割成一个数组
-(NSArray *)separateStrToArrayBySeparaterChar:(NSString *)str1
{
    return [self componentsSeparatedByString:str1];
}

#pragma mark-把数组里的元素用分隔符合并成一个字符串
+(NSString *)joinedArrayToStr:(NSArray *)array separaterChar:(NSString *)separaterChar
{

    return [array componentsJoinedByString:separaterChar];
}

#pragma mark-字数统计
-(int)CountStrWord/*:(NSString *)str*/
{
	int nResult = 0;
	NSString *strSourceCpy = [self copy];
	NSMutableString *strCopy =[[NSMutableString alloc] initWithString: strSourceCpy];
    NSArray *array = [strCopy componentsMatchedByRegex:@"((news|telnet|nttp|file|http|ftp|https)://){1}(([-A-Za-z0-9]+(\\.[-A-Za-z0-9]+)*(\\.[-A-Za-z]{2,5}))|([0-9]{1,3}(\\.[0-9]{1,3}){3}))(:[0-9]*)?(/[-A-Za-z0-9_\\$\\.\\+\\!\\*\\(\\),;:@&=\\?/~\\#\\%]*)*"];
	if ([array count] > 0) {
		for (NSString *itemInfo in array) {
			NSRange searchRange = {0};
			searchRange.location = 0;
			searchRange.length = [strCopy length];
			[strCopy replaceOccurrencesOfString:itemInfo withString:@"aaaaaaaaaaaa" options:NSCaseInsensitiveSearch range:searchRange];
		}
	}

	char *pchSource = (char *)[strCopy cStringUsingEncoding:NSUTF8StringEncoding];
	int sourcelen = strlen(pchSource);

	int nCurNum = 0;		// 当前已经统计的字数
	for (int n = 0; n < sourcelen; ) {
		if( *pchSource & 0x80 ) {
			pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
			n += 3;
			nCurNum += 2;
		}
		else {
			pchSource++;
			n += 1;
			nCurNum += 1;
		}
	}
        // 字数统计规则，不足一个字(比如一个英文字符)，按一个字算
	nResult = nCurNum / 2 + nCurNum % 2;

	[strSourceCpy release];
	[strCopy release];
	return nResult;
}

#pragma mark-从字符串中获取字数个数为N的字符串，单字节字符占半个字数，双字节占一个字数
- (NSString *)getSubStringWithCharCounts:(NSInteger)number
{
        // 一个字符以内，不处理
	if (self == nil || [self length] <= 1) {
		return self;
	}
	char *pchSource = (char *)[self cStringUsingEncoding:NSUTF8StringEncoding];
	int sourcelen = strlen(pchSource);
	int nCharIndex = 0;		// 字符串中字符个数,取值范围[0, [strSource length]]
	int nCurNum = 0;		// 当前已经统计的字数
	for (int n = 0; n < sourcelen; ) {
		if( *pchSource & 0x80 ) {
			if ((nCurNum + 2) > number * 2) {
				break;
			}
			pchSource += 3;		// NSUTF8StringEncoding编码汉字占３字节
			n += 3;
			nCurNum += 2;
		}
		else {
			if ((nCurNum + 1) > number * 2) {
				break;
			}
			pchSource++;
			n += 1;
			nCurNum += 1;
		}
		nCharIndex++;
	}
	assert(nCharIndex > 0);
	return [self substringToIndex:nCharIndex];
}

#pragma mark-把字符串里的几种字符(保存在一号参数数组里)用2号参数替换掉(不可去掉转义符)
-(NSString *)changeStrToBeChangesStr:(NSArray *)array/*要被替换的几种字符串*/ ByStr:(NSString *)ByStr/*要替换成的字符串*/
{
    for (NSString *str in array) {
        self=[self stringByReplacingOccurrencesOfString:str withString:ByStr];
    }
        //        NSLog(@"%@",str);
//    NSLog(@"%@",orStr);
    
   
    return self;
}

#pragma mark- 去掉字符串中的转义符
-(NSMutableString *)deleteEscapeCharacter:(NSString *)EscapeCharacter/*要被去掉的转义符*/
{
    NSMutableString *mus=[NSMutableString stringWithString:self];
    [mus deleteEscapeCharacterByEscapeCharacter:EscapeCharacter];
    return mus;
}

#pragma mark- 把str里的 "" ,‘:’, ‘/’, ‘%’, ‘#’, ‘;’, ‘@’, ‘%’  转成 UTF-8. 避免服务器发的url里有这些特殊字符从而导致 ([NSURL URLWithString:self] == nil)
-(NSString *)stringByAddingPercentEscapesUsingEncoding
{
    return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//禁止输入表情
+(BOOL)isContainsEmoji:(NSString *)string {
    
    
    
    __block BOOL isEomji = NO;
    
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         
         
         const unichar hs = [substring characterAtIndex:0];
         
         // surrogate pair
         
         if (0xd800 <= hs && hs <= 0xdbff) {
             
             if (substring.length > 1) {
                 
                 const unichar ls = [substring characterAtIndex:1];
                 
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     
                     isEomji = YES;
                     
                 }
                 
             }
             
         } else if (substring.length > 1) {
             
             const unichar ls = [substring characterAtIndex:1];
             
             if (ls == 0x20e3) {
                 
                 isEomji = YES;
                 
             }
             
             
             
         } else {
             
             // non surrogate
             
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 
                 isEomji = YES;
                 
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 
                 isEomji = YES;
                 
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 
                 isEomji = YES;
                 
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 
                 isEomji = YES;
                 
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 
                 isEomji = YES;
                 
             }
             
         }
         
     }];
    
    
    
    return isEomji;
    
}

@end


//==================================================================================
@implementation NSMutableString (Count)

#pragma mark- 去掉字符串中的转义符
-(void)deleteEscapeCharacterByEscapeCharacter:(NSString *)EscapeCharacter/*要被去掉的转义符
\a - Sound alert
\b - 退格
\f - Form feed
\n - 换行
\r - 回车
\t - 水平制表符
\v - 垂直制表符
\\ - 表示要删除一个\(反斜杠),但参数要传\\,因为一个\是转义符
\" - 双引号
\' - 单引号
*/
{
    NSString *character = nil;
    for (int i = 0; i < self.length; i ++) {
        character = [self substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:EscapeCharacter])
            [self deleteCharactersInRange:NSMakeRange(i, 1)];
    }
}



@end

