//
//  BoyaHttpInterface.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaHttpInterface.h"
#import "BoyaParameter.h"

@implementation BoyaHttpInterface

//登陆接口(改key的时候一定要改sjrequest中的key)
+ (NSMutableDictionary *)login:(NSString *)name password:(NSString *)psd isRemeberPsd:(BOOL)isRember
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:name, @"uname", psd, @"pwd", nil] autorelease];
}

//获取验证码
+ (NSMutableDictionary *)verifyCode:(NSString *)type{
     return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:type, @"password", nil] autorelease];
}

//注册
+ (NSMutableDictionary *)uregister:(NSString *)uname password:(NSString *)psd email:(NSString *)mail phone:(NSString *)phone sex:(NSString *)sex area:(NSString *)area{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:uname, @"uname", psd, @"pwd",  mail, @"mail", phone, @"phone", sex, @"sex", area, @"area",nil] autorelease];
}

//绑定护照
+ (NSMutableDictionary *)bindPassport:(NSString *)sn studentName:(NSString *)stuName studentPhone:(NSString *)stuPhone school:(NSString *)school class:(NSString *)class QQ:(NSString *)QQ email:(NSString *)email address:(NSString *)address postCode:(NSString *)postCode ParentName:(NSString *)parentName ParentPhone:(NSString *)parentPhone{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:sn, @"sn", stuName, @"stuName", stuPhone, @"stuPhone",  school, @"school", class, @"class", QQ, @"QQ", email, @"email", address, @"address", postCode, @"postCode", parentName, @"parentName", parentPhone, @"parentPhone", nil] autorelease];
}

//找回密码
+ (NSMutableDictionary *)resetPwd:(NSString *)uname email:(NSString *)mail{
     return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:uname, @"uname", mail, @"mail", nil] autorelease];
}

//版本更新
+ (NSMutableDictionary *)upgrade:(NSString *)os version:(NSString *)version{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:os, @"os", version, @"version", nil] autorelease];
}


//自动登陆
+ (NSMutableDictionary *)autoLogin:(NSString *)uid logincode:(NSString *)logincode
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:uid, @"a", logincode, @"b", nil] autorelease];
}

//场馆列表
+ (NSMutableDictionary *)siteListByType:(NSString *)type/*场馆类型(无类型传"")*/ area:(NSString *)area/*场馆所在区域(无类型传"")*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:type, @"type", area, @"area", last, @"last", size, @"size", nil] autorelease];
}

//取我签到的场馆列表
+ (NSMutableDictionary *)myPlaceListByLast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/ 
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys: last, @"last", size, @"size", nil] autorelease];
}

//我报名的活动列表
+ (NSMutableDictionary *)myActiveListBylast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys: last, @"last", size, @"size", nil] autorelease];
}

//取场馆类型和地区关联
+ (NSMutableDictionary *)siteTypeAndAreaByType:(NSString *)type/*场馆类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:type, @"type", area, @"area", nil] autorelease];
}

//取取活动类型、地区和日期关联
+ (NSMutableDictionary *) activityType_Area_timeByType:(NSString *)type/*类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/ time:(NSString *)time/*(无类型默认传"")*/
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:type, @"type", area, @"area",time,@"time", nil] autorelease];
}


//活动列表
+ (NSMutableDictionary *)ActivityListByType:(NSString *)type/*类型(无类型传"")*/ area:(NSString *)area/*所在区域(无类型传"")*/ time:(NSString *)time/*1 当天 2 周末 3 最近一周*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:type, @"type", area, @"area", time, @"time",last, @"last", size, @"size", nil] autorelease];
}

//场馆评论列表
+ (NSMutableDictionary *)siteCommentListByPlaceid:(NSString *)placeid/*场馆ID*/  last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:placeid, @"placeid",last, @"last", size, @"size", nil] autorelease];
}

//提交场馆评论
+ (NSMutableDictionary *)sendSiteCommentByContent:(NSString *)Content placeid:(NSString *)placeid v:(NSString *)v/*场馆综合得分，满分5分*/
{
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:Content, @"content",placeid,@"placeid", v,@"v",nil] autorelease];
}

//二维码
+ (NSMutableDictionary *)getTwoCode:(NSString *)twoCode {
    
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:twoCode, @"code", nil] autorelease];
}

//报名信息
+ (NSMutableDictionary *)activeid:(NSString*)activeid name:(NSString*)name phone:(NSString*)phone school:(NSString*)school class:(NSString*)class QQ:(NSString*)QQ mail:(NSString*)mail {
    
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:activeid, @"activeid",name, @"name", phone, @"phone", school, @"school", class, @"class", QQ, @"QQ", mail, @"mail",nil] autorelease];
}

//场馆照片列表
+ (NSMutableDictionary *)getPhotoList:(NSString *)placeid{
    
    return [[[NSMutableDictionary alloc] initWithObjectsAndKeys:placeid, @"placeid", nil] autorelease];
}


@end
