//
//  BoyaTimeModel.m
//  BoYa
//
//  Created by zhangchao on 13-6-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaTimeModel.h"

@implementation BoyaTimeModel

@synthesize count,timeid,timename;

- (void)dealloc
{
    RELEASEOBJ(count);
    RELEASEOBJ(timeid);
    RELEASEOBJ(timename);
    
    [super dealloc];
}

@end
