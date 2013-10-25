//
//  BoyaNoticeView.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaNoticeView.h"

@implementation BoyaNoticeView

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (void)initSelf
{
    if (!hudView)
    {
        hudView = [[DragonUIPopAlertView alloc] initWithFrame:CGRectZero];
        [hudView setDelegate:self];
    }
}

- (void)setNoticeText:(NSString *)text
{
    [self setNoticeText:text withType:DRAGONPOPALERTVIEWNOINDICATOR];
}

- (void)setNoticeText:(NSString *)text withType:(DragonpopViewType)hudModel
{
    if (hudModel == DRAGONPOPALERTVIEWNOINDICATOR)
    {
        [hudView alertViewAutoHidden:2.f isRelease:YES];
    }else
    {
        [hudView setIndicatorMode:INDICATORLEFTTYPE];
    }
    hudView.mode = hudModel;
    if ([text isKindOfClass:[NSString class]]) {//避免闪退
        [hudView setText:text];
    }
    [hudView alertViewShown];
}

- (void)handleViewSignal_DragonUIPopAlertView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUIPopAlertView POPALERTHIDDEN]])
    {
        [self hudWasHidden];
    }
    
}

//移出提示框
- (void)hudWasHidden
{
    if (hudView)
    {
        [hudView releaseAlertView];
        hudView = nil;
    }
    
}


@end
