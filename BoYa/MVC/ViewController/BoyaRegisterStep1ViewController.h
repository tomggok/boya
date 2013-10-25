//
//  BoyaRegisterStep1ViewController.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaInputView.h"

@interface BoyaRegisterStep1ViewController : BoyaBaseViewController{
    BoyaInputView  *inputAccount;
    BoyaInputView  *inputPSW;
    BoyaInputView  *inputPhone;
    BoyaInputView  *inputMail;
    
    DragonUIButton *btnMale;
    DragonUIButton *btnFemale;
}

AS_SIGNAL(BOYAREG1BUTTON)

@end
