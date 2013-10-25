//
//  BoyaHttpInterface.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoyaHttpInterface : NSObject

+ (NSMutableDictionary *)login:(NSString *)name password:(NSString *)psd isRemeberPsd:(BOOL)isRember;
+ (NSMutableDictionary *)verifyCode:(NSString *)type;
+ (NSMutableDictionary *)uregister:(NSString *)uname password:(NSString *)psd email:(NSString *)mail phone:(NSString *)phone sex:(NSString *)sex area:(NSString *)area;
+ (NSMutableDictionary *)bindPassport:(NSString *)sn studentName:(NSString *)stuName studentPhone:(NSString *)stuPhone school:(NSString *)school class:(NSString *)class QQ:(NSString *)QQ email:(NSString *)email address:(NSString *)address postCode:(NSString *)postCode ParentName:(NSString *)parentName ParentPhone:(NSString *)parentPhone;
+ (NSMutableDictionary *)resetPwd:(NSString *)uname email:(NSString *)mail;
+ (NSMutableDictionary *)upgrade:(NSString *)os version:(NSString *)version;

+ (NSMutableDictionary *)autoLogin:(NSString *)uid logincode:(NSString *)logincode;
+ (NSMutableDictionary *)siteListByType:(NSString *)type/*场馆类型(无类型传"")*/ area:(NSString *)area/*场馆所在区域(无类型传"")*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/;
+ (NSMutableDictionary *)siteTypeAndAreaByType:(NSString *)type/*场馆类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/;
+ (NSMutableDictionary *)ActivityListByType:(NSString *)type/*类型(无类型传"")*/ area:(NSString *)area/*所在区域(无类型传"")*/ time:(NSString *)time/*1 当天 2 周末 3 最近一周*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/;
+ (NSMutableDictionary *)siteCommentListByPlaceid:(NSString *)placeid/*场馆ID*/  last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/;
+ (NSMutableDictionary *) activityType_Area_timeByType:(NSString *)type/*类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/ time:(NSString *)time/*(无类型默认传"")*/;
+ (NSMutableDictionary *)sendSiteCommentByContent:(NSString *)Content placeid:(NSString *)placeid v:(NSString *)v/*场馆综合得分，满分5分*/;
+ (NSMutableDictionary *)myPlaceListByLast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/;
+ (NSMutableDictionary *)getTwoCode:(NSString *)twoCode;

+ (NSMutableDictionary *)activeid:(NSString*)activeid name:(NSString*)name phone:(NSString*)phone school:(NSString*)school class:(NSString*)class QQ:(NSString*)QQ mail:(NSString*)mail;
+ (NSMutableDictionary *)myActiveListBylast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/;
+ (NSMutableDictionary *)getPhotoList:(NSString *)placeid;
@end
