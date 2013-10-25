//
//  SJLoginModel.h
//  ShangJiaoYuXin
//
//  Created by NewM on 13-5-6.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"


@interface BoyaLoginModel : DragonJSONReflection
{
    NSString *ssid;
    NSDictionary *uinfo;
}
@property (nonatomic, retain)NSString *ssid;//用户ID
@property (nonatomic, retain)NSDictionary *uinfo;//唯一登录标示

@end
