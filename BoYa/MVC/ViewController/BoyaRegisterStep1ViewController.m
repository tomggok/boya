//
//  BoyaRegisterStep1ViewController.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaRegisterStep1ViewController.h"
#import "Dragon_Request.h"
#import "BoyaButtonView.h"
#import "BoyaPassportPage1ViewController.h"
#import "BoyaParameter.h"
#import "BoyaHttpMethod.h"
#import "BoyaNoticeView.h"
#import "BoyaHttpMethod.h"
#import "BoyaLoginModel.h"
#import "BoyaUinfoModel.h"
#import "AppDelegate.h"

#define kAlphaNum   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface BoyaRegisterStep1ViewController ()

@end

@implementation BoyaRegisterStep1ViewController

DEF_SIGNAL(BOYAREG1BUTTON)

- (void)dealloc
{
    [super dealloc];
}

- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    if ([signal is:[DragonViewController CREATE_VIEWS]]){
        
        inputAccount = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                    60,
                                                                    CGRectGetWidth(self.view.frame)-20,
                                                                    35)
                                               placeText:@"请输入您要注册的账号"
                                                     img:@""
                                                fieldTag:1];
        [inputAccount setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputAccount];
        [inputAccount release];
        
        inputPSW = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                    CGRectGetHeight(inputAccount.frame) + inputAccount.frame.origin.y + 5,
                                                                    CGRectGetWidth(self.view.frame)-20,
                                                                    35) placeText:@"请输入您的密码" img:@"" fieldTag:2];
        
        [inputPSW setSecureTextEntry:YES];
        [inputPSW setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputPSW];
        [inputPSW release];
        
        
        inputPhone = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                     CGRectGetHeight(inputPSW.frame) + inputPSW.frame.origin.y + 5,
                                                                     CGRectGetWidth(self.view.frame)-20,
                                                                     35) placeText:@"请输入您的手机号" img:@"" fieldTag:3];
        
        [inputPhone setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputPhone];
        [inputPhone release];
        
        inputMail = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                     CGRectGetHeight(inputPhone.frame) + inputPhone.frame.origin.y + 5,
                                                                     CGRectGetWidth(self.view.frame)-20,
                                                                     35) placeText:@"请输入您的常用邮箱" img:@"" fieldTag:4];
        
        [inputMail setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputMail];
        [inputMail release];
        
        
        DragonUILabel *sexInfoLable = [[DragonUILabel alloc] initWithFrame:CGRectMake(10,
                                                                                      CGRectGetHeight(inputMail.frame) + inputMail.frame.origin.y + 5,
                                                                                      100,
                                                                                      35)];
        
        [sexInfoLable setText:@"性别"];
        [sexInfoLable setTextColor:[DragonCommentMethod color:187 green:187 blue:187 alpha:1.f]];
        [sexInfoLable setFont:[UIFont systemFontOfSize:BoyaLOGININPUTPLACEHOLDER]];
        [sexInfoLable setBackgroundColor:[UIColor whiteColor]];
        [sexInfoLable setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:sexInfoLable];
        [sexInfoLable release];
        
        btnMale = [[DragonUIButton alloc] initWithFrame:CGRectMake(sexInfoLable.frame.origin.x + CGRectGetWidth(sexInfoLable.frame),
                                                                                   CGRectGetMinY(sexInfoLable.frame),
                                                                                   100,
                                                                                   35)];
        [btnMale setBackgroundColor:[DragonCommentMethod color:49 green:148 blue:151 alpha:1.f]];
        [btnMale setSelected:YES];
        [btnMale setUserInteractionEnabled:YES];
        [btnMale setTag:2];
        [btnMale addSignal:[BoyaRegisterStep1ViewController BOYAREG1BUTTON] forControlEvents:UIControlEventTouchUpInside];
        [btnMale setTitle:@"男"];
        [btnMale setTitleFont:[UIFont systemFontOfSize:BoyaLOGININPUTPLACEHOLDER]];
        [btnMale setTitleColor:[UIColor whiteColor]];
        [self.view addSubview:btnMale];
        [btnMale release];
        
        btnFemale = [[DragonUIButton alloc] initWithFrame:CGRectMake(btnMale.frame.origin.x + CGRectGetWidth(btnMale.frame),
                                                                                   CGRectGetMinY(btnMale.frame),
                                                                                   100,
                                                                                   35)];
        [btnFemale setBackgroundColor:[DragonCommentMethod color:78 green:183 blue:187 alpha:1.f]];
        [btnFemale setUserInteractionEnabled:YES];
        [btnFemale setTag:3];
        [btnFemale addSignal:[BoyaRegisterStep1ViewController BOYAREG1BUTTON] forControlEvents:UIControlEventTouchUpInside];
        [btnFemale setTitle:@"女"];
        [btnFemale setTitleFont:[UIFont systemFontOfSize:BoyaLOGININPUTPLACEHOLDER]];
        [btnFemale setTitleColor:[UIColor whiteColor]];
        [self.view addSubview:btnFemale];
        [btnFemale release];


        
        
        BoyaButtonView *btnRegister = [[BoyaButtonView alloc] initWithFrame:CGRectMake(10,
                                                                                  sexInfoLable.frame.size.height + sexInfoLable.frame.origin.y + 30,
                                                                                  CGRectGetWidth(self.view.frame)-20,
                                                                                  45) textFont:14 title:@"" signal:[BoyaRegisterStep1ViewController BOYAREG1BUTTON]];
        [btnRegister setButtonImg:@"btn_reg_a.png" imgHighlighted:@"btn_reg_b.png"];
        [self.view addSubview:btnRegister];
        [btnRegister release];
    }else if([signal is:[DragonViewController LAYOUT_VIEWS]]){
        [_barView setCenterLabelText:@"注册新账号"];
        [_barView setLeftLabelText:@""];
    }
    
}


