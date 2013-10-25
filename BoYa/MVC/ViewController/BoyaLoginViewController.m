//
//  BoyaLoginViewController.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaLoginViewController.h"
#import "BoyaHttpMethod.h"
#import "Dragon_Request.h"
#import "BoyaNavBar.h"
#import "BoyaParameter.h"
#import "BoyaInputView.h"
#import "BoyaButtonView.h"
#import "BoyaSharedInstaceDelegate.h"
#import "BoyaForgetPassWordViewController.h"
#import "BoyaRegisterStep1ViewController.h"
#import "BoyaMainViewController.h"
#import "Dragon_CommentMethod.h"
#import "BoyaResponseModel.h"
#import "BoyaLoginModel.h"
#import "BoyaNoticeView.h"
#import "BoyaUinfoModel.h"
#import "BoyaPassportPage1ViewController.h"
#import "AppDelegate.h"

@interface BoyaLoginViewController ()

@end

@implementation BoyaLoginViewController

DEF_SIGNAL(SIGNBUTTON)


- (void)dealloc
{
    [super dealloc];
}

- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    [super handleViewSignal:signal];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if ([signal is:[DragonViewController CREATE_VIEWS]])
    {
        //用户名和密码输入框
        inputName = [[BoyaInputView alloc] initWithFrame:CGRectMake(10, 15+45, CGRectGetWidth(self.view.frame)-20, 35) placeText:@"博雅账号/邮箱/手机号" img:@"icon_id.png" fieldTag:1];
        
        CGRect nameFrame = inputName.frame;
        
        inputPass = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                  CGRectGetHeight(nameFrame) + nameFrame.origin.y+0.5,
                                                                  CGRectGetWidth(self.view.frame)-20,
                                                                  35) placeText:@"请输入密码" img:@"icon_pw.png" fieldTag:2];
        CGRect pswdFrame = inputPass.frame;
        [inputPass setSecureTextEntry:YES];
        [inputName setBackgroundColor:[UIColor whiteColor]];
        [inputPass setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:inputName];
        [self.view addSubview:inputPass];
        
        RELEASE(inputName);
        RELEASE(inputPass);

        [inputName setInputText:delegate.userName];
        [inputPass setInputText:delegate.passWord];
        
     
        CGFloat textFont = BoyaLOGINTEXTFONT;//设置字体大小
        
        UIView *middleView = [self middleView:pswdFrame textFont:textFont];//修改密码记住密码view
        
        //登录按钮
        BoyaButtonView *btView = [[BoyaButtonView alloc] initWithFrame:CGRectMake(10,
                                                                              middleView.frame.size.height + middleView.frame.origin.y + 10,
                                                                              CGRectGetWidth(self.view.frame)-20,
                                                                              45) textFont:textFont title:@"" signal:[BoyaLoginViewController SIGNBUTTON]];
        [self.view addSubview:btView];
        [btView release];
        
        [self bottomView:btView.frame textFont:textFont];
        
        {//释放避免启动图消失后黑屏的图
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            [[delegate.window viewWithTag:-11] removeFromSuperview];
//            ((UIView *)[delegate.window viewWithTag:-11])=nil;
        }
        
        
    }else if ([signal is:[DragonViewController DID_DISAPPEAR]])
    {
        if (!sw.isOn)
        {
            [inputPass setInputText:@""];
        }
        
        [delegate setRememberType:[NSString stringWithFormat:@"%d", sw.isOn]];
    }else if([signal is:[DragonViewController LAYOUT_VIEWS]]){
        [_barView hideOrShowbackBt:YES];
        [_barView setIsTop:YES];
        [_barView setLeftLabelText:@"登录"];
    }else if ([signal is:[DragonViewController WILL_APPEAR]])
    {
        if([delegate.rememberType isEqualToString:@"1"]){
            sw.isOn = YES;
            [sw setIsOn:YES];
        }else{
            sw.isOn = NO;
            [sw setIsOn:NO];
        }

        [inputName setInputText:delegate.userName];
        
        if (sw.isOn)
        {
            [inputPass setInputText:delegate.passWord];
        }
        else{
             [inputPass setInputText:@""];
        }
    }
}

//修改密码记住密码view
- (UIView *)middleView:(CGRect)pswdFrame textFont:(CGFloat)textFont
{
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(0, pswdFrame.size.height + pswdFrame.origin.y + 13, self.view.frame.size.width, 20)];
    [self.view addSubview:middleView];
    [middleView release];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    sw = [[DragonUISwitch alloc] initWithFrame:CGRectMake(20, 0, 10, 10) switchType:DragonUISwitchCustom];
    [sw setButtonImgName:[NSArray arrayWithObjects:@"checkbox_a.png", @"checkbox_b.png", nil]];
    if (delegate.passWord && delegate.passWord.length > 0)
    {
        [sw setIsOn:YES];
    }else
    {
        [sw setIsOn:NO];
    }
    
    [delegate setRememberType:[NSString stringWithFormat:@"%d", sw.isOn]];
    
    [middleView addSubview:sw];
    [sw release];
    
    [middleView setFrame:CGRectMake(0, middleView.frame.origin.y, middleView.frame.size.width, 20)];
    
    
    DragonUIButton *remePwd = [[DragonUIButton alloc] initWithFrame:CGRectMake(sw.frame.origin.x + CGRectGetWidth(sw.frame) + 6,
                                                                               (CGRectGetHeight(sw.frame) - textFont)/2,
                                                                               textFont*4,
                                                                               textFont)];
    [remePwd setUserInteractionEnabled:YES];
    [remePwd setTag:2];
    [remePwd addSignal:[BoyaLoginViewController SIGNBUTTON] forControlEvents:UIControlEventTouchUpInside];
    [remePwd setTitle:@"记住密码"];
    [remePwd setTitleFont:[UIFont systemFontOfSize:textFont]];
    [remePwd setTitleColor:[UIColor whiteColor]];
    [middleView addSubview:remePwd];
    [remePwd release];
    
    
    DragonUIButton *forgetPwd = [[DragonUIButton alloc] initWithFrame:CGRectMake(middleView.frame.size.width - (textFont*4) - 30,
                                                                                 remePwd.frame.origin.y,
                                                                                 textFont*5,
                                                                                 textFont)];
    [forgetPwd setTitleFont:[UIFont systemFontOfSize:textFont]];
    [forgetPwd setTitle:@"忘记密码？"];
    [forgetPwd setTag:3];
    [forgetPwd addSignal:[BoyaLoginViewController SIGNBUTTON] forControlEvents:UIControlEventTouchUpInside];
    [forgetPwd setTitleColor:[UIColor whiteColor]];
    [middleView addSubview:forgetPwd];
    [forgetPwd release];
    
    return middleView;
    
}

