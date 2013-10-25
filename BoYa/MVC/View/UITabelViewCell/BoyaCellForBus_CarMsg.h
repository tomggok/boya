//
//  BoyaCellForBus_CarMsg.h
//  BoYa
//
//  Created by zhangchao on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCustomCell.h"

//公交|停车信息cell
@interface BoyaCellForBus_CarMsg : BoyaCustomCell
{
    DragonUILabel *_lb_title,*_lb_content;
    DragonUIImageView *_imgV_separatorLine/*分割线*/;
}
@end
