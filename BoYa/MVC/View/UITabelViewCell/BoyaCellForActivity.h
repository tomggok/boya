//
//  BoyaCellForActivity.h
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCustomCell.h"

//活动cell
@interface BoyaCellForActivity : BoyaCustomCell
{
    DragonUILabel *_lb_name,*_lb_adress,*_lb_time/*发送或接收时间*/,*_lb_sigUptime/*报名截止时间*/,*_lb_numberOfRegistration/*报名人数*/,*_lb_mingrenshu;
    DragonUIImageView *_imgV_time,*_imgV_adress/*地址图标*/,*_imgV_separatorLine/*分割线*/,*_imgV_showImg,*_imgV_flag/*1 即将开始  2 正在进行   3 已经结束*/;
}
@end
