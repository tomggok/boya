//
//  BoyaSiteViewController.h
//  BoYa
//
//  Created by zhangchao on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "Dragon_UITableView.h"
#import "BoyaSINavigationMenuView.h"
#import "ASImageScrollView.h"

//场馆
@interface BoyaSiteViewController : BoyaBaseViewController
{
    DragonUITableView *_tbv;
    BoyaSINavigationMenuView *_menu_allType/*全部类别*/,*_menu_allArea/*全部区县*/;
    NSMutableArray *_muA_siteListData/*保存场馆列表数据源*/,*_muA_areaList,*_muA_typeList;
    NSString *_str_areaID/*当前场馆列表的地区ID,没选默认空字符串*/,*_str_typeID/*当前场馆列表的类型ID,没选默认空字符串*/;
    
    ASImageScrollView *_scrollV;
    UIView *_v_noDataBackView;//无数据或无网络时提示按钮的背景
}
@end
