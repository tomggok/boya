//
//  Dragon_RequestQueue.h
//  DragonFramework
//
//  Created by NewM on 13-4-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//


#undef	DEFAULT_GET_TIMEOUT
#define DEFAULT_GET_TIMEOUT			(30.0f)         //GET请求超时时间

#undef	DEFAULT_POST_TIMEOUT
#define DEFAULT_POST_TIMEOUT		(30.0f)			//POST请求超时时间

#undef	DEFAULT_UPLOAD_TIMEOUT
#define DEFAULT_UPLOAD_TIMEOUT		(120.0f)		//上传超时时间

#import <Foundation/Foundation.h>
#import "Dragon_Request.h"


@interface DragonRequestQueue : NSObject<ASIHTTPRequestDelegate>
{
    BOOL                _merge;
    BOOL                _online;
    
    NSUInteger          _bytesUpload;
    NSUInteger          _bytesDownload;
    
    NSTimeInterval      _delay;
    NSMutableArray      *_arr_requests;

}

@property (nonatomic, assign)BOOL                   merge;
@property (nonatomic, assign)BOOL                   online;//联网状态

@property (nonatomic, assign)NSUInteger             bytesUpload;
@property (nonatomic, assign)NSUInteger             bytesDownload;

@property (nonatomic, assign)NSTimeInterval         delay;
@property (nonatomic, retain)NSMutableArray         *arr_requests;


+ (BOOL)isReachableViaWIFI;
+ (BOOL)isReachableViaWLAN;
+ (BOOL)isNetworkInUse;
+ (NSUInteger)bandwidthUsedPerSecond;

+ (DragonRequest *)GET:(NSString *)url;
+ (DragonRequest *)POST:(NSString *)url;

+ (BOOL)requesting:(NSString *)url;
+ (BOOL)requesting:(NSString *)url byResponder:(id)responder;

+ (NSArray *)requests:(NSString *)url;
+ (NSArray *)requests:(NSString *)url byResponder:(id)responder;

+ (void)cancelRequest:(DragonRequest *)request;
+ (void)cancelRequestByResponder:(id)responder;
+ (void)cancelAllRequests;

@end
