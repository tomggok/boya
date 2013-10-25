//
//  NSObject+GCD.h
//  DragonFramework
//
//  Created by zhangchao on 13-4-12.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

    //多线程/并发/闭包(Block Objects)
@interface NSObject (GCD)

@property (nonatomic,strong) NSString *stringProperty;//用于独立闭包获取类的全局变量时使用

+(void)dispatchAsyncOnGlobal:(dispatch_block_t)block;

@end
