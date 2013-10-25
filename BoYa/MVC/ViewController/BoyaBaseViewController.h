//
//  BoyaBaseViewController.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_ViewController.h"
#import "BoyaNavBar.h"

@interface BoyaBaseViewController : DragonViewController{
    BoyaNavBar *_barView;
}

//AS_SIGNAL(BUTTON_TOUCHED) //bt信号

@property (nonatomic, readonly)BoyaNavBar *barView;

@end
