//
//  Dragon_UIPopView.h
//  DragonFramework
//
//  Created by NewM on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+DragonViewSignal.h"
#import "Dragon_ViewSignal.h"

typedef enum DragonpopViewType{
    DRAGONPOPALERTVIEWNOINDICATOR = 0,
    DRAGONPOPALERTVIEWINDICATOR = 1
}DragonpopViewType;

typedef enum DragonpopAlertIndicatorType{
    INDICATORLEFTTYPE = 0,
    INDICATORRIGHTTYPE = 1,
    INDICATORHEADTYPE = 2,
    INDICATORFOOTTYPE = 3
}DragonpopAlertIndicatorType;

@interface DragonUIPopAlertView : UIView
{
}
AS_SIGNAL(POPALERTHIDDEN)
@property (nonatomic, retain) id delegate;
@property (nonatomic, assign) DragonpopViewType mode;
@property (nonatomic, assign) DragonpopAlertIndicatorType indicatorMode;
@property (nonatomic, retain) NSMutableArray *imgArray;

//设置文字
- (void)setText:(NSString *)text;

- (void)alertViewShown;//显示

- (void)alertViewHidden;//隐藏

- (void)releaseAlertView;//释放

- (void)alertViewHiddenAndRelease;//隐藏并释放

- (void)alertViewAutoHidden:(NSTimeInterval)duration;//自动隐藏

- (void)alertViewAutoHidden:(NSTimeInterval)duration isRelease:(BOOL)isRelease;//自动隐藏并释放



@end
