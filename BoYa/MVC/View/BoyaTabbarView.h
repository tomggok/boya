//
//  tabbarView.h
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Dragon_UIButton.h"
//#import "BoyaMainViewController.h"

@interface BoyaTabbarView : UIView

@property(nonatomic,strong) UIImageView *_imgV_tabbarView,*_imgV_tabbarViewCenter;

@property(nonatomic,strong) DragonUIButton *_bt1,*_bt2,*_bt3,*_bt4,*_btCenter;
//@property(nonatomic,strong) UIButton *_button_2;
//@property(nonatomic,strong) UIButton *_button_3;
//@property(nonatomic,strong) UIButton *_button_4;
//@property(nonatomic,strong) UIButton *_button_center;

//@property(nonatomic,assign) id<tabbarDelegate> _delegate;

@end
