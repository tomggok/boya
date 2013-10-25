//
//  BoyaCellForActivityDetail.h
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCustomCell.h"

//活动详情页的活动介绍cell|场馆详情页的场馆描述cell
@interface BoyaCellForActivityDetail : BoyaCustomCell
{
    DragonUILabel *_lb_IntroductionOfActivities/*活动介绍|场馆描述lb*/,*_lb_IntroductionOfActivitiesContent/*活动介绍|场馆描述内容*/;
    DragonUIImageView *_imgV_separatorLine/*分割线*/;

}
@end
