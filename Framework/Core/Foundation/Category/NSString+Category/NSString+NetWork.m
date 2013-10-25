//
//  NSString+NetWork.m
//  DragonFramework
//
//  Created by zhangchao on 13-4-11.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "NSString+NetWork.h"

@implementation NSString (NetWork)

#pragma mark-打开浏览器网页
-(void)openWebPage:(NSString *)Website/*网址*/
{
    [[UIApplication sharedApplication]openURL:[[NSURL alloc]initWithString:Website]];
}

#pragma mark-发起电话呼叫
-(void)LaunchPhoneCall/*:(NSString *)phoneNum*/
{
    NSString *str=@"tel:";//通话协议前缀
    str=[str stringByAppendingString:self];

    [self openWebPage:str];
}

#pragma mark-上传URL编码时里面可能包含某些字符，比如‘$‘ ‘&’ ‘？’...等，这些字符在 URL 语法中是具有特殊语法含义的,需要把这些字符 转化为 “%+ASCII” (如 $ 被转化为 %24 ($的16进制ASCII是24) )形式，以免造成冲突
    //http://www.cnblogs.com/meyers/archive/2012/04/26/2471669.html
- (NSString*)encodeURL/*:(NSString *)string*/
{
    NSString *newString1 = [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))) autorelease];
    if (newString1) {
		return newString1;
	}
	return @"";
}

@end
