//
//  BoyaSiteImgViewController.h
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "Dragon_UIScrollView.h"
#import "ASImageScrollView.h"
@interface BoyaSiteImgViewController : BoyaBaseViewController<UIScrollViewDelegate>
{
    DragonUIScrollView *_scrollV; //大背景
    NSMutableArray *_muA_photoList;//图片URl
    
    NSMutableArray *_muA_asiScrol;
    
   // ASImageScrollView *_ascrView[999999];//小背景
    
    float orginy;
    
    CGFloat offset;
    
    int a;
    
}

@property (nonatomic,copy) NSString *_str_placeid;//场馆ID
@end
