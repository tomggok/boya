//
//  BoyaLoginViewController.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaInputView.h"

@interface BoyaLoginViewController : BoyaBaseViewController{
    DragonUISwitch *sw;
    
    BoyaInputView *inputName;
    BoyaInputView *inputPass;
}

AS_SIGNAL(SIGNBUTTON)
@end
