//
//  BoyaPassportPage1ViewController.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaInputView.h"

@interface BoyaPassportPage1ViewController : BoyaBaseViewController{
    BoyaInputView *inputPPNo;
    DragonUIScrollView *scView;
}

@property (nonatomic, assign)NSInteger vcType;//1,注册后跳转2,登陆后跳转

AS_SIGNAL(BOYAPP1BUTTON)

@end
