//
//  SJLoginModel.m
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-6.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaLoginModel.h"

@implementation BoyaLoginModel
@synthesize ssid,uinfo;


- (void)dealloc
{
    RELEASEOBJ(ssid);
    RELEASEOBJ(uinfo);
    [super dealloc];
}
@end
