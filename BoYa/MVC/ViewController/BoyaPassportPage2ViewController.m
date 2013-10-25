//
//  BoyaPassportPage2ViewController.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaPassportPage2ViewController.h"
#import "BoyaParameter.h"
#import "Dragon_Request.h"
#import "BoyaHttpMethod.h"
#import "BoyaNoticeView.h"
#import "BoyaMainViewController.h"
#import "BoyaLoginViewController.h"

@interface BoyaPassportPage2ViewController ()

@end

@implementation BoyaPassportPage2ViewController
@synthesize dicBlindInfo = _dicBlindInfo;
@synthesize vcType= _vcType;

DEF_SIGNAL(BOYAPP2BUTTON)

- (void)dealloc
{
    RELEASEDICTARRAYOBJ(_dicBlindInfo);
    [super dealloc];
}

- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    if ([signal is:[DragonViewController CREATE_VIEWS]])
    {
        
        DragonUILabel *noticeLabel = [[DragonUILabel alloc] initWithFrame:CGRectMake(11, 8 + 45, CGRectGetWidth(self.view.frame), 25)];
        
        [noticeLabel setTextColor:[UIColor whiteColor]];
        [noticeLabel setFont:[UIFont systemFontOfSize:BoyaINFOTITLEFONT]];
        [noticeLabel setText:@"请补充完成家长信息（2/2）"];
        [noticeLabel setFont:[UIFont systemFontOfSize:14.f]];
        [noticeLabel setTextAlignment:NSTextAlignmentCenter];
        [noticeLabel setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:noticeLabel];
        [noticeLabel release];
        
        CGFloat inputNameY = CGRectGetHeight(noticeLabel.frame) + noticeLabel.frame.origin.y + 5;
        
        //用户名和密码输入框
        inputParentsName = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                    inputNameY,
                                                                    CGRectGetWidth(self.view.frame)-20,
                                                                    35)
                                               placeText:@"填写真实姓名以兑换奖品"
                                                     img:@""
                                                fieldTag:1];
        [inputParentsName setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputParentsName];
        [inputParentsName release];
        
        inputParentsPhone = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                    CGRectGetHeight(inputParentsName.frame) + inputParentsName.frame.origin.y + 10,
                                                                    CGRectGetWidth(self.view.frame)-20,
                                                                    35) placeText:@"填写准确电话号码以通知领奖" img:@"" fieldTag:2];
        [inputParentsPhone setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputParentsPhone];
        [inputParentsPhone release];
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"parentsname"] length] > 0){
            inputParentsName.inputText = [[NSUserDefaults standardUserDefaults] objectForKey:@"parentsname"];
        }
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"parentsphone"] length] > 0){
            inputParentsPhone.inputText = [[NSUserDefaults standardUserDefaults] objectForKey:@"parentsphone"];
        }
        
        
    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
        [_barView setCenterLabelText:@"绑定护照"];
        [_barView setLeftLabelText:@""];
        
        [_barView.rightBt setTitleFont:[UIFont systemFontOfSize:BoyaHEADERTITLEFONT]];
        [_barView.rightBt setTag:10];
        [_barView.rightBt addSignal:[BoyaPassportPage2ViewController BOYAPP2BUTTON] forControlEvents:UIControlEventTouchUpInside];
        [_barView setRightText:@"激活"];
    }else if ([signal is:[DragonViewController DID_DISAPPEAR]]){
        NSLog(@"Disappar");
        
        if ([inputParentsName.inputText length] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:inputParentsName.inputText forKey:@"parentsname"];
        }
        
        if ([inputParentsPhone.inputText length] > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:inputParentsPhone.inputText forKey:@"parentsphone"];
        }
    }
}

- (BOOL)inPutCheck{
    BOOL bSend  = YES;
    
    if([inputParentsName.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputParentsName.placeText];
        bSend = NO;
    }else if ([inputParentsPhone.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputParentsPhone.placeText];
        bSend = NO;
    }
    
    return bSend;
}

- (void)handleViewSignal_BoyaPassportPage2ViewController:(DragonViewSignal *)signal
{
    //处理button
    if ([signal is:[BoyaPassportPage2ViewController BOYAPP2BUTTON]])
    {
        
        DragonUIButton *bt = [signal source];
        if (bt.tag == 10){
            BOOL bSend= [self inPutCheck];
            
            if (bSend) {
                DragonRequest *request = [BoyaHttpMethod bindPassport:[_dicBlindInfo objectForKey:@"sn"]
                                                          studentName:[_dicBlindInfo objectForKey:@"stuName"]
                                                         studentPhone:[_dicBlindInfo objectForKey:@"stuPhone"]
                                                               school:[_dicBlindInfo objectForKey:@"school"]
                                                                class:[_dicBlindInfo objectForKey:@"class"]
                                                                   QQ:[_dicBlindInfo objectForKey:@"QQ"]
                                                                email:[_dicBlindInfo objectForKey:@"email"]
                                                              address:[_dicBlindInfo objectForKey:@"address"]
                                                             postCode:[_dicBlindInfo objectForKey:@"postCode"]
                                                           ParentName:inputParentsName.inputText
                                                          ParentPhone:inputParentsPhone.inputText
                                                              isAlert:YES receive:self];
                [request setTag:1];
            }
        }
    }
    
}
//处理网络请求
- (void)handleRequest:(DragonRequest *)request receiveObj:(id)receiveObj
{
    if ([request succeed])
    {
        if (request.tag == 1)
        {
            DLogInfo(@"request === %@", request.responseString);
            
            BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
            
            if ([[response code] isEqualToString:@"1"])
            {
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
                
                if (_vcType == 1) {
//                    BoyaLoginViewController *loginVC = [[BoyaLoginViewController alloc] init];
//                    [self.drNavigationController pushViewController:loginVC animated:YES];
                    [self.drNavigationController popToRootViewControllerAnimated:YES];//避免激活流程完成后跳到登录页面并登录进去后出现滑动返回到 登录页的BUG
//                    [loginVC release];
                }
                else{
                    BoyaMainViewController *mainVc = [[BoyaMainViewController alloc] init];
                    [self.drNavigationController pushViewController:mainVc animated:YES];
                    [mainVc release];
                }
       
            }else //处理操作失败
            {
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
            }
            
        }
        
    }else if ([request failed])
    {
        [self.view setUserInteractionEnabled:YES];
    }
}

- (void)handleViewSignal_DragonUITextField:(DragonViewSignal *)signal
{
    if ([signal.source isKindOfClass:[DragonUITextField class]])
    {
        DragonUITextField *textField = [signal source];
        
        if ([signal is:[DragonUITextField TEXTFIELDDIDENDEDITING]])
        {
            
        }else if ([signal is:[DragonUITextField TEXTFIELD]])
        {
            
            
        }else if ([signal is:[DragonUITextField TEXTFIELDSHOULDRETURN]])
        {
            [textField resignFirstResponder];
            
        }
    }
    
    
}
@end
