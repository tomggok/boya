//
//  BoyaRequestModel.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-30.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaRequestModel.h"

@implementation BoyaRequestModel
@synthesize data, doaction, identify, logincode;

- (void)dealloc
{
    RELEASEOBJ(data);
    RELEASEOBJ(doaction);
    RELEASEOBJ(identify);
    RELEASEOBJ(logincode);
    
    [super dealloc];
}

@end
