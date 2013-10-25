//
//  AppDelegate.h
//  BoYa
//
//  Created by NewM on 13-5-23.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BoyaSharedInstaceDelegate;
@class DragonNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) DragonNavigationController *navi;
@property (nonatomic, retain) BoyaSharedInstaceDelegate *boyaShared;//沙盒存放对象


@property (nonatomic, retain)NSString *deviceToken;//设备token
@property (nonatomic, retain)NSString *version;//版本号
@property (nonatomic, retain)NSString *userName;//用户名
@property (nonatomic, retain)NSString *passWord;//用户密码
@property (nonatomic, retain)NSString *rememberType;//勾选记住密码状态

@end
