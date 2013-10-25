//
//  BoyaLoginRequestModel.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-31.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"

@interface BoyaLoginRequestModel : DragonJSONReflection

@property (nonatomic, retain)NSString *uname;
@property (nonatomic, retain)NSString *pwd;
@property (nonatomic, retain)NSString *c;

@end
