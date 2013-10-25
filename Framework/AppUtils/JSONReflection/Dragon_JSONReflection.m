//
//  Dragon_JSONReflection.m
//  DragonFramework
//
//  Created by NewM on 13-3-18.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"
#import "NSDictionary+JSON.h"
#import "Dragon_Runtime.h"
#import "JSON.h"

@implementation DragonJSONReflection

+ (id)JSONReflection:(id)data
{

    if ([data isKindOfClass:[NSString class]])
    {
        data = [data JSONFragmentValue];
    }
    id class = [(id)[data initDictionaryTo:[self class]] autorelease];
    
    return class;
}

- (void)dealloc
{
    [super dealloc];
}
@end
