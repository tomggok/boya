//
//  BoyaTwoDimensionCodeViewController.h
//  BoYa
//
//  Created by cham on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"

#import "ZbarView.h"
#import "Dragon_UILabel.h"

//二维码
@interface BoyaTwoDimensionCodeViewController : BoyaBaseViewController<ZbarCallBack,ZBarReaderDelegate>{
    ZbarView *_reader;//相机背景框
    UIView *_backView;//白色背景框
    DragonUILabel *_label;//显示的二维码
    DragonUILabel *_labelDesc;//显示的二维码
    DragonUIButton *_btCenter;//扫描按钮
}

@property (nonatomic,retain) ZbarView *_reader;//相机背景框

-(void)releaseZeader;
@end
