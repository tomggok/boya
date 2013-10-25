//
//  BoyaTypeModel.m
//  BoYa
//
//  Created by zhangchao on 13-6-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaTypeModel.h"

@implementation BoyaTypeModel

@synthesize count,typeid,typename;

- (void)dealloc
{
    RELEASEOBJ(count);
    RELEASEOBJ(typeid);
    RELEASEOBJ(typename);
    
    [super dealloc];
}

@end
