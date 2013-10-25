//
//  target.m
//  magic
//
//  Created by tom zeng on 12-11-10.
//
//

#import "target.h"

@implementation target

@synthesize type;
@synthesize targetid;
@synthesize targetlink;
@synthesize targetname;
@synthesize id;

- (void)dealloc
{
    [type release];
    [targetid release];
    [targetlink release];
    [targetname release];
    [super dealloc];
}
@end
