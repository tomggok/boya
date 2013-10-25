
//
//  AppDelegate.m
//  BoYa
//
//  Created by NewM on 13-5-23.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "AppDelegate.h"
#import "BoyaLoginViewController.h"
#import "Dragon_NavigationController.h"
#import "Dragon_NaviGroupViewController.h"
#import "BoyaSharedInstaceDelegate.h"
#import "BoyaHttpMethod.h"
#import "BoyaParameter.h"
#import "BoyaLoginModel.h"
#import "NSObject+DragonDatabase.h"
#import "BoyaMainViewController.h"
#import "BoyaRequestNomalModel.h"
#import "BoyaLoginRequestModel.h"
#import "BoyaUinfoModel.h"
#import "BoyaPassportPage1ViewController.h"
#import "BoyaRequestModel.h"
#import "Dragon_Request.h"
#import "BoyaNoticeView.h"
#import "UIView+DragonCategory.h"
#import "BoyaTwoDimensionCodeViewController.h"
#import "Dragon_Device.h"

@implementation AppDelegate

@synthesize boyaShared = _boyaShared;
@synthesize navi = _navi;
@synthesize deviceToken = _deviceToken, version = _version;
@synthesize userName = _userName,passWord = _passWord, rememberType = _rememberType;

- (void)dealloc
{
    [_window release];
    RELEASEOBJ(_boyaShared);
    [super dealloc];
}

- (NSString *)rememberType
{
    return _rememberType ? _rememberType : @"0";
}

- (void)firstGetIn
{
    _navi = [DragonNavigationController stackWithFirstViewController:[BoyaLoginViewController vcalloc]];
    [_navi setNavigationBarHidden:YES];

    BoyaLoginModel *loginModel = [self handleLogin];
    
    if (loginModel)
    {
        DragonRequest *request = [BoyaHttpMethod autoLogin:SHARED.uid logincode:SHARED.loginCode isAlert:NO receive:self];
        [request setTag:1];
        
        BoyaUinfoModel *byModel = [BoyaUinfoModel JSONReflection:SHARED.uinfo];
        NSString *stringBP = [NSString stringWithFormat:@"%@", byModel.bindPassport];
        
        if([stringBP isEqualToString:@"1"]){
            
            BoyaMainViewController *mainVc = [[BoyaMainViewController alloc] init];
            [_navi pushViewController:mainVc animated:NO];
            [mainVc release];
        }
        else{
            
            BoyaMainViewController *mainVc = [[BoyaMainViewController alloc] init];
            [_navi pushViewController:mainVc animated:NO];
            [mainVc release];
        }
        

        
    }else
    {
        [self hanldeNoLogin];
    }
    
    DragonNaviGroupViewController *rootVC = [DragonNaviGroupViewController naviStatckGroupWithFirstStack:_navi];
    
    [self.window setRootViewController:rootVC];
    
//    [self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
//    self.window.backgroundColor = [UIColor whiteColor];

    _boyaShared = SHARED;
    
#if !TARGET_IPHONE_SIMULATOR
    //注册推送通知
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeSound |
     UIRemoteNotificationTypeAlert |
     UIRemoteNotificationTypeBadge];
#else
    [self firstGetIn];
#endif
    
//    self.window.backgroundColor = [UIColor whiteColor];
//    DLogInfo(@"%@",[DragonDevice phoneModel]);
//    if([[DragonDevice phoneModel] isEqualToString:@"4"])
    
    {//避免 启动图太快消失后瞬间黑屏一下
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
        imageV.image=[UIImage imageNamed:@"Default"];
        [self.window addSubview:imageV];
        imageV.tag=-11;
        [imageV release];
    }
    
    [self.window makeKeyAndVisible];

    return YES;
}

//注册手机token成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *string = [[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""];
	string = [string stringByReplacingOccurrencesOfString:@">" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    DLogInfo(@"string === %@", string);
    [self setDeviceToken:string];
    [self firstGetIn];
}
//注册手机token失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [self firstGetIn];
}

