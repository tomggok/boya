//
//  BoyaSiteDetailViewController.h
//  BoYa
//
//  Created by zhangchao on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaSiteModel.h"
#import "BoyaCustomInputView.h"

//场馆详情页
@interface BoyaSiteDetailViewController : BoyaBaseViewController
{
    DragonUITableView *_tbv;
    NSMutableArray *_muA_siteCommentList;//评论列表
    UIView *_v_comment;//评论视图
    BoyaCustomInputView *_v_input;//输入框
    DragonUIButton *_bt_Score1,*_bt_Score2,*_bt_Score3,*_bt_Score4,*_bt_Score5;
    int score;
    
    DragonUILabel *_statusLabel;//输入字数的label
}

@property (nonatomic,assign) BoyaSiteModel *_model;

@end
