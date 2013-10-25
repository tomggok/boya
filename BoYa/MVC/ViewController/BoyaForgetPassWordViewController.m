//
//  BoyaForgetPassWordViewController.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaForgetPassWordViewController.h"
#import "BoyaButtonView.h"
#import "BoyaHttpMethod.h"
#import "BoyaParameter.h"
#import "Dragon_Request.h"
#import "BoyaNoticeView.h"

@interface BoyaForgetPassWordViewController ()

@end

@implementation BoyaForgetPassWordViewController

DEF_SIGNAL(BOYAPSWBUTTON)

- (void)dealloc
{
    [super dealloc];
}

- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    if ([signal is:[DragonViewController CREATE_VIEWS]])
    {
        DragonUILabel *noticeLabel = [[DragonUILabel alloc] initWithFrame:CGRectMake(10, 8 + 45, CGRectGetWidth(self.view.frame)-20, 40)];
        
        [noticeLabel setText:@"请正确填写您的用户名或会员ID，我们将会为您初始化密码，并发送到您的邮箱。"];
        [noticeLabel setTextColor:[UIColor whiteColor]];
        [noticeLabel setFont:[UIFont systemFontOfSize:BoyaINFOTITLEFONT]];
        [noticeLabel setBackgroundColor:[UIColor clearColor]];
        [noticeLabel setNumberOfLines:2];
        [noticeLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [noticeLabel setLinesSpacing:8.0f];
        [self.view addSubview:noticeLabel];
        noticeLabel.needCoretext = YES;
        [noticeLabel release];
        
        CGFloat inputNameY = CGRectGetHeight(noticeLabel.frame) + noticeLabel.frame.origin.y + 18;
        
//        [noticeLabel setHidden:YES];
//        inputNameY = 15 + 45;
        
        //用户名和密码输入框
        inputName = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                  inputNameY,
                                                                  CGRectGetWidth(self.view.frame)-20,
                                                                  35)
                                             placeText:@"请输入您的账号"
                                                   img:@""
                                              fieldTag:1];
        [inputName setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputName];
        [inputName release];
        
        inputMail = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                  CGRectGetHeight(inputName.frame) + inputName.frame.origin.y + 5,
                                                                  CGRectGetWidth(self.view.frame)-20,
                                                                  35) placeText:@"请输入您的邮箱" img:@"" fieldTag:2];
        [inputMail setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputMail];
        [inputMail release];
               
    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
        [_barView setCenterLabelText:@"找回密码"];
        [_barView setLeftLabelText:@""];

        [_barView.rightBt setTitleFont:[UIFont systemFontOfSize:BoyaHEADERTITLEFONT]];
        [_barView.rightBt setTag:10];
        [_barView.rightBt addSignal:[BoyaForgetPassWordViewController BOYAPSWBUTTON] forControlEvents:UIControlEventTouchUpInside];
        [_barView setRightText:@"确认"];
        
    }
}


#pragma mark doaction
//处理textfield
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

- (BOOL)inPutCheck{
    BOOL bSend  = YES;
    
    if([inputName.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputName.placeText];
        bSend = NO;
    }else if([inputMail.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputMail.placeText];
        bSend = NO;
    }
    
    return bSend;
}

- (void)handleViewSignal_BoyaForgetPassWordViewController:(DragonViewSignal *)signal
{
    //处理button
    if ([signal is:[BoyaForgetPassWordViewController BOYAPSWBUTTON]])
    {
        DragonUIButton *bt = [signal source];
        if (bt.tag == 10){
            BOOL bSend = [self inPutCheck];
            
            if (bSend) {
                DragonRequest *request = [BoyaHttpMethod resetPwd:inputName.inputText email:inputMail.inputText isAlert:YES receive:self];
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
            }else { //处理操作失败
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
            }
            
            [self.view setUserInteractionEnabled:YES];
            
        }
        
    }else if ([request failed])
    {
        [self.view setUserInteractionEnabled:YES];
    }
}

@end
