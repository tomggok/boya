//
//  BoyaRequestModel.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-30.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"

@interface BoyaRequestModel : DragonJSONReflection

@property (nonatomic, retain)NSDictionary *data;
@property (nonatomic, retain)NSString *doaction;
@property (nonatomic, retain)NSString *logincode;
@property (nonatomic, retain)NSString *identify;

@end
