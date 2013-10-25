//
//  BoyaSiteModel.m
//  BoYa
//
//  Created by zhangchao on 13-5-31.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaSiteModel.h"

@implementation BoyaSiteModel

@synthesize bus,cover,orderid,place_address,stop,Place_content,Place_id,Place_name,place_phone,place_time,star/*,_imgV_showImg*/;

- (void)dealloc
{
    RELEASEOBJ(bus);
    RELEASEOBJ(cover);
//    RELEASEOBJ(list);
    RELEASEOBJ(orderid);
    RELEASEOBJ(place_address);
    RELEASEOBJ(Place_content);
//    RELEASEOBJ(place_desc);
    RELEASEOBJ(Place_id);
//    RELEASEOBJ(Place_link);
    RELEASEOBJ(Place_name);
    RELEASEOBJ(place_phone);
    RELEASEOBJ(place_time);
//    RELEASEOBJ(place_top);
//    RELEASEOBJ(place_type);
//    RELEASEOBJ(Place_video_url);
//    RELEASEOBJ(sign_code);
//    RELEASEOBJ(sign_count);
    RELEASEOBJ(star);
    RELEASEOBJ(stop);
//    RELEASEOBJ(top_ten);
//    RELEASEOBJ(_imgV_showImg);

    [super dealloc];
}
@end
