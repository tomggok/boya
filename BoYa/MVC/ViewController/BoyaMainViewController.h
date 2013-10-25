//
//  BoyaMainViewController.h
//  BoYa
//
//  Created by zhangchao on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaTabbarView.h"

#define SELECTED_VIEW_CONTROLLER_TAG 98456345
#define addHeight 88


@interface BoyaMainViewController : BoyaBaseViewController
{
    int _index;
}
@property(nonatomic,retain) BoyaTabbarView *_tabbar;
@property(nonatomic,strong) NSArray *arrayViewcontrollers;

-(void)touchBtnAtIndex:(NSInteger)index;

@end
