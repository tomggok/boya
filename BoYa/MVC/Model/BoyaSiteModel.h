//
//  BoyaSiteModel.h
//  BoYa
//
//  Created by zhangchao on 13-5-31.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_JSONReflection.h"
#import "UIImageView+WebCache.h"

//场馆数据
@interface BoyaSiteModel : DragonJSONReflection

@property (nonatomic, retain)NSString *Place_content;//场馆描述
@property (nonatomic, retain)NSString *Place_id;
//@property (nonatomic, retain)NSString *Place_link;
@property (nonatomic, retain)NSString *Place_name;
@property (nonatomic, retain)NSString *bus;//公交信息
//@property (nonatomic, retain)NSString *Place_video_url;
@property (nonatomic, retain)NSString *cover;
//@property (nonatomic, retain)NSString *list;
@property (nonatomic, retain)NSString *orderid;//在场馆列表里的index
@property (nonatomic, retain)NSString *place_address;
//@property (nonatomic, retain)NSString *place_desc;
@property (nonatomic, retain)NSString *place_phone;
@property (nonatomic, retain)NSString *place_time;
//@property (nonatomic, retain)NSString *place_top;
//@property (nonatomic, retain)NSString *place_type;
//@property (nonatomic, retain)NSString *sign_code;
//@property (nonatomic, retain)NSString *sign_count;
@property (nonatomic, retain)NSString *star;
@property (nonatomic, retain)NSString *stop;
//@property (nonatomic, retain)NSString *top_ten;
//@property (nonatomic,retain) UIImageView *_imgV_showImg;//展示图

@end
