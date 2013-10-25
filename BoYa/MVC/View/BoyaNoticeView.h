//
//  BoyaNoticeView.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dragon_UIPopAlertView.h"

@interface BoyaNoticeView : UIView{
    DragonUIPopAlertView *hudView;
}

//默认viewtype
- (void)setNoticeText:(NSString *)text;

//自定义type
- (void)setNoticeText:(NSString *)text withType:(DragonpopViewType)hudModel;

//移出提示框
- (void)hudWasHidden;

@end
