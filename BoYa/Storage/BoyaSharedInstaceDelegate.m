//
//  BoyaSharedInstaceDelegate.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaSharedInstaceDelegate.h"

@implementation BoyaSharedInstaceDelegate

@synthesize isForceUpdate = _isForceUpdate, forceUpdateText = _forceUpdateText;
@synthesize loginCode = _loginCode,uid = _uid,userName = _userName,passWord = _passWord,isLgin = _isLgin,rememberType = _rememberType;
@synthesize uinfo= _uinfo;


static BoyaSharedInstaceDelegate *sharedInstace = nil;

+(BoyaSharedInstaceDelegate *)sharedInstace
{
    if (!sharedInstace) {
        sharedInstace = [[BoyaSharedInstaceDelegate alloc] init];
    }
    return sharedInstace;
}

- (NSString *)rememberType
{
    return _rememberType ? _rememberType : @"0";
}

- (NSString *)loginCode
{
    return _loginCode ? _loginCode : @"";
}

- (NSString *)uid
{
    return _uid ? _uid : @"0";
}

- (void)dealloc
{
    RELEASEOBJ(_uid)
    RELEASEOBJ(_loginCode)
    RELEASEOBJ(_userName)
    RELEASEOBJ(_passWord)
    
    RELEASEOBJ(_rememberType)
    
    RELEASEOBJ(_forceUpdateText)
    RELEASEOBJ(_uinfo);
    _isForceUpdate = NO;
    _isLgin = NO;
    
    RELEASEOBJ(sharedInstace)
    [super dealloc];
}

@end
