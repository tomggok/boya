//
//  MyView.h
//  TestCoder
//
//  Created by 周 哲 on 13-5-21.
//  Copyright (c) 2013年 周 哲. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"

//@class ZbarCallBack;
//

@protocol ZbarCallBack
@optional
-(void)callBackForDimensionCode :(NSString *)code;
@end

@interface ZbarView : UIView<ZBarReaderDelegate>{
    UIImageView* laser;
    BOOL stopAnimation;
}
@property(nonatomic,assign) id<ZbarCallBack> callback;
@property (nonatomic,assign)     BOOL stopAnimation;


//@property (nonatomic,assign)     BOOL stopAnimation;

-(void)repeatAnuimation;

@end


