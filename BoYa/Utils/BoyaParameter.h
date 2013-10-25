//
//  BoyaParameter.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

//sharedinstaceDlegate
#undef SHARED
#define SHARED  [BoyaSharedInstaceDelegate sharedInstace]

#undef APPDELEGATE
#define APPDELEGATE  ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//HTTPURL
//////////////////////
#undef TESTURL
#define TESTURL @"http://10.21.118.246/dianping/api4c"

#undef TESTURL2
#define TESTURL2 @"http://10.21.3.110/dianping/api4c"

#undef TESTURL_TEST
#define TESTURL_TEST @"http://10.21.3.110/dianping/api4c"

#undef TESTURL_Main
#define TESTURL_Main @"http://www.21boya.cn/dianping/api4c"

/////////////////////接口
#undef INTERFACEDOACTION
#define INTERFACEDOACTION   @"interfacedoaction"

#undef INTERFACENAMESSID
#define INTERFACENAMESSID  @"ssid"  //也是数据库表名

#undef INTERFACENAMELOGIN
#define INTERFACENAMELOGIN  @"user_login"  //也是数据库表名

#undef INTERFACENAMEAUTOLOGIN
#define INTERFACENAMEAUTOLOGIN  @"auto_login"
#undef INTERFACENAMELOGOUT
#define INTERFACENAMELOGOUT @"logout"
#undef INTERFACENAMERESETPASSWORD
#define INTERFACENAMERESETPASSWORD @"replay_pwd"
#undef INTERFACENAMECHANGEPASSWORD
#define INTERFACENAMECHANGEPASSWORD @"change_pwd"

#undef INTERFACENAMEVERIFYCODE
#define INTERFACENAMEVERIFYCODE  @"common_verifyCode"//获取验证码

#undef INTERFACENAMEBINDPASSPORT
#define INTERFACENAMEBINDPASSPORT  @"place_bindPassport"//绑定家庭护照

#undef INTERFACENAMEREGISTER
#define INTERFACENAMEREGISTER @"user_register"//用户注册

#undef INTERFACENAMERESETPWD
#define INTERFACENAMERESETPWD @"user_resetPwd"//找回密码

#undef INTERFACENAMEUPGRADE
#define INTERFACENAMEUPGRADE @"common_upgrade"//找回密码

#undef INTERFACEPLACELIST
#define INTERFACEPLACELIST  @"place_placeList"//场馆列表

#undef INTERFACE_place_myPlaceList
#define INTERFACE_place_myPlaceList  @"place_myPlaceList"//取我签到的场馆列表

#undef INTERFACE_active_myActiveList
#define INTERFACE_active_myActiveList  @"active_myActiveList"//取我报名的活动列表

#undef INTERFACEPLACE_commentList
#define INTERFACEPLACE_commentList  @"place_commentList"//场馆评论列表

#undef INTERFACE_place_addComment
#define INTERFACE_place_addComment  @"place_addComment"//提交场馆评论

#undef INTERFACENAMEGETTWOCODE
#define INTERFACENAMEGETTWOCODE  @"place_sign"//二维码

#undef INTERFACENAME_SIGNUP
#define INTERFACENAME_SIGNUP  @"active_signUp"//报名信息

#undef INTERFACEPHOTOLIST
#define INTERFACEPHOTOLIST  @"place_photoList"//场馆照片列表

#undef INTERFACEActive_ActiveList
#define INTERFACEActive_ActiveList  @"active_activeList"//活动列表

#undef INTERFACEPLACE_FILTER
#define INTERFACEPLACE_FILTER  @"place_filterList"//取场馆类型和地区关联

#undef INTERFACE_Active_FilterList
#define INTERFACE_Active_FilterList  @"active_filterList"//取场馆类型和地区关联

#undef  DATABASEMAILLASTID
#define DATABASEMAILLASTID       @"lastID" //列表的最下边那条数据ID

#undef DATABASELOGINNAME
#define DATABASELOGINNAME           @"name"

#undef DATABASELOGINDATE
#define DATABASELOGINDATE           @"date"

#undef DATABASELOGINLOGINTYPE
#define DATABASELOGINLOGINTYPE      @"logintype"

#undef  DATABASELOGINRESPONSE
#define DATABASELOGINRESPONSE       @"response"

#undef DATABASELOGINCOTENT
#define DATABASELOGINCOTENT         @"content"

//////////////////////common//////////////////////////////
#undef  BoyaHEADERTITLEFONT
#define BoyaHEADERTITLEFONT       22

#undef  BoyaHEADERRIGHTFONT
#define BoyaHEADERRIGHTFONT       18

#undef  BoyaINFOTITLEFONT
#define BoyaINFOTITLEFONT         13

#undef  BoyaINFOSETTINGFONT
#define BoyaINFOSETTINGFONT         16

#undef  BoyaINFOSETTINGVERSIONFONT
#define BoyaINFOSETTINGVERSIONFONT   14

#undef k_PageSize
#define k_PageSize @"10" //分页大小,每次请求的数据条数

//////////////////////BoyaLoginViewController///////////////
#undef  BoyaLOGININPUTPLACEHOLDER
#define BoyaLOGININPUTPLACEHOLDER      16

#undef  BoyaLOGINTEXTFONT
#define BoyaLOGINTEXTFONT              16


#undef  Boya_H_TOPTAB
#define Boya_H_TOPTAB 35 //tbv上边的选项卡的高度

#define k_noData @"暂无数据,点击加载"


//==================================通用UI相关宏=========================================

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]
#define k_W_moveOffsetX 50 //view向右移动的偏移量
#define screen  [[UIScreen mainScreen]bounds]//整个物理屏幕的边界,包括状态栏在内,viewController.frame等于此,因为屏幕翻转时是viewController负责转换包括状态栏的所有视图和控件,所以视图控制器包括状态栏
#define screenShows [[UIScreen mainScreen]applicationFrame]//整个屏幕的可显示区域,在顶部状态下边,不包括状态栏那20的高,常用于设置UIView.frame
#define keyBoardSizeForIpad  CGSizeMake(screen.size.width, 768/2) //横屏时ipad上的keyboard的size
#define keyBoardSizeForIp  CGSizeMake(screen.size.width, 216) //竖屏时ip上的keyboard的size
#define kH_UINavigationController 45 //顶部导航栏的高
#define kH_UITabBarController 47 //底部标签栏控制器的高
#define kH_UISearchBar 44//搜索栏的高
#define kH_UIPickerView 216//选取器高
#define kH_StateBar 20//顶部状态栏高
#define kSeconds_pre_year (60*60*24*365ul) //一年有多少秒,后边加ul是因为计算结果在16位电脑上会溢出,故表明此结果是无符号的长整数
#define k_icon_iphone 57 //iphone应用程序图标默认大小,4s以上的翻倍
#define k_icon_ipad2 72 //Ipad2应用程序图标默认大小
#define k_icon_ipad3 144 //Ipad3应用程序图标默认大小
#define kH_cellDefault 44 //默认cell的高
#define kH_tbvForHeaderViewInSection 22 //tbv某section的titleView的默认高,可通过 - (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section 及 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section 改变样式和高
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)
#define kH_CellSelColor [DragonCommentMethod color:221 green:254 blue:255 alpha:1.f] //cell选中颜色
