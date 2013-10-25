//
//  BoyaActivityViewController.h
//  BoYa
//
//  Created by zhangchao on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "Dragon_UITableView.h"
#import "BoyaSINavigationMenuView.h"
#import "ASImageScrollView.h"

//活动
@interface BoyaActivityViewController : BoyaBaseViewController
{
    DragonUITableView *_tbv;
    BoyaSINavigationMenuView *_menu_allType/*全部类别*/,*_menu_allArea/*全部区县*/,*_menu_startTime/*开始时间*/;
    NSMutableArray *_muA_ActivityListData/*保存活动列表数据源*/,*_muA_areaList,*_muA_typeList,*_muA_timeList;
    NSString *_str_areaID/*当前列表的地区ID,没选默认空字符串*/,*_str_typeID/*当前列表的类型ID,没选默认空字符串*/,*_str_timeID/*当前列表的时间ID,没选默认空字符串*/;
    ASImageScrollView *_scrollV;
    UIView *_v_noDataBackView;//无数据或无网络时提示按钮的背景

}

@property (nonatomic,retain)     DragonUITableView *_tbv;

@end
