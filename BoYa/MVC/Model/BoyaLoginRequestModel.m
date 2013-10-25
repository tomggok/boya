//
//  BoyaLoginRequestModel.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-31.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaLoginRequestModel.h"

@implementation BoyaLoginRequestModel
@synthesize c, pwd, uname;

- (void)dealloc
{
    RELEASEOBJ(uname);
    RELEASEOBJ(pwd);
    RELEASEOBJ(c);
    [super dealloc];
}

@end
