//
//  SJResponseModel.m
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-6.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaResponseModel.h"

@implementation BoyaResponseModel
@synthesize data,message,code;


- (void)dealloc
{
    RELEASEOBJ(data);
    RELEASEOBJ(message);
    RELEASEOBJ(code);
    
    [super dealloc];
}

@end
