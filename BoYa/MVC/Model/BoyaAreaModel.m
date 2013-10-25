//
//  BoyaAreaModel.m
//  BoYa
//
//  Created by zhangchao on 13-6-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaAreaModel.h"

@implementation BoyaAreaModel

@synthesize count,areaid,areaname;

- (void)dealloc
{
    RELEASEOBJ(count);
    RELEASEOBJ(areaid);
    RELEASEOBJ(areaname);
    
    [super dealloc];
}

@end
