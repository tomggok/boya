//
//  NSString+NetWork.h
//  DragonFramework
//
//  Created by zhangchao on 13-4-11.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NetWork)

-(void)openWebPage:(NSString *)Website/*网址*/;
- (NSString*)encodeURL/*:(NSString *)string*/;

@end
