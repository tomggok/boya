//
//  BoyaPassportPage1ViewController.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaPassportPage1ViewController.h"
#import "Dragon_Request.h"
#import "Dragon_UIScrollView.h"
#import "BoyaParameter.h"
#import "BoyaPassportPage2ViewController.h"
#import "BoyaUinfoModel.h"
#import "BoyaNoticeView.h"
#import "BoyaRequest.h"

@interface BoyaPassportPage1ViewController ()

@end

@implementation BoyaPassportPage1ViewController
@synthesize vcType = _vcType;

DEF_SIGNAL(BOYAPP1BUTTON)


- (void)dealloc
{
    [super dealloc];
}

- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    if ([signal is:[DragonViewController CREATE_VIEWS]]){
        
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"parentsname"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"parentsphone"];
        
        BoyaUinfoModel *byModel = [BoyaUinfoModel JSONReflection:SHARED.uinfo];
        
        NSString *strInfo = nil;
        scView = [[DragonUIScrollView alloc] initWithFrame:self.view.bounds];
        [scView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.6)];
        [scView setShowsVerticalScrollIndicator:NO];
        [self.view addSubview:scView];
        [scView release];
        
        [self.view bringSubviewToFront:_barView];
        
        if (_vcType == 1)
            strInfo = @"注册成功！";
        else
            strInfo = @"您的账号尚未激活，";
        
 
        DragonUILabel *noticeLabel = [[DragonUILabel alloc] initWithFrame:CGRectMake(11, 8+45, CGRectGetWidth(self.view.frame)-20, 55)];
        
        [noticeLabel setText:[NSString stringWithFormat:@"%@请完善以下信息激活账号，以获取各种增值服务。您也可以登录 www.21boya.cn/dianping/passport 完成激活。", strInfo]];
        [noticeLabel setFont:[UIFont systemFontOfSize:BoyaINFOTITLEFONT]];
        [noticeLabel setTextColor:[UIColor whiteColor]];
        [noticeLabel setLineBreakMode:NSLineBreakByCharWrapping];
        [noticeLabel setBackgroundColor:[UIColor clearColor]];
        [scView addSubview:noticeLabel];
        [noticeLabel setLinesSpacing:8.0f];
        noticeLabel.needCoretext = YES;
        [noticeLabel release];
        
        if(_vcType == 1){
//            noticeLabel.COLOR(@"0", @"27", [UIColor whiteColor]);
            noticeLabel.COLOR(@"27", @"44", [DragonCommentMethod color:49 green:148 blue:151 alpha:1.f]);
        }else{
//            noticeLabel.COLOR(@"0", @"31", [UIColor whiteColor]);
            noticeLabel.COLOR(@"31", @"44", [DragonCommentMethod color:49 green:148 blue:151 alpha:1.f]);
        }
        
        CGFloat inputNameY = CGRectGetHeight(noticeLabel.frame) + noticeLabel.frame.origin.y + 10;
        
        inputPPNo = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,inputNameY,CGRectGetWidth(self.view.frame)-20,35)
                                          placeText:@"填写您的护照编号"
                                                img:@""
                                           fieldTag:-1];
        [inputPPNo setBackgroundColor:[UIColor whiteColor]];
        [scView addSubview:inputPPNo];
        [inputPPNo release];
        
        
        inputNameY = CGRectGetHeight(inputPPNo.frame) + inputPPNo.frame.origin.y + 5;
        
        DragonUILabel *infoLabel = [[DragonUILabel alloc] initWithFrame:CGRectMake(11, inputNameY, CGRectGetWidth(self.view.frame), 35)];
        [infoLabel setTextColor:[UIColor whiteColor]];
        [infoLabel setFont:[UIFont systemFontOfSize:BoyaINFOTITLEFONT]];
        [infoLabel setText:@"请完善学生信息（1/2）"];
        [infoLabel setFont:[UIFont systemFontOfSize:14.f]];
        [infoLabel setTextAlignment:NSTextAlignmentCenter];
        [infoLabel setBackgroundColor:[UIColor clearColor]];
        [scView addSubview:infoLabel];
        [infoLabel release];
        
        inputNameY = CGRectGetHeight(infoLabel.frame) + infoLabel.frame.origin.y + 5;
        
        NSArray *arrPlaceText = [[NSArray alloc] initWithObjects:@"填写真实姓名以兑换奖品", @"填写准确电话号码以通知领奖", @"请填写真实学校以核对兑奖信息", @"请填写真实班级以核对兑奖信息", @"请填写常用QQ", @"请填写常用邮箱", @"请填写常住地址以保证奖品送达", @"请填写常用住址邮编", nil];
        
        for (int i = 0; i < [arrPlaceText count]; i++) {
            BoyaInputView *boyainput = [[BoyaInputView alloc] initWithFrame:CGRectMake(10,
                                                                        inputNameY,
                                                                        CGRectGetWidth(self.view.frame)-20,
                                                                        35) placeText:[arrPlaceText objectAtIndex:i] img:@"" fieldTag:-(i+2)];
            
            [boyainput setBackgroundColor:[UIColor whiteColor]];
            [scView addSubview:boyainput];
            [boyainput release];
            
            if ([boyainput.placeText isEqualToString:@"填写准确电话号码以通知领奖"]) {
                [boyainput setInputText:byModel.phone];
            }else if ([boyainput.placeText isEqualToString:@"请填写常用邮箱"]){
                [boyainput setInputText:byModel.mail];
            }
            
            
            inputNameY = CGRectGetHeight(boyainput.frame) + boyainput.frame.origin.y + 5;
        }

    }else if([signal is:[DragonViewController LAYOUT_VIEWS]]){
        [_barView hideOrShowRightView:NO];
        [_barView setCenterLabelText:@"绑定护照"];
        [_barView hideOrShowbackBt:NO];
        [_barView setLeftLabelText:@""];       
        [_barView.rightBt setTitleFont:[UIFont systemFontOfSize:BoyaHEADERTITLEFONT]];
        [_barView.rightBt setTag:10];
        [_barView.rightBt addSignal:[BoyaPassportPage1ViewController BOYAPP1BUTTON] forControlEvents:UIControlEventTouchUpInside];
        [_barView setRightText:@"继续"];
    }else if ([signal is:[DragonViewController VCBACKSUCCESS]]){
        
        if (_vcType == 2) {
            BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
            [request handleLogout];
        }
    }
}


