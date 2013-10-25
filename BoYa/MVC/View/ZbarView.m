//
//  MyView.m
//  TestCoder
//
//  Created by 周 哲 on 13-5-21.
//  Copyright (c) 2013年 周 哲. All rights reserved.
//

#import "ZbarView.h"
#import "ZBarSDK.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Animations.h"
#import "BoyaMainViewController.h"
@implementation ZbarView{
    ZBarReaderViewController * controller;
}

@synthesize callback = _callback,stopAnimation;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    stopAnimation = NO;
    
    [self initView:frame];
    return self;
}


-(void)initView:(CGRect)frame{
    {
        controller= [[ZBarReaderViewController alloc]init];
        [controller setReaderDelegate:self];
        [controller.tabBarController setHidesBottomBarWhenPushed:YES];
        
        controller.supportedOrientationsMask = ZBarOrientationMaskAll;
        [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
        [controller setTracksSymbols:YES];
        controller.showsZBarControls = NO;
        controller.enableCache = YES;
        for (UIView *temp in [controller.view subviews]) {
            
            for (UIButton *button in [temp subviews]) {
                if ([button isKindOfClass:[UIButton class]]) {
                    [button removeFromSuperview];
                }
            }
            //去除toolbar
            for (UIToolbar *toolbar in [temp subviews]) {
                if ([toolbar isKindOfClass:[UIToolbar class]]) {
                    [toolbar setHidden:YES];
                }
            }
        }
        controller.showsZBarControls = NO;
        [controller.readerView start];
        controller.view.frame = frame;
        [self addSubview:controller.readerView];
    }
    
    

    laser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"laser.png"]];
    [laser setFrame:CGRectMake(31.0f, 10.0f, 235.0f, 13.0f)];
    [self addSubview:laser];
    [laser release];
    
    [self repeatAnuimation];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    id<NSFastEnumeration> results =[info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    //关灯
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOff];
            [device setFlashMode:AVCaptureFlashModeOff];
            [device unlockForConfiguration];
        }
    }
    [self.callback callBackForDimensionCode:symbol.data];
}

-(void)repeatAnuimation{

    [laser setFrame:CGRectMake(31.0f, 10, 235.0f, 13.0f)];
    [UIView beginAnimations:@"show" context:nil];
    [UIView setAnimationRepeatAutoreverses:YES];//重复时自动反转
    [UIView setAnimationRepeatCount:100000.04 /*1*/];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.5];

    [laser setFrame:CGRectMake(31.0f, self.frame.size.height-20, 235.0f, 13.0f)];
    [UIView setAnimationsEnabled:YES];
    [UIView commitAnimations];
    

}


//-(void)animationDidStop
//{
//    if (!laser) {
//        stopAnimation = YES;
//    }else if(stopAnimation==NO){
//        [self repeatAnuimation];
//    }
//}


//http://www.zeasy.cn/uiview-animation/
//-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
//{
////    stopAnimation = YES;
//
//    if([finished boolValue] == YES  || !laser || [finished isKindOfClass:[NSNull class]])//一定要判断这句话，要不在程序中当多个View刷新的时候，就可能出现动画异常的现象
//    {
//        //执行想要的动作
//
//        stopAnimation = YES;
//
//    }else if([finished boolValue]==NO && !stopAnimation){
////        [self repeatAnuimation];
////        [UIView setAnimationWillStartSelector:@selector(repeatAnuimation)];
//        stopAnimation=YES;
//    }
//    if (stopAnimation==NO) {
////        [self repeatAnuimation];
//    }
//
//}


-(void)dealloc{
    stopAnimation=YES;
    
    [controller.readerView stop];
//    [controller.readerView removeFromSuperview];
    [controller release];
    controller = nil;
    
    self.callback=Nil;
    
    [laser removeFromSuperview];

    laser=nil;
    
    //关闭灯
    {
        Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
        if (captureDeviceClass != nil) {
            AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
            if ([device hasTorch] && [device hasFlash]){
                [device lockForConfiguration:nil];
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                [device unlockForConfiguration];
            }
        }
    }
    
    [super dealloc]; //在本项目里其父视图已在mainCon的touchBtnAtIndex方法里释放,故注释
}
@end
