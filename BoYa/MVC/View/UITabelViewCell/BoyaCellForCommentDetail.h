//
//  BoyaCellForCommentDetail.h
//  BoYa
//
//  Created by zhangchao on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCustomCell.h"

//评论详情cell
@interface BoyaCellForCommentDetail : BoyaCustomCell
{
    DragonUILabel *_lb_name,*_lb_time,*_lb_content;
    DragonUIImageView *_imgV_separatorLine/*分割线*/;
    UIView *_v_score/*五颗星的背景*/;
    NSMutableArray *_muA_imgV_score;
}
@end