- (void)handleViewSignal_BoyaPassportPage1ViewController:(DragonViewSignal *)signal
{
    //处理button
    if ([signal is:[BoyaPassportPage1ViewController BOYAPP1BUTTON]])
    {
        DragonUIButton *bt = [signal source];
        if (bt.tag == 10){
            
            BOOL bSend = [self inPutCheck];
            
            if (bSend){
                NSMutableDictionary *dicUserInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:inputPPNo.inputText, @"sn",
                                                    ((BoyaInputView *)[self.view viewWithTag:-2]).inputText, @"stuName",
                                                    ((BoyaInputView *)[self.view viewWithTag:-3]).inputText, @"stuPhone",
                                                    ((BoyaInputView *)[self.view viewWithTag:-4]).inputText, @"school",
                                                    ((BoyaInputView *)[self.view viewWithTag:-5]).inputText, @"class",
                                                    ((BoyaInputView *)[self.view viewWithTag:-6]).inputText, @"QQ",
                                                    ((BoyaInputView *)[self.view viewWithTag:-7]).inputText, @"email",
                                                    ((BoyaInputView *)[self.view viewWithTag:-8]).inputText, @"address",
                                                    ((BoyaInputView *)[self.view viewWithTag:-9]).inputText, @"postCode",nil];
                
                BoyaPassportPage2ViewController *passport2VC = [[BoyaPassportPage2ViewController alloc] init];
                [passport2VC setDicBlindInfo:dicUserInfo];
                [passport2VC setVcType:_vcType];
                [self.drNavigationController pushViewController:passport2VC animated:YES];
                [passport2VC release];
                [dicUserInfo release];
            }
        }
    }
    
}

- (BOOL)inPutCheck{
    BOOL bSend  = YES;
    
    if([inputPPNo.inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:inputPPNo.placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-2]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-2]).placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-3]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-3]).placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-4]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-4]).placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-5]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-5]).placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-6]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-6]).placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-7]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-7]).placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-8]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-8]).placeText];
        bSend = NO;
    }else if ([((BoyaInputView *)[self.view viewWithTag:-9]).inputText length] == 0){
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:((BoyaInputView *)[self.view viewWithTag:-9]).placeText];
        bSend = NO;
    }
    
    return bSend;
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
