//
//  BoyaAreaModel.h
//  BoYa
//
//  Created by zhangchao on 13-6-2.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_JSONReflection.h"

//区域对象数据
@interface BoyaAreaModel : DragonJSONReflection

@property (nonatomic, retain)NSString *areaid;//
@property (nonatomic, retain)NSString *areaname;
@property (nonatomic, retain)NSString *count;

@end
