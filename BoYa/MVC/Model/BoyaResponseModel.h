//
//  SJResponseModel.h
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-6.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"

@interface BoyaResponseModel : DragonJSONReflection
{
    NSDictionary *data;
    NSString *message;
    NSString *code;
}

@property (nonatomic, retain)NSDictionary *data;
@property (nonatomic, retain)NSString *message;
@property (nonatomic, retain)NSString *code;

@end
