//
//  BoyaRelatedMeViewController.h
//  BoYa
//
//  Created by zhangchao on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "ASImageScrollView.h"

//与我相关
@interface BoyaRelatedMeViewController : BoyaBaseViewController
{
    DragonUITableView *_tbv_VisitedSite/*浏览过的场馆*/,*_tbv_RegisteredActivity/*已报名的活动*/;
    DragonUIButton *_bt_VisitedSite/*浏览过的场馆*/,*_bt_RegisteredActivity/*已报名的活动*/;
    NSMutableArray *_muA_siteListData/*保存场馆列表数据源*/,*_muA_ActivityListData/*保存活动列表数据源*/;
    ASImageScrollView *_scrollV;
    UIView *_v_noDataBackView/*无数据或无网络时提示按钮的背景*/,*_v_whiteView/*tbv下边的白底*/;
}

@property (nonatomic,retain) DragonUITableView *_tbv_VisitedSite/*浏览过的场馆*/;

@end
