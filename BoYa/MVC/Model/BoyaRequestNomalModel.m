//
//  BoyaRequestNomalModel.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-30.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaRequestNomalModel.h"

@implementation BoyaRequestNomalModel
@synthesize a,b,c,d,e,f,g,h,i,j,k;

- (void)dealloc
{
    RELEASEOBJ(a);
    RELEASEOBJ(b);
    RELEASEOBJ(c);
    RELEASEOBJ(d);
    RELEASEOBJ(e);
    RELEASEOBJ(f);
    RELEASEOBJ(g);
    RELEASEOBJ(h);
    RELEASEOBJ(i);
    RELEASEOBJ(j);
    RELEASEOBJ(k);
    [super dealloc];
}
@end
