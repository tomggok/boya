//
//  BoyaUpgradeModel.h
//  BoYa
//
//  Created by Hyde.Xu on 13-6-5.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"

@interface BoyaUpgradeModel : DragonJSONReflection{
    NSDictionary *info;
    NSString *new;
}

@property (nonatomic, retain) NSDictionary *info;
@property (nonatomic, retain) NSString *new;

@end
