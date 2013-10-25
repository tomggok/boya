//
//  BoyaRequest.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaRequest.h"
#import "NSObject+DragonRequestResponder.h"
#import "Dragon_Device.h"
#import "BoyaParameter.h"
#import "JSON.h"
#import "Dragon_CommentMethod.h"
#import "BoyaSharedInstaceDelegate.h"
#import "Dragon_Device.h"
#import "BoyaResponseModel.h"
#import "BoyaRequestModel.h"
#import "NSObject+DragonDatabase.h"
#import "AppDelegate.h"
#import "Dragon_NaviGroupViewController.h"
#import "Dragon_NavigationController.h"
#import "BoyaSiteModel.h"
#import "BoyaNoticeView.h"

@implementation BoyaRequest

- (void)dealloc
{
    RELEASEDICTARRAYOBJ(requestData);
    RELEASEOBJ(receive);
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (DragonRequest *)BOYAGET:(NSMutableDictionary *)params isAlert:(BOOL)isAlert receive:(id)_receive
{
    if ([DragonDevice hasInternetConnection] == NO) {
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:@"请求失败，请检查网络！"];
        return nil;
    }

    NSString *url = [self httpUrl:params];
    DragonRequest *request = [self GET:url];
    
    if ([DragonDevice sysVersion] == 5.0)
    {
        [request setValidatesSecureCertificate:NO];
    }
    

    BoyaRequestModel *sjReq = [BoyaRequestModel JSONReflection:requestData];
    
    [request setDict_userInfo:requestData];
    [request setUserInfoObj:sjReq];
    
    
    RELEASEDICTARRAYOBJ(requestData);
    
    receive = [_receive retain];
    
    if (isAlert)
    {
        httpRequestView = [[BoyaNoticeView alloc] init];
        [httpRequestView setNoticeText:@"加载中..." withType:DRAGONPOPALERTVIEWINDICATOR];
    }
    
    return request;
}

- (void)handleRequest:(DragonRequest *)request{
//    DLogInfo(@"request.responseString ==== %@", request.responseString);
    //取消锁屏幕
    if ([receive isKindOfClass:[UIView class]])
    {
        [(UIView *)receive setUserInteractionEnabled:YES];
    }else if ([receive isKindOfClass:[UIViewController class]])
    {
        [[(UIViewController *)receive view] setUserInteractionEnabled:YES];
    }
    
    if (request.succeed || request.failed)
    {
        if (httpRequestView)
        {
            [httpRequestView hudWasHidden];
            RELEASEOBJ(httpRequestView);
        }
    }
    
    if (request.succeed)
    {
        NSDictionary *dict = [request.responseString JSONValue];
        BoyaResponseModel *response = [BoyaResponseModel JSONReflection:dict];
        
        //        [response setResponse:@"201"];
        if (SHARED.isForceUpdate)//强制升级
        {
//            [response setResponse:@"202"];
        }
        
        DragonUIAlertView *alert = nil;
        if ([[response code] isEqualToString:@"222"] || [[response code] isEqualToString:@"211"])
        {//session过期
            [request cancelRequests];//取消其他全部的请求的请求
            
            alert = [[[DragonUIAlertView alloc] initWithTitle:@"提示"
                                                      message:response.message
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil] autorelease];
            [alert setTag:1];
            
            [alert show];
//        }else if ([[response code] isEqualToString:@"201"])
//        {//提示用户新版更新
//            //            [request cancelRequests];//取消其他全部的请求的请求]
//            
//            alert = [[[DragonUIAlertView alloc] initWithTitle:@"提示"
//                                                      message:response.message
//                                                     delegate:self
//                                            cancelButtonTitle:@"取消"
//                                            otherButtonTitles: @"确定",nil] autorelease];
//            [alert setTag:2];
//            [alert show];
//            [BoyaSharedInstaceDelegate sharedInstace].forceUpdateText=[response.data objectForKey:@"url"];
//            
//        }else if ([[response code] isEqualToString:@"202"])
//        {//强制更新
//            if (response.message && response.message.length > 0)
//            {
//                SHARED.forceUpdateText = response.message;
//            }
//            
//            SHARED.isForceUpdate = YES;
//            [request cancelRequests];//取消其他全部的请求
//            alert = [[[DragonUIAlertView alloc] initWithTitle:@"提示"
//                                                      message:SHARED.forceUpdateText
//                                                     delegate:self
//                                            cancelButtonTitle:@"确定"
//                                            otherButtonTitles: nil] autorelease];
//            [alert setTag:3];
//            [alert show];
//            [BoyaSharedInstaceDelegate sharedInstace].forceUpdateText=[response.data objectForKey:@"url"];
        }else
        {//101和100状态
            if (receive && [receive respondsToSelector:@selector(handleRequest:receiveObj:)])
            {
                [receive handleRequest:request receiveObj:response];
            }
            
            if ([[response code] isEqualToString:@"101"])
            {
                //dosomting [response message]
//                SJNoticeView *notice = [[[SJNoticeView alloc] init] autorelease];
//                [notice setNoticeText:[response message]];
                
            } else if ([[response code] isEqualToString:@"1"])
            {
                BoyaRequestModel *boyaReq = (BoyaRequestModel *)[request userInfoObj];
                
                //处理特定接口
                [self handleSpecialInterFace:boyaReq request:request response:response];
                
                //处理数据库
                [self handleDatabase:boyaReq request:request response:response];
                
            }
        }
        
    }else if (request.failed || request.cancelled)
    {
        NSDictionary *dict = [request.responseString JSONValue];
        BoyaResponseModel *response = [BoyaResponseModel JSONReflection:dict];
        
        if (receive && [receive respondsToSelector:@selector(handleRequest:receiveObj:)])
        {
            [receive handleRequest:request receiveObj:response];
        }
    }
}


