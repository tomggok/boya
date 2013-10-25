//
//  Dragon_RequestQueue.m
//  DragonFramework
//
//  Created by NewM on 13-4-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_RequestQueue.h"

@implementation DragonRequestQueue
@synthesize merge = _merge,
online = _online;

@synthesize bytesDownload = _bytesDownload,
bytesUpload = _bytesUpload;
@synthesize delay = _delay,
arr_requests = _arr_requests;
+ (BOOL)isReachableViaWIFI
{
    return YES;
}

+ (BOOL)isReachableViaWLAN
{
    return YES;
}

+ (BOOL)isNetworkInUse
{
    return ([[DragonRequestQueue sharedInstance].arr_requests count] > 0) ? YES : NO;
}

+ (NSUInteger)bandwidthUsedPerSecond
{
	return [ASIHTTPRequest averageBandwidthUsedPerSecond];
}

+ (DragonRequestQueue *)sharedInstance
{
    static DragonRequestQueue *_sharedInstance = nil;
    @synchronized(self)
    {
        if (!_sharedInstance) {
            _sharedInstance = [[DragonRequestQueue alloc] init];
            [ASIHTTPRequest setDefaultUserAgentString:@"Dragon"];
            [[ASIHTTPRequest sharedQueue] setMaxConcurrentOperationCount:10];
        }
    }
    return _sharedInstance;

}

- (id)init
{
    self = [super init];
    if (self) {
        _delay = .1f;
        _merge = YES;
        _online = YES;
        _arr_requests = [[NSMutableArray alloc] init];
        
        
        
    }
    return self;
}

- (void)setOnline:(BOOL)online
{
    _online = online;
    if (!_online) {
        [self cancelAllRequests];
    }
}

- (void)dealloc
{
    [self cancelAllRequests];
    
    RELEASEDICTARRAYOBJ(_arr_requests);
    
    //    self.whenCreate = nil;
    //    self.whenUpdate = nil;
    
    [super dealloc];
}

+ (DragonRequest *)GET:(NSString *)url
{
    return [[DragonRequestQueue sharedInstance] GET:url sync:NO];
}

