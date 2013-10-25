//
//  BoyaUpgradeModel.m
//  BoYa
//
//  Created by Hyde.Xu on 13-6-5.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaUpgradeModel.h"

@implementation BoyaUpgradeModel
@synthesize info, new;

- (void)dealloc
{
    RELEASEOBJ(new);
    RELEASEDICTARRAYOBJ(info);
    [super dealloc];
}


@end
