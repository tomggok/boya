//
//  BoyaTypeModel.h
//  BoYa
//
//  Created by zhangchao on 13-6-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_JSONReflection.h"

//类型数据
@interface BoyaTypeModel : DragonJSONReflection

@property (nonatomic, retain)NSString *typeid;
@property (nonatomic, retain)NSString *typename;
@property (nonatomic, retain)NSString *count;

@end
