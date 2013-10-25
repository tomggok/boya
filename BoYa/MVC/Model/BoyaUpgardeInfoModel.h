//
//  BoyaUpgardeInfoModel.h
//  BoYa
//
//  Created by Hyde.Xu on 13-6-5.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"

@interface BoyaUpgardeInfoModel : DragonJSONReflection{
    NSString *version;
    NSString *downUrl;
    NSString *intro;
}

@property (nonatomic, retain) NSString *version;
@property (nonatomic, retain) NSString *downUrl;
@property (nonatomic, retain) NSString *intro;

@end
