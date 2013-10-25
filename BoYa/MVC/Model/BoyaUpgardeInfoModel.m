//
//  BoyaUpgardeInfoModel.m
//  BoYa
//
//  Created by Hyde.Xu on 13-6-5.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaUpgardeInfoModel.h"

@implementation BoyaUpgardeInfoModel
@synthesize version, downUrl, intro;

- (void)dealloc
{
    RELEASEOBJ(version);
    RELEASEOBJ(downUrl);
    RELEASEOBJ(intro);
    [super dealloc];
}

@end