//网络请求加密
- (NSString *)httpUrl:(NSMutableDictionary *)dict
{

    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:4];
    [params setValue:[dict objectForKey:INTERFACEDOACTION] forKey:@"doaction"];
    [dict removeObjectForKey:INTERFACEDOACTION];
    [params setValue:dict forKey:@"data"];
//    [params setValue:APPDELEGATE.version forKey:@"v"];//动态

//    [params setValue:[NSString stringWithFormat:@"%f",[DragonDevice sysVersion]] forKey:@"device"];
//    [params setValue:@"1" forKey:@"type"];//1为ios

    if ([[params objectForKey:@"doaction"] isEqualToString:INTERFACENAMELOGIN] || [[params objectForKey:@"doaction"] isEqualToString:INTERFACENAMEREGISTER] || [[params objectForKey:@"doaction"] isEqualToString:INTERFACENAMEVERIFYCODE] || [[params objectForKey:@"doaction"] isEqualToString:INTERFACENAMECHANGEPASSWORD]) {
        DLogInfo(@"%@", [params objectForKey:@"doaction"]);
    }
    else
        [params setValue:SHARED.loginCode forKey:@"logincode"];//区分其它账号及服务器判断自己账号是否过期
    
//    if ([[params objectForKey:@"doaction"] isEqualToString:INTERFACENAMELOGIN] ||
//        [[params objectForKey:@"doaction"] isEqualToString:INTERFACENAMEAUTOLOGIN])
//    {
//        [params setValue:@"1" forKey:@"upinfo"];
//    }else
//    {
//        [params setValue:@"" forKey:@"upinfo"];
//    }
    
//    [params setValue:SHARED.uid forKey:@"uid"];
    [params setValue:[DragonDevice IMEI] forKey:@"identify"];//ios的推送token
    
    
    if (requestData)
    {
        RELEASEDICTARRAYOBJ(requestData);
    }
    
    requestData = [params mutableCopy];
    
    NSString *dictToJSON = [params JSONFragment];

    DLogInfo(@"dictToJSON === %@", dictToJSON);
    NSString *encodeJson = [DragonCommentMethod encodeURL:dictToJSON];
//    NSString *md5Json = [DragonCommentMethod md5:dictToJSON];

//    NSString *url = [NSString stringWithFormat:@"%@?json=%@&sig=%@",TESTURL,encodeJson,md5Json];
    
    NSString *url = [NSString stringWithFormat:@"%@?json=%@",TESTURL_Main
                     ,encodeJson];

    RELEASEDICTARRAYOBJ(params);

    return url;
}

#pragma mark - method
//处理特殊接口方法
- (void)handleSpecialInterFace:(BoyaRequestModel *)boyaReq request:(DragonRequest *)request response:(BoyaResponseModel *)response{
    //退出接口
    if ([boyaReq.doaction isEqualToString:INTERFACENAMELOGOUT])
    {
        [self handleLogout];
    }
    
    
}

