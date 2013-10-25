//
//  analysisXiTongFace.m
//  Yiban
//
//  Created by tom zeng on 13-3-8.
//
//

#import "analysisXiTongFace.h"
#import "XiTongFaceCode.h"

#define BEGIN_FLAG @"["
#define END_FLAG @"]"
#define BEGIN_NEW @"#tar_"
#define END_NEW @"#"
#define End_test @"#"

@implementation analysisXiTongFace
@synthesize targets;


-(NSString*)outString:(NSString*)inString{
    if (inString.length == 0) { //判断字符串为 0时，
        return @"";
    }
    konwFace = NO; // 前一次是face
    NSString *outString = [[NSString alloc]initWithString:@""];
    XiTongFaceCode * faceCode = [[XiTongFaceCode alloc]init];
    NSMutableDictionary* dictFace = [faceCode ServerToXiTong];
    for (int i = 0; i < [inString length] - 1; i++) {
        konwFace = NO;
        NSRange range = NSMakeRange(i, 2);
        NSString *tempStr = [inString substringWithRange:range];
        const char* tt = [tempStr UTF8String];
        NSString *temp = [dictFace objectForKey:tempStr];
        if (temp) { // 是表情
            konwFace = YES;
            outString = [outString stringByAppendingString:temp];
        }else if(tt != NULL){// 是文字
             NSString *last = @"";
            if (konwFace || [tempStr substringFromIndex:0]) {
                last = [tempStr substringToIndex:1];
            }else if(konwFace){  //紧靠表情的 文字
                last = [tempStr substringFromIndex:0];
            }
            outString = [outString stringByAppendingString:last];
        }else{ //不靠表情的文字
            NSRange rr = NSMakeRange(i, 1); 
            NSString *tempStr = [inString substringWithRange:rr];
            const char* chatStr = [tempStr UTF8String];
            if (chatStr != NULL) {
                outString = [outString stringByAppendingString:tempStr];
                
            }
            
        }
    } //判断最后一个字符串
    NSString *ee = [inString substringFromIndex:inString.length - 1];
    const char* lastWord = [ee UTF8String];
    if (lastWord != NULL) { 
        outString = [outString stringByAppendingString:ee];
    }
    return outString ;
}

-(void)getRangeTag:(NSString*)message:(NSMutableArray*)array{
    //判断字符串中是否有tag
    NSRange range2 = [message rangeOfString:BEGIN_NEW];
    //转换关键字的地址位置
    NSString * temp = [message stringByReplacingOccurrencesOfString:@"#tar_" withString:@"$$$$$"];
    NSRange range3 = [temp rangeOfString:END_NEW];
    if ((range2.length>0 && range3.length>0)&& (range2.location<range3.location)) {
        [array addObject:[message substringToIndex:range2.location]];
        NSString *strTar = [message substringWithRange:NSMakeRange(range2.location, range3.location+1-range2.location)];
        strTar = [self getTarget:strTar]; //转发 target 
        [array addObject:strTar];
        if(range3.location == [message length]-2){
            
        }else{
            NSString *str=[message substringFromIndex:range3.location+1];
            [self getRangeTag:str :array];
        }
    }else if((range2.length>0 && range3.length>0)){
        [array addObject:[message substringToIndex:range3.location]];
        NSString *str=[message substringFromIndex:range3.location+1];
        [self getRangeTag:str :array];
    }
    
    else {
        //排除文字是“”的
        
        if (![message isEqualToString:@""]) {
            [array addObject:message];
        }else {
            return;
        }
    }
}

-(NSString*)getTarget:(NSString*)str{
    NSString *temp = [[[NSString alloc]init] autorelease];
    for (target *tag in targets) {
        //        NSString *nqId = [NSString stringWithFormat:@"%d",tag.id];
        
        if ([tag.id isEqualToString:str] ) {
//            btn.target = tag;
            temp = tag.targetname;
            return temp;
        }
    }
    return @"";
    
}

-(NSString*)getImageRange:(NSString*)message : (NSMutableArray*)array {
    NSString *outString = [[NSString alloc]initWithString:@""];
    NSRange range=[message rangeOfString: BEGIN_FLAG];
    NSRange range1=[message rangeOfString: END_FLAG];
    NSRange range2 = [message rangeOfString:BEGIN_NEW];
    NSRange range3 = [message rangeOfString:END_NEW];
    //判断当前字符串是否还有表情的标志。
    if ((range.length>0 && range1.length>0) ||(range2.length>0&& range3.length>0)) {
        if ((range.length>0 && range1.length>0)&&(range.location<range1.location)) {
            if (range.location > 0) {
                NSString *temp = [message substringToIndex:range.location];
                NSRange range4 = [temp rangeOfString:BEGIN_NEW];
                NSRange range5 = [temp rangeOfString:END_NEW];
                if (range4.length>0&&range5.length>0) {
                    [self getRangeTag:temp :array];
                }else{
                    [array addObject:[message substringWithRange:NSMakeRange(0, range.location)]];
                }
                [array addObject:[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)]];
                
                NSString *str=[message substringFromIndex:range1.location+1];
                [self getImageRange:str :array];
            }
            else {
                NSString *nextstr=[message substringWithRange:NSMakeRange(range.location, range1.location+1-range.location)];
                //排除文字是“”的
                if (![nextstr isEqualToString:@""]) {
                    [array addObject:nextstr];
                    NSString *str=[message substringFromIndex:range1.location+1];
                    [self getImageRange:str :array];
                }else {
                    return nil;
                }
            }
        }else{
            
            [self getRangeTag:message :array];
        }
        
    }else if(message != nil){
        
        [array addObject:message];
    }
    
    for (int i = 0; i < array.count; i++) {
        
        XiTongFaceCode *code = [[XiTongFaceCode alloc]init];
       NSString *temp = [[code XiTongToServer] objectForKey:[array objectAtIndex:i]];
        if (temp) {
            outString = [outString stringByAppendingString:temp];
        }else{
            outString = [outString stringByAppendingString:[array objectAtIndex:i]];
        }
    }
    return outString ;
}
-(void)dealloc{

    [targets release];
    [super dealloc];
}
@end
