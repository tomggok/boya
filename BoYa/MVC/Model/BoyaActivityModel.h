//
//  BoyaActivityModel.h
//  BoYa
//
//  Created by zhangchao on 13-6-1.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_JSONReflection.h"

@interface BoyaActivityModel : DragonJSONReflection

//@property (nonatomic, retain)NSString *ac_active;//
@property (nonatomic, retain)NSString *ac_addr;
@property (nonatomic, retain)NSString *ac_area;
@property (nonatomic, retain)NSString *ac_descrpit;
@property (nonatomic, retain)NSString *ac_endtime;//活动结束时间
@property (nonatomic, retain)NSString *ac_flag;//1 即将开始  2 正在进行     3 已经结束
@property (nonatomic, retain)NSString *ac_id;
//@property (nonatomic, retain)NSString *ac_number;
//@property (nonatomic, retain)NSString *ac_organizers;//
//@property (nonatomic, retain)NSString *ac_place;
@property (nonatomic, retain)NSString *ac_regtime;//报名截止时间
@property (nonatomic, retain)NSString *ac_sigup_number;
@property (nonatomic, retain)NSString *ac_siguptime;//报名开始时间
@property (nonatomic, retain)NSString *ac_time;//活动开始时间
@property (nonatomic, retain)NSString *ac_title;
//@property (nonatomic, retain)NSString *ac_top;
@property (nonatomic, retain)NSString *ac_type;
//@property (nonatomic, retain)NSString *ac_uid;
@property (nonatomic, retain)NSString *orderid;
@property (nonatomic, retain)NSString *pic;
@property (nonatomic, assign)int isMyActive;//1: 已报名  2:未报名

@end