//处理退出
- (void)handleLogout
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    self.DB.
    FROM(INTERFACENAMELOGIN).
    SET(DATABASELOGINLOGINTYPE, @"0").
    WHERE(DATABASELOGINNAME, delegate.userName).
    UPDATE();
    
//    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    DragonNaviGroupViewController *group = (DragonNaviGroupViewController *)[[delegate window] rootViewController];
    DragonNavigationController *navi = [group topStack];
    
    [navi popToRootViewControllerAnimated:YES];
    [SHARED release];
    
    //七月七日雨
}


#pragma mark - database
//处理数据库
- (void)handleDatabase:(BoyaRequestModel *)boyaReq request:(DragonRequest *)request response:(BoyaResponseModel *)response
{
    if ([boyaReq.doaction isEqualToString:INTERFACENAMELOGOUT] ||
        [boyaReq.doaction isEqualToString:INTERFACENAMELOGOUT] ||
        [boyaReq.doaction isEqualToString:INTERFACENAMERESETPASSWORD] ||
        [boyaReq.doaction isEqualToString:INTERFACENAMECHANGEPASSWORD])
    {
        return;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    time = [formatter stringFromDate:[NSDate date]];
    RELEASEOBJ(formatter)
    
    
    if ([boyaReq.doaction isEqualToString:INTERFACENAMELOGIN])
    {//处理登录
        [self handleLoginData:boyaReq request:request response:response];
    }else if ([boyaReq.doaction isEqualToString:INTERFACEPLACELIST]){
        [self handleSiteListData:boyaReq request:request response:response];
    }else if ([boyaReq.doaction isEqualToString:INTERFACEActive_ActiveList]){
        [self handleActivityListData:boyaReq request:request response:response];
    }
/*
    else if ([boyaReq.doaction isEqualToString:LOOK_INBOX]){//处理收件箱列表
        [self handleInBoxData:boyaReq request:request response:response];
    }else if ([boyaReq.doaction isEqualToString:LOOK_OUTBOX]){//处理发件箱列表
        [self handleSendBoxData:boyaReq request:request response:response];
    }else if ([boyaReq.doaction isEqualToString:SEND_LOG]){//处理获取私信内容
        //        [self handlePersonalLettersListData:sjReq request:request response:response];
    }else if ([boyaReq.doaction isEqualToString:USER_LIST]){//处理获取收件人列表
        [self handleReceiversListData:boyaReq request:request response:response];
    }
*/ 
//    else
//    {
//        
//        self.DB.
//        TABLE(boyaReq.doaction).
//        FIELD(@"id", @"INTEGER").PRIMARY_KEY().AUTO_INREMENT().
//        FIELD(@"content", @"TEXT").
//        FIELD(@"TYPE", @"TEXT").
//        FIELD(@"date", @"TEXT").
//        CREATE_IF_NOT_EXISTS();
//        
//        self.DB.
//        FROM(boyaReq.doaction).
//        SET(@"content", request.responseString).
//        SET(@"date", time).
//        INSERT();
//    }
}

//处理登录的数据
- (void)handleLoginData:(BoyaRequestModel *)boyaReq request:(DragonRequest *)request response:(BoyaResponseModel *)response
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [boyaReq.data setValue:delegate.rememberType forKey:@"c"];
    
    self.DB.
    TABLE(boyaReq.doaction).
    FIELD(@"id", @"INTEGER").PRIMARY_KEY().AUTO_INREMENT().
    FIELD(DATABASELOGINCOTENT, @"TEXT").
    FIELD(DATABASELOGINRESPONSE, @"TEXT").
    FIELD(DATABASELOGINNAME, @"TEXT").
    FIELD(DATABASELOGINLOGINTYPE, @"TEXT").
    FIELD(DATABASELOGINDATE, @"TEXT").
    CREATE_IF_NOT_EXISTS();
    
    self.DB.
    FROM(boyaReq.doaction).
    WHERE(DATABASELOGINNAME, [[boyaReq data] objectForKey:@"uname"]).
    COUNT();
    
    if ([self.DB resultCount] > 1)
    {
        self.DB.
        FROM(boyaReq.doaction).
        WHERE(DATABASELOGINNAME, [boyaReq.data objectForKey:@"uname"]).
        DELETE();
    }
    
    if ([self.DB  resultCount] == 1)//刷新登录数据
    {
        self.DB.
        FROM(boyaReq.doaction).
        SET(DATABASELOGINCOTENT, [boyaReq.data JSONFragment]).
        SET(DATABASELOGINRESPONSE, [response.data JSONFragment]).
        SET(DATABASELOGINLOGINTYPE, @"1").
        SET(DATABASELOGINDATE, time).
        WHERE(DATABASELOGINNAME, [boyaReq.data objectForKey:@"uname"]).
        UPDATE();
    }else{
        self.DB.
        FROM(boyaReq.doaction).
        SET(DATABASELOGINCOTENT, [boyaReq.data JSONFragment]).
        SET(DATABASELOGINRESPONSE, [response.data JSONFragment]).
        SET(DATABASELOGINNAME, [boyaReq.data objectForKey:@"uname"]).
        SET(DATABASELOGINLOGINTYPE, @"1").
        SET(DATABASELOGINDATE, time).
        INSERT();//在表sjReq.doaction里插入一条数据
    }
    
}

