//
//  BoyaActivityDetailViewController.h
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaActivityModel.h"
#import "BoyaInputView.h"
#import "Dragon_UITextField.h"
//活动详情
@interface BoyaActivityDetailViewController : BoyaBaseViewController<UITextFieldDelegate>
{
    DragonUITableView *_tbv;
    DragonUIButton *_bt_signUp/*报名*/;
    UIView *_v_comment;
    
    DragonUITextField *_inputMessage[6];
}

@property (nonatomic,assign) BoyaActivityModel *_model;
@end
