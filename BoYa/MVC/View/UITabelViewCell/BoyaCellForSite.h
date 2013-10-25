//
//  BoyaCellForSite.h
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCustomCell.h"

//场馆列表的cell
@interface BoyaCellForSite : BoyaCustomCell
{
    DragonUILabel *_lb_name,*_lb_adress,*_lb_time/*发送或接收时间*/,*_lb_call;
    DragonUIImageView *_imgV_time,*_imgV_adress/*地址图标*/,*_imgV_call,*_imgV_separatorLine/*分割线*/,*_imgV_showImg;
}

@property (nonatomic,retain) DragonUIImageView *_imgV_showImg;
@end
