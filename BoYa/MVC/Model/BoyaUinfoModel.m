//
//  BoyaUinfoModel.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-31.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaUinfoModel.h"

@implementation BoyaUinfoModel
@synthesize bindPassport, uname, area, areaname, mail, phone, sex, sexname, uid, class, QQ, school, urealname;

- (void)dealloc{
    RELEASEOBJ(bindPassport);
    RELEASEOBJ(uname);
    RELEASEOBJ(area);
    RELEASEOBJ(areaname);
    RELEASEOBJ(mail);
    RELEASEOBJ(phone);
    RELEASEOBJ(sex);
    RELEASEOBJ(sexname);
    RELEASEOBJ(uid);
    RELEASEOBJ(QQ);
    RELEASEOBJ(class);
    RELEASEOBJ(school);
    RELEASEOBJ(urealname);
    
    [super dealloc];
}


@end
