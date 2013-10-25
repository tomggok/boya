//
//  BoyaHttpMethod.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DragonRequest;

@interface BoyaHttpMethod : NSObject

+ (DragonRequest *)login:(NSString *)name password:(NSString *)psd isAlert:(BOOL)isAlert isRemberPsd:(BOOL)isRember receive:(id)receive;
+ (DragonRequest *)verifyCode:(NSString *)type isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)uregister:(NSString *)uname password:(NSString *)psd email:(NSString *)mail phone:(NSString *)phone sex:(NSString *)sex area:(NSString *)area isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)bindPassport:(NSString *)sn studentName:(NSString *)stuName studentPhone:(NSString *)stuPhone school:(NSString *)school class:(NSString *)class QQ:(NSString *)QQ email:(NSString *)email address:(NSString *)address postCode:(NSString *)postCode ParentName:(NSString *)parentName ParentPhone:(NSString *)parentPhone isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)resetPwd:(NSString *)uname email:(NSString *)mail isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)upgrade:(NSString *)os version:(NSString *)version isAlert:(BOOL)isAlert receive:(id)receive;

+ (DragonRequest *)autoLogin:(NSString *)uid logincode:(NSString *)logincode isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)siteListByType:(NSString *)type/*场馆类型(无类型传"")*/ area:(NSString *)area/*场馆所在区域(无类型传"")*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive;
+(DragonRequest *)siteTypeAndAreaByType:(NSString *)type/*场馆类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/ isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)ActivityListByType:(NSString *)type/*类型(无类型传"")*/ area:(NSString *)area/*所在区域(无类型传"")*/ time:(NSString *)time/*1 当天 2 周末 3 最近一周*/ last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)siteCommentListByPlaceid:(NSString *)placeid/*场馆ID*/  last:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive;
+(DragonRequest *)activityType_Area_timeByType:(NSString *)type/*类型(无类型默认传"")*/ area:(NSString *)area/*所在区域(无类型默认传"")*/ time:(NSString *)time/*(无类型默认传"")*/ isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)sendSiteCommentByContent:(NSString *)Content placeid:(NSString *)placeid v:(NSString *)v/*场馆综合得分，满分5分*/ isAlert:(BOOL)isAlert receive:(id)receive;

+ (DragonRequest *)getTwoCode:(NSString *)twoCode isAlert:(BOOL)isAlert receive:(id)receive;


+ (DragonRequest*)activeid:(NSString*)activeid name:(NSString*)name phone:(NSString*)phone school:(NSString*)school class:(NSString*)class QQ:(NSString*)QQ mail:(NSString*)mail isAlert:(BOOL)isAlert receive:(id)receive;

+ (DragonRequest *)myPlaceListByLast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive;
+ (DragonRequest *)myActiveListBylast:(NSString *)last/*加载更多时传列表里最下边的场馆的orderid,刷新或加载第一页时传0*/ size:(NSString *)size/*每次请求几个数据(默认5个)*/ isAlert:(BOOL)isAlert receive:(id)receive;

+ (DragonRequest *)getPhotoList:(NSString *)placeid isAlert:(BOOL)isAlert receive:(id)receive;

@end
