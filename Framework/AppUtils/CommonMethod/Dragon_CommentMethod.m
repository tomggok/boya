//
//  CommentMethod.m
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-6.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_CommentMethod.h"
#import <CommonCrypto/CommonDigest.h>
#import "zlib.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation DragonCommentMethod


//GBK编码
+ (NSStringEncoding)GBKENCODING
{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return gbkEncoding;
}

//md5加密
+ (NSString *)md5:(NSString *)inPutText
{
	const char *cStr = [inPutText UTF8String];
	unsigned char result[16];
	CC_MD5(cStr, strlen(cStr), result);
	
	return [[NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			 result[0], result[1], result[2], result[3],
			 result[4], result[5], result[6], result[7],
			 result[8], result[9], result[10], result[11],
			 result[12], result[13], result[14], result[15]
			 ] lowercaseString];
}

//解压Gzip
+(NSData *)ungzipData:(NSData *)compressedData
{
    if ([compressedData length] == 0)
        return compressedData;
    
    unsigned full_length = [compressedData length];
    unsigned half_length = [compressedData length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[compressedData bytes];
    strm.avail_in = [compressedData length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    if (inflateInit2(&strm, (15+32)) != Z_OK)
        return nil;
    
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy: half_length];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = [decompressed length] - strm.total_out;
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if (status != Z_OK) {
            break;
        }
    }
    
    if (inflateEnd (&strm) != Z_OK)
        return nil;
    // Set real length.
    if (done) {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    }
    return nil;
}

//十六进制转RGB
+ (UIColor *)colorWithHex:(NSString *)hexString
{
    if (!hexString || hexString.length==0)
    {
		return nil;
	}
	
	NSString *str=hexString;
	
	if ( ! ([hexString hasPrefix:@"0x"] || [hexString hasPrefix:@"0X"]))
    {
		str=[NSString stringWithFormat:@"0x%@",hexString];
	}
	
	int rgb;
	sscanf([str cStringUsingEncoding:NSUTF8StringEncoding], "%i", &rgb);
	
	int red=rgb/(256*256)%256;
	int green=rgb/256%256;
	int blue=rgb%256;
	
	UIColor *color=[UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    
	return color;
}

//RGB颜色
+ (UIColor *)color:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue alpha:(float)alpha
{
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
    return color;
}

//获得ip地址
+ (NSString *)getIPAddress
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}

//得到中英文混合字符串长度
+ (NSInteger)getToInt:(NSString*)strtemp
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [strtemp dataUsingEncoding:enc];
    return [da length];
}

//得到中英文混合字符串长度
+ (NSInteger)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}

//处理url
+ (NSString*)encodeURL:(NSString *)string
{
    NSString *newString1 = [NSMakeCollectable(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding))) autorelease];
    if (newString1) {
		return newString1;
	}
	return @"";
}

//获得屏幕Frame
+ (CGRect)mainFrame
{
    CGRect mainFrame = [UIScreen mainScreen].bounds;
    mainFrame.size.height -= 20;
    
    return mainFrame;
}

//获得屏幕大小
+ (CGSize)mainSize
{
    CGSize mainSize = [DragonCommentMethod mainFrame].size;
    return mainSize;
}

//计算时间与当前时间的差
+ (NSMutableDictionary *)intervalSinceAgoTime:(float)ago
{
    NSDate *begin = [NSDate dateWithTimeIntervalSinceNow:ago];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit| NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *date = [NSCalendar currentCalendar];
    NSDateComponents *interval = [date components:unitFlags fromDate:begin toDate:[NSDate date] options:0];
    
    int year  = [interval year];
	int month = [interval month];
	int week  = [interval week];
	int day   = [interval day];
	int hour  = [interval hour];
	int min   = [interval minute];
	int sec   = [interval second];
    
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSString *time = @"0";
    NSString *type = @"0";
    
	time = [time stringByAppendingFormat:@"%d", year];
    type = @"7";
    [dict setValue:time forKey:type];

	time = [time stringByAppendingFormat:@"%d", month];
    type = @"6";
    [dict setValue:time forKey:type];

	time = [time stringByAppendingFormat:@"%d", week];
    type = @"5";
    [dict setValue:time forKey:type];

	time = [time stringByAppendingFormat:@"%d", day];
    type = @"4";
    [dict setValue:time forKey:type];
    
	time = [time stringByAppendingFormat:@"%d", hour];
    type = @"3";
    [dict setValue:time forKey:type];

	time = [time stringByAppendingFormat:@"%d", min];
    type = @"2";
    [dict setValue:time forKey:type];
    
	time = [time stringByAppendingFormat:@"%d", sec];
    type = @"1";
    [dict setValue:time forKey:type];

    return dict;
}

#pragma mark-得到当前系统(当前设备被设置的时间,可能不是当前的真实时间)所在时区的时间加上正负(interval)秒后的时间控件,todayComponents.year得到int类型表示当前的年份
+(NSDateComponents *)getCurSystemTimeZonesDateComponentsByAddingTimeInterval:(NSInteger)TimeInterval
{
    //取得当前用户的逻辑日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *todayComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit |kCFCalendarUnitHour |kCFCalendarUnitMinute fromDate:[self getCurSystemTimeZonesDateByAddingTimeInterval:TimeInterval]];
    //    todayComponents.year = todayComponents.year;//int
    return todayComponents;
}

#pragma mark-得到当前系统所在时区的时间加上正负(interval)秒后的时间
+(NSDate *)getCurSystemTimeZonesDateByAddingTimeInterval:(NSInteger)TimeInterval
{
    NSDate *date = [NSDate date];//当前的格林威治时间,真机调此方法也得到是这个时间
    //    NSLog(@"%@",date);
    {//
        NSTimeZone *zone = [NSTimeZone systemTimeZone];//返回当前系统的时区,真机返回真机的时区
        //    NSLog(@"%@",zone.name);
        //            NSLog(@"%@",[zone.data description]);
        NSInteger interval = [zone secondsFromGMTForDate: date];//28800秒==8小时,即与GMT相差的时间
        
        NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
        //    NSLog(@"%@", [localeDate]);
        
        NSDate *finalDate=[localeDate dateByAddingTimeInterval:TimeInterval];
        return finalDate;
    }
    
}

#pragma mark-获得一个NSDate的不包括时区的日期描述
+(NSString *)getDateWithoutTimeZone:(NSDate *)d;
{
    NSString *str=[d description];
    //    NSRange range=NSMakeRange(0, 10);
    //    str=[str substringToIndex:10];
    str=[str substringToIndex:str.length-6];
    return str;
}

@end
