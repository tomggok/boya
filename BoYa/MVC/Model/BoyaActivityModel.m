//
//  BoyaActivityModel.m
//  BoYa
//
//  Created by zhangchao on 13-6-1.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaActivityModel.h"

@implementation BoyaActivityModel

@synthesize orderid,ac_addr,ac_area,ac_descrpit,ac_endtime,ac_id,ac_sigup_number,ac_time,ac_title,pic,ac_siguptime,ac_flag,ac_regtime,ac_type,isMyActive;

- (void)dealloc
{
    RELEASEOBJ(orderid);
//    RELEASEOBJ(_imgV_showImg);
//    RELEASEOBJ(ac_active);
    RELEASEOBJ(ac_addr);
    RELEASEOBJ(ac_area);
    RELEASEOBJ(ac_descrpit);
    RELEASEOBJ(ac_endtime);
    RELEASEOBJ(ac_flag);
    RELEASEOBJ(ac_id);
//    RELEASEOBJ(ac_number);
//    RELEASEOBJ(ac_organizers);
//    RELEASEOBJ(ac_place);
    RELEASEOBJ(ac_regtime);
    RELEASEOBJ(ac_sigup_number);
    RELEASEOBJ(ac_time);
    RELEASEOBJ(ac_title);
//    RELEASEOBJ(ac_top);
    RELEASEOBJ(ac_type);
//    RELEASEOBJ(ac_uid);
    RELEASEOBJ(pic);
    RELEASEOBJ(ac_siguptime);

    [super dealloc];
}

@end
