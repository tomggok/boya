//
//  BoyaMainViewController.m
//  BoYa
//
//  Created by zhangchao on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaMainViewController.h"
#import "BoyaSiteViewController.h"
#import "BoyaRelatedMeViewController.h"
#import "BoyaActivityViewController.h"
#import "BoyaSettingViewController.h"
#import "BoyaTwoDimensionCodeViewController.h"
#import "KeyNotes.h"
#import "UIView+DragonCategory.h"
#import "BoyaTwoDimensionCodeViewController.h"

@interface BoyaMainViewController ()

@end

@implementation BoyaMainViewController

@synthesize _tabbar;

#pragma mark- ViewController信号
- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    [super handleViewSignal:signal];
    
    if ([signal is:DragonViewController.CREATE_VIEWS]) {
        self.view.backgroundColor=[UIColor clearColor];
        
        CGFloat orginHeight = self.view.frame.size.height- 45-kH_StateBar;
        if (iPhone5) {
//            orginHeight = self.view.frame.size.height- 60 + addHeight;
        }
        _tabbar = [[BoyaTabbarView alloc]initWithFrame:CGRectMake(0,  orginHeight, screenShows.size.width, 45)];
//        _tabbar._delegate = self;
        [self.view addSubview:_tabbar];
        
        _index=-1;

        _arrayViewcontrollers = [self getViewcontrollers];
        [self touchBtnAtIndex:0];
    }else if ([signal is:DragonViewController.WILL_APPEAR]){
        //        self.view.userInteractionEnabled=YES;
        
        UIView *v=[self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
        DragonViewController *con=(DragonViewController *)[v viewController];
        [con viewWillAppear:YES];
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){
//        self.view.userInteractionEnabled=YES;
        
        UIView *v=[self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
        v.userInteractionEnabled=YES;

    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
    [_barView setHidden:YES];

    }

    //    DLogInfo(@"signal name === %@", signal.name);
    
}

-(void)touchBtnAtIndex:(NSInteger)index
{
    if (index!=_index) {
        _index=index;
    }else{
        return;
    }
    
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    {
        [currentView removeFromSuperview];
    }
    
    BoyaBaseViewController *viewController = /*data[@"viewController"]*/ [_arrayViewcontrollers objectAtIndex:index];
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height- 50);
    
    [self.view insertSubview:viewController.view belowSubview:_tabbar];

}

-(NSArray *)getViewcontrollers
{
    NSArray* tabBarItems = nil;
    
    BoyaRelatedMeViewController *relatedCon=[[BoyaRelatedMeViewController alloc]init];
    BoyaActivityViewController *actCon=[[BoyaActivityViewController alloc]init];
    BoyaTwoDimensionCodeViewController *twoCon=[[BoyaTwoDimensionCodeViewController alloc]init];
    BoyaSiteViewController *siteCon=[[BoyaSiteViewController alloc]init];
    BoyaSettingViewController *setCon=[[BoyaSettingViewController alloc]init];

    tabBarItems = [NSArray arrayWithObjects:
                   siteCon,
                   actCon,twoCon,relatedCon,setCon,Nil];
    
    [siteCon release];
    [actCon release];
    [relatedCon release];
    [setCon release];
    [twoCon release];
    
    
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.view];
//    [self.drNavigationController.view sendSubviewToBack:self.view];
    
    return [tabBarItems retain];
    
}

#pragma mark- 只接受按钮信号
- (void)handleViewSignal_DragonUIButton:(DragonViewSignal *)signal{
    if ([signal is:[DragonUIButton TOUCH_UP_INSIDE]]) {
        DragonUIButton *bt=(DragonUIButton *)signal.source;
        switch (bt.tag) {
            case 0://场馆
            {
                [_tabbar._bt1 setImage:[UIImage imageNamed:@"tab_place_b"] forState:UIControlStateNormal];
                [_tabbar._bt2 setImage:[UIImage imageNamed:@"tab_list_a"] forState:UIControlStateNormal];
                [_tabbar._bt3 setImage:[UIImage imageNamed:@"tab_mine_a"] forState:UIControlStateNormal];
                [_tabbar._bt4 setImage:[UIImage imageNamed:@"tab_set_a"] forState:UIControlStateNormal];
                [_tabbar._btCenter setImage:[UIImage imageNamed:@"btn_qrcode"] forState:UIControlStateNormal];

            [self touchBtnAtIndex:0];
            }
                break;
            case 1://活动
            {
                [_tabbar._bt1 setImage:[UIImage imageNamed:@"tab_place_a"] forState:UIControlStateNormal];
                [_tabbar._bt2 setImage:[UIImage imageNamed:@"tab_list_b"] forState:UIControlStateNormal];
                [_tabbar._bt3 setImage:[UIImage imageNamed:@"tab_mine_a"] forState:UIControlStateNormal];
                [_tabbar._bt4 setImage:[UIImage imageNamed:@"tab_set_a"] forState:UIControlStateNormal];
                [_tabbar._btCenter setImage:[UIImage imageNamed:@"btn_qrcode"] forState:UIControlStateNormal];

                [self touchBtnAtIndex:1];

            }
                break;
            case 2://二维码
            {
                [_tabbar._bt1 setImage:[UIImage imageNamed:@"tab_place_a"] forState:UIControlStateNormal];
                [_tabbar._bt2 setImage:[UIImage imageNamed:@"tab_list_a"] forState:UIControlStateNormal];
                [_tabbar._bt3 setImage:[UIImage imageNamed:@"tab_mine_a"] forState:UIControlStateNormal];
                [_tabbar._bt4 setImage:[UIImage imageNamed:@"tab_set_a"] forState:UIControlStateNormal];
                [_tabbar._btCenter setImage:[UIImage imageNamed:@"btn_qrcode_b"] forState:UIControlStateNormal];
                [self touchBtnAtIndex:2];

            }
                break;
            case 3://与我相关
            {
                [_tabbar._bt1 setImage:[UIImage imageNamed:@"tab_place_a"] forState:UIControlStateNormal];
                [_tabbar._bt2 setImage:[UIImage imageNamed:@"tab_list_a"] forState:UIControlStateNormal];
                [_tabbar._bt3 setImage:[UIImage imageNamed:@"tab_mine_b"] forState:UIControlStateNormal];
                [_tabbar._bt4 setImage:[UIImage imageNamed:@"tab_set_a"] forState:UIControlStateNormal];
                [_tabbar._btCenter setImage:[UIImage imageNamed:@"btn_qrcode"] forState:UIControlStateNormal];

                [self touchBtnAtIndex:3];

            }
                break;
            case 4://设置
            {
                [_tabbar._bt1 setImage:[UIImage imageNamed:@"tab_place_a"] forState:UIControlStateNormal];
                [_tabbar._bt2 setImage:[UIImage imageNamed:@"tab_list_a"] forState:UIControlStateNormal];
                [_tabbar._bt3 setImage:[UIImage imageNamed:@"tab_mine_a"] forState:UIControlStateNormal];
                [_tabbar._bt4 setImage:[UIImage imageNamed:@"tab_set_b"] forState:UIControlStateNormal];
                [_tabbar._btCenter setImage:[UIImage imageNamed:@"btn_qrcode"] forState:UIControlStateNormal];

                [self touchBtnAtIndex:4];

            }
                break;
            default:
                break;
        }
    }
}
@end
