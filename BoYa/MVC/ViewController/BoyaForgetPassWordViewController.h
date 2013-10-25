//
//  BoyaForgetPassWordViewController.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaInputView.h"

@interface BoyaForgetPassWordViewController : BoyaBaseViewController{
    //用户名和密码输入框
    BoyaInputView *inputName;    
    BoyaInputView *inputMail;
}

AS_SIGNAL(BOYAPSWBUTTON)

@end