- (void)handleViewSignal_BoyaRegisterStep1ViewController:(DragonViewSignal *)signal
{
    //处理button
    if ([signal is:[BoyaRegisterStep1ViewController BOYAREG1BUTTON]])
    {
        
        DragonUIButton *bt = [signal source];
        if (bt.tag == 2){
            [btnMale setSelected:YES];
            [btnFemale setSelected:NO];
            
            [btnMale setBackgroundColor:[DragonCommentMethod color:49 green:148 blue:151 alpha:1.f]];
            [btnFemale setBackgroundColor:[DragonCommentMethod color:78 green:183 blue:187 alpha:1.f]];
        }
        else if (bt.tag == 3){            
            [btnFemale setSelected:YES];
            [btnMale setSelected:NO];
            
            [btnFemale setBackgroundColor:[DragonCommentMethod color:49 green:148 blue:151 alpha:1.f]];
            [btnMale setBackgroundColor:[DragonCommentMethod color:78 green:183 blue:187 alpha:1.f]];
            
        }else{
            
            BOOL bSend  = [self inPutCheck];
            
            if (bSend == YES) {
                NSString *strSex = nil;
                
                if (btnMale.selected == YES)
                    strSex = @"1";
                else
                    strSex = @"0";
                
                
                DragonRequest *request = [BoyaHttpMethod uregister:inputAccount.inputText password:inputPSW.inputText email:inputMail.inputText phone:inputPhone.inputText sex:strSex area:@"1" isAlert:YES receive:self];
                [request setTag:1];
            }
            

        }
    }
    
}

- (BOOL)inPutCheck{
    BOOL bSend  = YES;
    
    if([inputAccount.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputAccount.placeText];
        bSend = NO;
    }else if ([inputPSW.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputPSW.placeText];
        bSend = NO;
    }else if ([inputPhone.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputPhone.placeText];
        bSend = NO;
    }else if ([inputMail.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputMail.placeText];
        bSend = NO;
    }else if (![self SNinputCheck:inputPSW.inputText]){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:@"密码只能输入字母和数字"];
        bSend = NO;
    }

    return bSend;
}


- (BOOL)SNinputCheck:(NSString *)strSN{
    NSCharacterSet *cs;
    cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum]invertedSet];
    
    NSString *filtered = [[strSN componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@""];
    
    BOOL canChange = [strSN isEqualToString:filtered];
    
    return canChange;
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
                BoyaLoginModel *loginModel = [BoyaLoginModel JSONReflection:response.data];
                [SHARED setLoginCode:loginModel.ssid];
                
                [SHARED setUinfo:loginModel.uinfo];
                [SHARED setIsLgin:YES];
                
                AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                [delegate setUserName:inputAccount.inputText];
                [delegate setPassWord:@""];
                [delegate setRememberType:@"0"];
                
                BoyaUinfoModel *uinfoModel = [BoyaUinfoModel JSONReflection:loginModel.uinfo];
                [SHARED setUid:uinfoModel.uid];
                
                BoyaPassportPage1ViewController *passport1VC = [[BoyaPassportPage1ViewController alloc] init];
                [passport1VC setVcType:1];
                [self.drNavigationController pushViewController:passport1VC animated:YES];
                [passport1VC release];
                
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
