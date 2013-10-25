
//
//  BoyaTwoDimensionCodeViewController.m
//  BoYa
//
//  Created by cham on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaTwoDimensionCodeViewController.h"
#import "KeyNotes.h"
#import "BoyaParameter.h"
#import "BoyaMainViewController.h"
#import "Dragon_Request.h"
#import "BoyaHttpMethod.h"
#import "BoyaNoticeView.h"
#import "UIView+DragonCategory.h"
#import "BoyaRelatedMeViewController.h"
#import "UITableView+property.h"
#import "Dragon_Device.h"

@interface BoyaTwoDimensionCodeViewController ()

@end

@implementation BoyaTwoDimensionCodeViewController

@synthesize _reader;

#pragma mark- ViewController信号
- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    [super handleViewSignal:signal];
    
    if ([signal is:DragonViewController.CREATE_VIEWS]) {
        
        self.view.backgroundColor=[UIColor clearColor];
        
        //创建白色背景图
        BoyaMainViewController *mainCon=((BoyaMainViewController *)([self.drNavigationController getViewController:[BoyaMainViewController class]]));
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake(10, kH_UINavigationController+Boya_H_TOPTAB/2, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds)-kH_StateBar-(mainCon)._tabbar.frame.size.height-kH_UITabBarController-Boya_H_TOPTAB/2-kH_UINavigationController)];
        
        _backView.backgroundColor = [UIColor whiteColor];
        
        //获取二维码的label
        {
            _label = [[DragonUILabel alloc]initWithFrame:CGRectMake(0, 30, _backView.frame.size.width, 40)];
            _label.backgroundColor = [UIColor clearColor];
            _label.font = [UIFont systemFontOfSize:20];
            _label.textColor = [DragonCommentMethod color:49 green:148 blue:151 alpha:1];
            _label.text = @"";
            _label.textAlignment = NSTextAlignmentCenter;
            
            [_backView addSubview:_label];
            RELEASE(_label);
            
            _labelDesc = [[DragonUILabel alloc]initWithFrame:CGRectMake(0, 30+40+30, _backView.frame.size.width, 70)];
            _labelDesc.backgroundColor = [UIColor clearColor];
            _labelDesc.font = [UIFont systemFontOfSize:18];
            _labelDesc.textColor = [UIColor blackColor];
            _labelDesc.text = @"";
            _labelDesc.textAlignment = NSTextAlignmentCenter;
            _labelDesc.numberOfLines = 3;
            
            [_backView addSubview:_labelDesc];
            RELEASE(_labelDesc);
            
        }
        
        //重新扫描按钮||确定按钮
        {
            _btCenter = [[DragonUIButton alloc] initWithFrame:CGRectMake(75, 200, 150, 45)];
            _btCenter.hidden = YES;
            _btCenter.tag=0;
            _btCenter.adjustsImageWhenHighlighted = YES;
            
            //[_btCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_mainbtn"] forState:UIControlStateNormal];
            //_btCenter.backgroundColor = [UIColor blueColor];
            [_btCenter addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
            [_backView addSubview:_btCenter];
            RELEASE(_btCenter);
        }
        
        
        
        
        [self.view addSubview:_backView];
        RELEASE(_backView);
        [self creatZb:_backView];
        
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){
        
        
    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
        [_barView setLeftLabelText:@"二维码"];
        
        if (!_reader) {
            
            [self creatZb:_backView];
        }
    }else if ([signal is:[DragonViewController DELETE_VIEWS]])
    {
       
    }
    else if ([signal is:[DragonViewController WILL_DISAPPEAR]])
    {
        
        [self releaseZeader];
        
    }else if ([signal is:[DragonViewController WILL_APPEAR]])
    {
        [self creatZb:_backView];

    }
    
    

    
    //    DLogInfo(@"signal name === %@", signal.name);
    
}