- (void)bottomView:(CGRect)confingBtnFrame textFont:(CGFloat)textFont{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, confingBtnFrame.size.height + confingBtnFrame.origin.y + 30, self.view.frame.size.width, 60)];
    [self.view addSubview:bottomView];
    [bottomView release];
    
    DragonUIButton *registBoya = [[DragonUIButton alloc] initWithFrame:CGRectMake(10,
                                                                                 10,
                                                                                 300,
                                                                                 textFont)];
    [registBoya setTitleFont:[UIFont systemFontOfSize:textFont]];
    [registBoya setTitle:@"还没账号？现在就去注册"];
    [registBoya setTag:4];
    [registBoya addSignal:[BoyaLoginViewController SIGNBUTTON] forControlEvents:UIControlEventTouchUpInside];
    [registBoya setTitleColor:[DragonCommentMethod color:49 green:148 blue:151 alpha:1.f]];
    [bottomView addSubview:registBoya];
    [registBoya release];
    
    NSString *strInfo = @"还没账号还没账号？现在就去";
    NSString *strRrg = @"注册";
    float startX = CGRectGetMinX(registBoya.frame)+[strInfo sizeWithFont:registBoya.titleFont].width-2;
    
    UIImage *imageUnderLine = [UIImage imageNamed:@"topline_dark.png"];
    DragonUIImageView *imgULine = [[DragonUIImageView alloc] initWithFrame:CGRectMake(startX, registBoya.frame.origin.y+registBoya.frame.size.height, [strRrg sizeWithFont:registBoya.titleFont].width, imageUnderLine.size.height/2)];
    [imgULine setImage:imageUnderLine];
    [bottomView addSubview:imgULine];
    RELEASE(imgULine);
    
}

- (BOOL)inPutCheck{
    BOOL bSend  = YES;
    
    if([inputName.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:@"请输入 博雅账号/邮箱/手机号"];
        bSend = NO;
    }else if ([inputPass.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputPass.placeText];
        bSend = NO;
    }
    
    [self.view setUserInteractionEnabled:YES];
    
    return bSend;
}

#pragma mark -
#pragma mark - do action
- (void)handleViewSignal_BoyaLoginViewController:(DragonViewSignal *)signal
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if ([signal is:[BoyaLoginViewController SIGNBUTTON]])
    {
        DragonUIButton *bt = [signal source];
        if (bt.tag == 2)
        {
            sw.isOn = !sw.isOn;
        }else if (bt.tag == 3){

            BoyaForgetPassWordViewController *psdVC = [[BoyaForgetPassWordViewController alloc] init];
//            [psdVC setVcType:1];
            [self.drNavigationController pushViewController:psdVC animated:YES];
            [psdVC release];
        }else if (bt.tag == 4){
            
            BoyaRegisterStep1ViewController *reg1VC = [[BoyaRegisterStep1ViewController alloc] init];
            [self.drNavigationController pushViewController:reg1VC animated:YES];
            [reg1VC release];
        }else{
            [self.view setUserInteractionEnabled:NO];
            
            BOOL bSend = [self inPutCheck];
            
            if (bSend) {
                
                [delegate setRememberType:[NSString stringWithFormat:@"%d", sw.isOn]];
                [delegate setUserName:inputName.inputText];
                [delegate setPassWord:inputPass.inputText];
                
                {//登录接口
                    DragonRequest *request = [BoyaHttpMethod login:inputName.inputText password:inputPass.inputText isAlert:YES isRemberPsd:sw.isOn receive:self];
                    [request setTag:1];
                }
            }
        }
        
    }
    
}

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
                [delegate setUserName:inputName.inputText];
                
                BoyaUinfoModel *uinfoModel = [BoyaUinfoModel JSONReflection:loginModel.uinfo];
                [SHARED setUid:uinfoModel.uid];
                
                NSString *stringBP = [NSString stringWithFormat:@"%@", uinfoModel.bindPassport];

                if([stringBP isEqualToString:@"1"])      
                {                    
                    BoyaMainViewController *mainVc = [[BoyaMainViewController alloc] init];
                    [self.drNavigationController pushViewController:mainVc animated:YES];
                    [mainVc release];
                }
                else{
                    BoyaPassportPage1ViewController *passport1VC = [[BoyaPassportPage1ViewController alloc] init];
                    [passport1VC setVcType:2];
                    [self.drNavigationController pushViewController:passport1VC animated:YES];
                    [passport1VC release];
                }
 
            }else //处理操作失败
            {
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
