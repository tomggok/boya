//
//  BoyaUinfoModel.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-31.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_JSONReflection.h"

@interface BoyaUinfoModel : DragonJSONReflection{
    NSString *bindPassport;
    NSString *uid;
    NSString *sexname;
    NSString *area;
    NSString *phone;
    NSString *mail;
    NSString *uname;
    NSString *sex;
    NSString *areaname;
    NSString *QQ;
    NSString *class;
    NSString *school;
    NSString *urealname;
}

@property (nonatomic, retain)NSString *bindPassport;
@property (nonatomic, retain)NSString *uid;
@property (nonatomic, retain)NSString *sexname;
@property (nonatomic, retain)NSString *area;
@property (nonatomic, retain)NSString *phone;
@property (nonatomic, retain)NSString *mail;
@property (nonatomic, retain)NSString *uname;
@property (nonatomic, retain)NSString *sex;
@property (nonatomic, retain)NSString *areaname;
@property (nonatomic, retain)NSString *QQ;
@property (nonatomic, retain)NSString *class;
@property (nonatomic, retain)NSString *school;
@property (nonatomic, retain)NSString *urealname;


@end