//处理场馆列表数据库
- (void)handleSiteListData:(BoyaRequestModel *)sjReq request:(DragonRequest *)request response:(BoyaResponseModel *)response
{
    NSMutableString *tableName=[NSMutableString stringWithString:sjReq.doaction];
    
    //缓存默认的全部的场馆列表
    if (((NSArray *)[response.data objectForKey:@"placeList"]).count > 0 && [[response.data objectForKey:@"area"] intValue]==0 && [[response.data objectForKey:@"type"] intValue]==0) {
        
        //创建场馆列表数据表
        self.DB.
        TABLE(tableName).
        FIELD(@"id", @"INTEGER").PRIMARY_KEY().AUTO_INREMENT().
        FIELD(DATABASELOGINRESPONSE, @"TEXT").
        FIELD(DATABASEMAILLASTID, @"TEXT").
        CREATE_IF_NOT_EXISTS();
        
        NSMutableDictionary *mud=((NSMutableDictionary *)((NSArray *)[response.data objectForKey:@"placeList"]).lastObject);
        BoyaSiteModel *model=[BoyaSiteModel JSONReflection:mud];
        
        self.DB.
        FROM(tableName).
        SET(DATABASELOGINRESPONSE, [response.data JSONFragment]).
        SET(DATABASEMAILLASTID, model.orderid).//lastID
        INSERT();//在当场馆列表数据表里插入一条数据,表示一整页的数据
    }
    
}

- (void)handleViewSignal_DragonUIAlertView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUIAlertView ALERTVIEW]])
    {
        NSDictionary *obj = (NSDictionary *)[signal object];
        UIAlertView *alertView = [obj objectForKey:@"alertView"];
        
        switch ([alertView tag])
        {
            case 1:
                if (SHARED.isLgin)
                {
                    [self handleLogout];
                }
                break;                
            default:
                break;
        }
    }
}

//处理默认活动列表数据库
- (void)handleActivityListData:(BoyaRequestModel *)sjReq request:(DragonRequest *)request response:(BoyaResponseModel *)response
{
    NSMutableString *tableName=[NSMutableString stringWithString:((AppDelegate *)([[UIApplication sharedApplication] delegate])).userName];
    [tableName appendString:@"_"];
    [tableName appendString:sjReq.doaction];
    
    //缓存默认的全部的场馆列表
    if (((NSArray *)[response.data objectForKey:@"activeList"]).count > 0 && [[response.data objectForKey:@"area"] intValue]==0 && [[response.data objectForKey:@"type"] intValue]==-1/*入参的type传@""时,出参返回-1*/ && [[response.data objectForKey:@"time"] intValue]==0) {
        
        //创建活动列表数据表
        self.DB.
        TABLE(tableName).
        FIELD(@"id", @"INTEGER").PRIMARY_KEY().AUTO_INREMENT().
        FIELD(DATABASELOGINRESPONSE, @"TEXT").
        FIELD(DATABASEMAILLASTID, @"TEXT").
        CREATE_IF_NOT_EXISTS();
        
        NSMutableDictionary *mud=((NSMutableDictionary *)((NSArray *)[response.data objectForKey:@"activeList"]).lastObject);
        BoyaSiteModel *model=[BoyaSiteModel JSONReflection:mud];
        
        self.DB.
        FROM(tableName).
        SET(DATABASELOGINRESPONSE, [response.data JSONFragment]).
        SET(DATABASEMAILLASTID, model.orderid).//lastID
        INSERT();//在列表数据表里插入一条数据,表示一整页的数据
    }
    
}

@end
