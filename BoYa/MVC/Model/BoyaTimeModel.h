//
//  BoyaTimeModel.h
//  BoYa
//
//  Created by zhangchao on 13-6-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_JSONReflection.h"

//时间数据
@interface BoyaTimeModel : DragonJSONReflection

@property (nonatomic, retain)NSString *timeid;
@property (nonatomic, retain)NSString *timename;
@property (nonatomic, retain)NSString *count;

@end