- (DragonRequest *)GET:(NSString *)url sync:(BOOL)sync
{
    if (!_online)
    {
        return nil;
    }
    
    DragonRequest *request = nil;
    if (!sync && _merge)
    {//为了处理多次点击
        for (DragonRequest *req in _arr_requests)
        {
            if ([req.url.absoluteString isEqualToString:url])
            {
                return req;
            }
        }
    }
    
    request = [[DragonRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.timeOutSeconds = DEFAULT_GET_TIMEOUT;
    request.requestMethod = @"GET";
    request.postBody = nil;
    [request setDelegate:self];
    [request setDownloadProgressDelegate:self];
    [request setUploadProgressDelegate:self];
    
    //设置请求超时时，设置重试的次数
    [request setNumberOfTimesToRetryOnTimeout:1];
    request.shouldAttemptPersistentConnection = NO;//防止多次提交
    
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
    //iOS4中，当应用后台运行时仍然请求数据
#endif
    
    [_arr_requests addObject:request];
    
    if (sync)
    {
        [request startSynchronous];
    }else
    {
        if (_delay)
        {
            [request performSelector:@selector(startAsynchronous)
                          withObject:nil
                          afterDelay:_delay];
        }else
        {
            [request startAsynchronous];
        }
    }
    
    return [request autorelease];
    
    
}

+ (DragonRequest *)POST:(NSString *)url
{
    return [[DragonRequestQueue sharedInstance] POST:url sync:NO];
}

- (DragonRequest *)POST:(NSString *)url sync:(BOOL)sync
{
    if (!_online)
    {
        return nil;
    }
    
    DragonRequest *request = [[DragonRequest alloc] initWithURL:[NSURL URLWithString:url]];
    request.timeOutSeconds = DEFAULT_POST_TIMEOUT;
    request.requestMethod = @"POST";
//    request.postFormat = ASIMultipartFormDataPostFormat;
    [request setDelegate:self];
    [request setUploadProgressDelegate:self];
    [request setNumberOfTimesToRetryOnTimeout:1];
#if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	[request setShouldContinueWhenAppEntersBackground:YES];
#endif	// #if TARGET_OS_IPHONE && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    
    [_arr_requests addObject:request];
    
    if (sync)
    {
        [request startSynchronous];
    }else
    {
        if (_delay) {
            [request performSelector:@selector(startAsynchronous)
                          withObject:nil
                          afterDelay:_delay];
        }else
        {
            [request startAsynchronous];
        }
    }
    return [request autorelease];
    
}

+ (BOOL)requesting:(NSString *)url
{
    return [[DragonRequestQueue sharedInstance] requesting:url];
}

- (BOOL)requesting:(NSString *)url
{
    for (DragonRequest *request in _arr_requests)
    {
        if ([[request.url absoluteString] isEqualToString:url])
        {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)requesting:(NSString *)url byResponder:(id)responder
{
    return [[DragonRequestQueue sharedInstance] requesting:url byResponder:responder];
}

- (BOOL)requesting:(NSString *)url byResponder:(id)responder
{
    for (DragonRequest *request in _arr_requests) {
        //        if (responder && ![request hasResponder:responder]) {
        //            continue;
        //        }
        
        if (!url || [[request.url absoluteString] isEqualToString:url]) {
            return YES;
        }
    }
    return NO;
}

+ (NSArray *)requests:(NSString *)url
{
    return [[DragonRequestQueue sharedInstance] requests:url];
}

- (NSArray *)requests:(NSString *)url
{
    NSMutableArray *array = [NSMutableArray array];
    for (DragonRequest *request in _arr_requests) {
        [array addObject:request];
    }
    
    return array;
}

+ (NSArray *)requests:(NSString *)url byResponder:(id)responder
{
	return [[DragonRequestQueue sharedInstance] requests:url byResponder:responder];
}

- (NSArray *)requests:(NSString *)url byResponder:(id)responder
{
	NSMutableArray * array = [NSMutableArray array];
    
	for ( DragonRequest * request in _arr_requests )
	{
        //		if ( responder && NO == [request hasResponder:responder] /* request.responder != responder */ )
        //			continue;
		
		if ( nil == url || [[request.url absoluteString] isEqualToString:url] )
		{
			[array addObject:request];
		}
	}
    
	return array;
}

+ (void)cancelRequest:(DragonRequest *)request
{
    [[DragonRequestQueue sharedInstance] cancelRequest:request];
}

- (void)cancelRequest:(DragonRequest *)request
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAsynchronous) object:nil];
    
    if ([_arr_requests containsObject:request])
    {
        if (request.created || request.sending || request.recving)
        {
            [request changeState:STATE_CANCELLED];
        }
        
        [request clearDelegatesAndCancel];
        [request removeAllResponders];
        
        [_arr_requests removeObject:request];
    }
}

+ (void)cancelRequestByResponder:(id)responder
{
    [[DragonRequestQueue sharedInstance] cancelRequestByResponder:responder];
}

- (void)cancelRequestByResponder:(id)responder
{
    if (!responder)
    {
        [self cancelAllRequests];
    }else
    {
        NSMutableArray *tempArray = [NSMutableArray array];
        for (DragonRequest *request in _arr_requests)
        {
            if ([request hasResponder:responder]) {
                [tempArray addObject:request];
            }
        }
        
        for (DragonRequest *request in tempArray)
        {
            [self cancelRequest:request];
        }
        
    }
}

+ (void)cancelAllRequests
{
    [[DragonRequestQueue sharedInstance] cancelAllRequests];
}

- (void)cancelAllRequests
{
    for (DragonRequest *request in _arr_requests)
    {
        [self cancelRequest:request];
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void)requestStarted:(ASIHTTPRequest *)request
{
    if (![request isKindOfClass:[DragonRequest class]]) {
        return;
    }
    
    DragonRequest *newWorkRequest = (DragonRequest *)request;
    [newWorkRequest changeState:STATE_SENDING];
    _bytesUpload += request.postLength;
    
}

- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
    if (![request isKindOfClass:[DragonRequest class]]) {
        return;
    }
    
    DragonRequest *newWorkRequest = (DragonRequest *)request;
    [newWorkRequest changeState:STATE_RECVING];
    
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    _bytesDownload += [[request rawResponseData] length];
    
    if (![request isKindOfClass:[DragonRequest class]]) {
        return;
    }
    
    DragonRequest *newWorkRequest = (DragonRequest *)request;
    
    if (request.responseStatusCode == 200)
    {
        [newWorkRequest changeState:STATE_SUCCEED];
    }else
    {
        [newWorkRequest changeState:STATE_FAILED];
    }
    
    [newWorkRequest clearDelegatesAndCancel];
    [newWorkRequest removeAllResponders];
    
    [_arr_requests removeObject:newWorkRequest];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (![request isKindOfClass:[DragonRequest class]]) {
        return;
    }
    
    DragonRequest *newWorkRequest = (DragonRequest *)request;
    [newWorkRequest setErrorCode:-1];
    [newWorkRequest changeState:STATE_FAILED];
    
    [newWorkRequest clearDelegatesAndCancel];
    [newWorkRequest removeAllResponders];
    
    [_arr_requests removeObject:newWorkRequest];
}

@end