#pragma mark - handlerequest
- (void)handleRequest:(DragonRequest *)request receiveObj:(id)receiveObj
{
    if ([request succeed])
    {
        if (request.tag == 1)
        {
            DLogInfo(@"request === %@", request.responseString);
            
            BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
            
            if ([[response code] isEqualToString:@"1"])
            {
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
                
            }else //处理操作失败
            {
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
            }
            
        }
    }
}


#pragma mark - database
//处理开启软件
- (BoyaLoginModel *)handleLogin
{
    //按时间反序排表内容
    self.DB.
    FROM(INTERFACENAMELOGIN).
    WHERE(DATABASELOGINLOGINTYPE, @"1").
    ORDER_DESC_BY(DATABASELOGINDATE).
    GET();
    
    NSInteger sum = self.DB.resultCount;
    NSArray *result = [[[NSArray alloc] initWithArray:self.DB.resultArray] autorelease];
    
    BoyaLoginModel *loginModel = nil;
    if (sum > 1)
    {
        for (int i = 1; i < sum; i++)
        {
            self.DB.
            FROM(INTERFACENAMELOGIN).
            SET(DATABASELOGINLOGINTYPE, @"0").
            WHERE(@"id", [[result objectAtIndex:i] objectForKey:@"id"]).
            UPDATE();
        }
    }
    
    if (sum > 0)
    {
        loginModel = [BoyaLoginModel JSONReflection:[[result objectAtIndex:0] objectForKey:DATABASELOGINRESPONSE]];
        
        //初始化缓存内容
        [SHARED setUinfo:loginModel.uinfo];
        [SHARED setLoginCode:loginModel.ssid];
        [SHARED setIsLgin:YES];
//        [SHARED setUserName:[[result objectAtIndex:0] objectForKey:DATABASELOGINNAME]];
        [self setUserName:[[result objectAtIndex:0] objectForKey:DATABASELOGINNAME]];
        
        BoyaLoginRequestModel *byModel = [BoyaLoginRequestModel JSONReflection:[[result objectAtIndex:0] objectForKey:DATABASELOGINCOTENT]];
//        [SHARED setPassWord:byModel.pwd];
        [self setPassWord:byModel.pwd];
        
        BoyaUinfoModel *uinfoModel = [BoyaUinfoModel JSONReflection:loginModel.uinfo];
        [SHARED setUid:uinfoModel.uid];
    }
    
    return loginModel;
}

- (BoyaLoginRequestModel *)hanldeNoLogin
{
    BoyaLoginRequestModel *byModel = nil;
    
    self.DB.
    FROM(INTERFACENAMELOGIN).
    ORDER_DESC_BY(DATABASELOGINDATE).
    GET();
    
    if (self.DB.resultCount > 0)
    {
        byModel = [BoyaLoginRequestModel JSONReflection:[[self.DB.resultArray objectAtIndex:0] objectForKey:DATABASELOGINCOTENT]];
        
//        [SHARED setUserName:byModel.uname];
        [self setUserName:byModel.uname];
        if ([byModel.c isEqualToString:@"1"])
        {
//            [SHARED setPassWord:byModel.pwd];
            [self setPassWord:byModel.pwd];
        }
    }
    
    return byModel;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
//    [UIViewAnimationCurveEaseIn];
//    cocos2d::CCDirector::sharedDirector()->pause();
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
//    cocos2d::CCDirector::sharedDirector()->resume();
    
    BoyaMainViewController *main=((BoyaMainViewController *) [_navi getViewController:[BoyaMainViewController class]]);
    BoyaTwoDimensionCodeViewController *two=(BoyaTwoDimensionCodeViewController *)[[main.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG] viewController];
    if ( [two isKindOfClass:[BoyaTwoDimensionCodeViewController class]]&&two._reader) {
        [two._reader repeatAnuimation];
    }
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
