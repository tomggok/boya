//
//  BoyaSharedInstaceDelegate.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyaSharedInstaceDelegate : NSObject

+(BoyaSharedInstaceDelegate *)sharedInstace;

@property (nonatomic, assign)BOOL      isForceUpdate;//是否强制升级
@property (nonatomic, retain)NSString  *forceUpdateText;//强制升级内容

@property (nonatomic, retain)NSString *userName;//用户名
@property (nonatomic, retain)NSString *passWord;//用户密码
@property (nonatomic, retain)NSString *loginCode;//用户session
@property (nonatomic, retain)NSString *uid;//用户uid
@property (nonatomic, assign)BOOL      isLgin;//用户是否登录
@property (nonatomic, retain)NSString *rememberType;
@property (nonatomic, retain)NSDictionary *uinfo;

@property (nonatomic, assign)NSInteger fontSize;//用户的字体大小

@end
