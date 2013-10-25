//
//  NSObject+DragonRequestResponder.h
//  DragonFramework
//
//  Created by NewM on 13-4-1.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_Request.h"
#import "Dragon_RequestQueue.h"

@interface NSObject (DragonRequestResponder)


@property (nonatomic, readonly) DragonRequestBlockS  HTTP_GET;
@property (nonatomic, readonly) DragonRequestBlockS  HTTP_POST;

//请求网络方式
- (DragonRequest *)GET:(NSString *)url;//
- (DragonRequest *)POST:(NSString *)url;//
- (DragonRequest *)HTTP_GET:(NSString *)url;//
- (DragonRequest *)HTTP_POST:(NSString *)url;//

- (BOOL)isRequestResponder;//判断是否请求的响应者
- (BOOL)isRequestingURL;//判断是否在请求
- (BOOL)isRequestingURL:(NSString *)url;//判断当前url是否在请求网络
- (NSArray *)requests;//获得请求网络的全部链接请求对象
- (NSArray *)requests:(NSString *)url;//获得当前url的请求对象
- (void)cancelRequests;//取消当前全部请求
- (void)handleRequest:(DragonRequest *)request;

- (void)handleRequest:(DragonRequest *)request receiveObj:(id)receiveObj;



@end
