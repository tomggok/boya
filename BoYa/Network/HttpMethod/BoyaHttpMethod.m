//
//  BoyaHttpMethod.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaHttpMethod.h"
#import "BoyaHttpInterface.h"
#import "BoyaRequest.h"
#import "BoyaParameter.h"

@implementation BoyaHttpMethod

//登录
+ (DragonRequest *)login:(NSString *)name password:(NSString *)psd isAlert:(BOOL)isAlert isRemberPsd:(BOOL)isRember receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface login:name password:psd isRemeberPsd:isRember];
    [dict setValue:INTERFACENAMELOGIN forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dRe = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dRe;
}

//自动登陆
+ (DragonRequest *)autoLogin:(NSString *)uid logincode:(NSString *)logincode isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface autoLogin:uid logincode:logincode];
    [dict setValue:INTERFACENAMEAUTOLOGIN forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//获取验证码
+ (DragonRequest *)verifyCode:(NSString *)type isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface verifyCode:type];
    [dict setValue:INTERFACENAMEVERIFYCODE forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//用户注册
+ (DragonRequest *)uregister:(NSString *)uname password:(NSString *)psd email:(NSString *)mail phone:(NSString *)phone sex:(NSString *)sex area:(NSString *)area isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface uregister:uname password:psd email:mail phone:phone sex:sex area:area];
    [dict setValue:INTERFACENAMEREGISTER forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//绑定家庭护照
+ (DragonRequest *)bindPassport:(NSString *)sn studentName:(NSString *)stuName studentPhone:(NSString *)stuPhone school:(NSString *)school class:(NSString *)class QQ:(NSString *)QQ email:(NSString *)email address:(NSString *)address postCode:(NSString *)postCode ParentName:(NSString *)parentName ParentPhone:(NSString *)parentPhone isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface bindPassport:sn studentName:stuName studentPhone:stuPhone school:school class:class QQ:QQ email:email address: address postCode:postCode ParentName:parentName ParentPhone:parentPhone];
    [dict setValue:INTERFACENAMEBINDPASSPORT forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//找回密码
+ (DragonRequest *)resetPwd:(NSString *)uname email:(NSString *)mail isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface resetPwd:uname email:mail];
    [dict setValue:INTERFACENAMERESETPWD forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    return dre;
}

//检查版本更新
+ (DragonRequest *)upgrade:(NSString *)os version:(NSString *)version isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface upgrade:os version:version];
    [dict setValue:INTERFACENAMEUPGRADE forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    return dre;
}


//场馆列表
+ (DragonRequest *)siteListByType:(NSString *)type/*场馆类型(无类型传"")*/ area:(NSString *)area/*场馆所在区域(无类型传"")*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface siteListByType:type area:area last:last size:size];
    [dict setValue:INTERFACEPLACELIST forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}


//取我签到的场馆列表
+ (DragonRequest *)myPlaceListByLast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface myPlaceListByLast:last size:size];
    [dict setValue:INTERFACE_place_myPlaceList forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//我报名的活动列表
+ (DragonRequest *)myActiveListBylast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface myActiveListBylast:last size:size];
    [dict setValue:INTERFACE_active_myActiveList forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//取场馆类型和地区关联
+(DragonRequest *)siteTypeAndAreaByType:(NSString *)type/*场馆类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface siteTypeAndAreaByType:type area:area];
    [dict setValue:INTERFACEPLACE_FILTER forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//取取活动类型、地区和日期关联
+(DragonRequest *)activityType_Area_timeByType:(NSString *)type/*类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/ time:(NSString *)time/*(无类型默认传"")*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface activityType_Area_timeByType:type area:area time:time];
    [dict setValue:INTERFACE_Active_FilterList forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//活动列表
+ (DragonRequest *)ActivityListByType:(NSString *)type/*类型(无类型传"")*/ area:(NSString *)area/*所在区域(无类型传"")*/ time:(NSString *)time/*1 当天 2 周末 3 最近一周*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface ActivityListByType:type area:area time:time last:last size:size];
    [dict setValue:INTERFACEActive_ActiveList forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//场馆评论列表
+ (DragonRequest *)siteCommentListByPlaceid:(NSString *)placeid/*场馆ID*/  last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface siteCommentListByPlaceid:placeid last:last size:size];
    [dict setValue:INTERFACEPLACE_commentList forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//提交场馆评论
+ (DragonRequest *)sendSiteCommentByContent:(NSString *)Content placeid:(NSString *)placeid v:(NSString *)v/*场馆综合得分，满分5分*/ isAlert:(BOOL)isAlert receive:(id)receive
{
    NSMutableDictionary *dict = [BoyaHttpInterface sendSiteCommentByContent:Content placeid:placeid v:v];
    [dict setValue:INTERFACE_place_addComment forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//二维码数据
+ (DragonRequest *)getTwoCode:(NSString *)twoCode isAlert:(BOOL)isAlert receive:(id)receive {
    
    NSMutableDictionary *dict = [BoyaHttpInterface getTwoCode:twoCode];
    [dict setValue:INTERFACENAMEGETTWOCODE forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//报名信息
+ (DragonRequest*)activeid:(NSString*)activeid name:(NSString*)name phone:(NSString*)phone school:(NSString*)school class:(NSString*)class QQ:(NSString*)QQ mail:(NSString*)mail isAlert:(BOOL)isAlert receive:(id)receive {
    
    NSMutableDictionary *dict = [BoyaHttpInterface activeid:activeid name:name phone:phone school:school class:class QQ:QQ mail:mail];
    [dict setValue:INTERFACENAME_SIGNUP forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

//获取场馆的照片列表
+ (DragonRequest *)getPhotoList:(NSString *)placeid isAlert:(BOOL)isAlert receive:(id)receive {
    
    NSMutableDictionary *dict = [BoyaHttpInterface getPhotoList:placeid];
    [dict setValue:INTERFACEPHOTOLIST forKey:INTERFACEDOACTION];
    BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
    DragonRequest *dre = [request BOYAGET:dict isAlert:isAlert receive:receive];
    
    return dre;
}

@end
