//
//  NSObject+DragonRequestResponder.m
//  DragonFramework
//
//  Created by NewM on 13-4-1.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "NSObject+DragonRequestResponder.h"

@implementation NSObject (DragonRequestResponder)
@dynamic HTTP_GET,HTTP_POST;

- (DragonRequest *)GET:(NSString *)url
{
    return [self HTTP_GET:url];
}

- (DragonRequest *)POST:(NSString *)url
{
    return [self HTTP_POST:url];
}

- (DragonRequest *)HTTP_GET:(NSString *)url
{
    DragonRequest *req = [DragonRequestQueue GET:url];
    [req addResponder:self];
    return req;
}

- (DragonRequest *)HTTP_POST:(NSString *)url
{
    DragonRequest *req = [DragonRequestQueue POST:url];
    [req addResponder:self];
    return req;
}

- (BOOL)isRequestResponder
{
    if ([self respondsToSelector:@selector(handleRequest:)])
    {
        return YES;
    }
    return NO;
}

- (DragonRequestBlockS)HTTP_GET
{
    DragonRequestBlockS block = ^ DragonRequest * (NSString *url)
    {
        DragonRequest *req = [DragonRequestQueue GET:url];
        [req addResponder:self];
        return req;
    };
    return [[block copy] autorelease];
}

- (DragonRequestBlockS)HTTP_POST
{
    DragonRequestBlockS block = ^DragonRequest*(NSString *url)
    {
        DragonRequest *req = [DragonRequestQueue POST:url];
        [req addResponder:self];
        return req;
    };
    return [[block copy] autorelease];
}

- (BOOL)isRequestingURL
{
    if ([self isRequestResponder])
    {
        return [DragonRequestQueue requesting:nil byResponder:self];
    }else
    {
        return NO;
    }
}

- (BOOL)isRequestingURL:(NSString *)url
{
    if ([self isRequestResponder])
    {
        return [DragonRequestQueue requesting:url byResponder:self];
    }else
    {
        return NO;
    }
}

- (NSArray *)requests
{
    return [DragonRequestQueue requests:nil byResponder:self];
}

- (NSArray *)requests:(NSString *)url
{
    return [DragonRequestQueue requests:url byResponder:self];
}

- (void)cancelRequests
{
    if ([self isRequestResponder]) {
        [DragonRequestQueue cancelRequestByResponder:self];
    }
}

- (void)handleRequest:(DragonRequest *)request
{
    [self handleRequest:request];
}

- (void)handleRequest:(DragonRequest *)request receiveObj:(id)receiveObj
{   
}


@end