#pragma mark - 加载照相机
- (void)creatZb:(UIView*)view {
    
    /*扫描二维码部分：
     导入ZBarSDK文件并引入一下框架
     AVFoundation.framework
     CoreMedia.framework
     CoreVideo.framework
     QuartzCore.framework
     libiconv.dylib
     引入头文件#import “ZBarSDK.h” 即可使用
     当找到条形码时，会执行代理方法
     
     - (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
     
     最后读取并显示了条形码的图片和内容。
     
     */
    
    if (!_reader) {
        _reader = [[ZbarView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
        _reader.backgroundColor = [UIColor whiteColor];
        _reader.callback = self;
        [view addSubview:_reader];

    }
   
}

#pragma mark - 返回二维码
-(void)callBackForDimensionCode:(NSString *)code {
    
    //_label.text = [@"" stringByAppendingFormat:@"二维码为:\r\n%@",code];
    
    
    [self.view setUserInteractionEnabled:NO];
    DragonRequest *request = [BoyaHttpMethod getTwoCode:code isAlert:YES receive:self];
    [request setTag:1];
    
    DLogInfo(@"=====获得二维码");
    
    
    RELEASEVIEW(_reader);
    
    
}

#pragma mark - http
- (void)handleRequest:(DragonRequest *)request receiveObj:(id)receiveObj
{
    
    if ([request succeed])
    {
        
        DLogInfo(@"request === %@", request.responseString);
        
        
        if (request.tag == 1)
        {
            DLogInfo(@"request === %@", request.responseString);
            
            BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
            
            if ([[response code] isEqualToString:@"1"])
            {
                
                NSDictionary *d=[[response data] objectForKey:@"success"];
                if ([[d objectForKey:@"code"] intValue]==1) {//提示还差多久再扫描
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[d objectForKey:@"message"]];
                    _label.text = @"扫描成功!";
                    _labelDesc.text = [d objectForKey:@"message"];
                    
                    _btCenter.hidden = YES;
                    //                    _btCenter.tag = 1;
                    //
                    //                    [_btCenter setImage:[UIImage imageNamed:@"view_a.png"] forState:UIControlStateNormal];
                    //                    [_btCenter setImage:[UIImage imageNamed:@"view_b.png"] forState:UIControlStateHighlighted];
                    
                }else if([[d objectForKey:@"code"] intValue]==2)//后续扫描成功
                {
                    _label.text = @"扫描成功!";
                    _labelDesc.text = @"您的扫描结果已添加到\r\n【与我相关】-【我游览的场馆】栏目";
                    _btCenter.hidden = NO;
                    _btCenter.tag = 1;
                    [_btCenter setImage:[UIImage imageNamed:@"view_a.png"] forState:UIControlStateNormal];
                    [_btCenter setImage:[UIImage imageNamed:@"view_b.png"] forState:UIControlStateHighlighted];
                }
                
                
            }else //处理操作失败
            {
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
                
                
                _label.text = @"扫描失败!";
                _labelDesc.text = [response message];
                _btCenter.hidden = NO;
                _btCenter.tag = 0;
                [_btCenter setImage:[UIImage imageNamed:@"scan_again_a.png"] forState:UIControlStateNormal];
                [_btCenter setImage:[UIImage imageNamed:@"scan_again_b.png"] forState:UIControlStateHighlighted];
                
            }
            
            [self.view setUserInteractionEnabled:YES];
            
        }
        
    }else if ([request failed])
    {
        
        BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
        {
            BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
            [notice setNoticeText:[response message]];
        }
        [self.view setUserInteractionEnabled:YES];
    }
    
}

#pragma mark- 只接受按钮信号
- (void)handleViewSignal_DragonUIButton:(DragonViewSignal *)signal{
    if ([signal is:[DragonUIButton TOUCH_UP_INSIDE]]) {
        DragonUIButton *bt=(DragonUIButton *)signal.source;
        
        if (bt.tag == 0) {
            
            [self creatZb:_backView];
        }
        
        if (bt.tag == 1) {
            
            //            BoyaMainViewController *mainCon=((BoyaMainViewController *)([self.drNavigationController getViewController:[BoyaMainViewController class]]));
            BoyaMainViewController *main=((BoyaMainViewController *)[[self.view superview]viewController]);
            
//            [main touchBtnAtIndex:3];
            [main._tabbar._bt3 didTouchUpInside];
            
            BoyaRelatedMeViewController *con=(BoyaRelatedMeViewController *)[[main.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG] viewController];
            con._tbv_VisitedSite._b_isNeedResizeCell=YES;
            
            
        }
        
    }
    
    
}


-(void)releaseZeader
{
    RELEASEVIEW(_reader);
}

@end
