//
//  BoyaPassportPage2ViewController.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaInputView.h"

@interface BoyaPassportPage2ViewController : BoyaBaseViewController{
    //用户名和密码输入框
    BoyaInputView *inputParentsName;
    BoyaInputView *inputParentsPhone;
}

@property (nonatomic, retain) NSMutableDictionary *dicBlindInfo;
@property (nonatomic, assign) NSInteger vcType;

AS_SIGNAL(BOYAPP2BUTTON)

@end
