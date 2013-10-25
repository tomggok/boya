//
//  Dragon_UISearchBar.h
//  ShangJiaoYuXin
//
//  Created by zhangchao on 13-5-7.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dragon_ViewSignal.h"
#import "UIView+DragonViewSignal.h"

@interface DragonUISearchBar : UISearchBar <UISearchBarDelegate>
{
    BOOL _isHideLeftView/*是否隐藏左边的视图*/;
}

AS_SIGNAL(BEGINEDITING) //第一次按下搜索框
AS_SIGNAL(CANCEL)
AS_SIGNAL(SEARCH) //按下搜索按钮

-(id)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor placeholder:(NSString *)placeholder isHideOutBackImg:(BOOL)isHideOutBackImg isHideLeftView:(BOOL)isHideLeftView;
-(void)customBackGround:(UIImageView *)imgV;

@end
