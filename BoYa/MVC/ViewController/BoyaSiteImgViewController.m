//
//  BoyaSiteImgViewController.m
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaSiteImgViewController.h"
#import "UIImageView+Init.h"
#import "BoyaMainViewController.h"
#import "UITableView+property.h"
#import "KeyNotes.h"
#import "BoyaParameter.h"
#import "BoyaCellForSite.h"
#import "BoyaCellForActivity.h"
#import "Dragon_CommentMethod.h"
#import "UIView+DragonCategory.h"
#import "Dragon_Request.h"
#import "BoyaNoticeView.h"
#import "BoyaHttpMethod.h"
#import "BoyaPhotoListModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Count.h"

@interface BoyaSiteImgViewController ()

@end

@implementation BoyaSiteImgViewController

@synthesize _str_placeid;

#pragma mark- ViewController信号
- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    [super handleViewSignal:signal];
    
    if ([signal is:DragonViewController.CREATE_VIEWS]) {
        
        {
            offset = 0.0;
            a = 0;
            DragonRequest *request = [BoyaHttpMethod getPhotoList:_str_placeid isAlert:YES receive:self];
            [request setTag:1];
            
            
            UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
            UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(5, kH_UINavigationController, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self.view Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            imgV.hidden=YES;
            RELEASE(imgV);
            
            orginy = imgV.frame.origin.y+imgV.frame.size.height;
            
            {
                _scrollV = [[DragonUIScrollView alloc] initWithFrame:CGRectMake(0, orginy, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-orginy)];
                _scrollV.showsHorizontalScrollIndicator = NO;
                _scrollV.userInteractionEnabled = YES;
                _scrollV.backgroundColor = [UIColor clearColor];
                _scrollV.pagingEnabled = YES;
                //_scrollV.delegate = self;
                [self.view addSubview:_scrollV];
                RELEASE(_scrollV);
            }
        }
        
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){
        
    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
        [_barView setCenterLabelText:[@"" stringByAppendingFormat:@"场馆图片(1/%d)",[_muA_photoList count]]];
        self.view.backgroundColor=[UIColor blackColor];//152 245 255
        _barView.backgroundColor=self.view.backgroundColor;
        [_barView._leftLabel changePosInSuperViewWithAlignment:2];
        
    }
    
}

#pragma mark- 只接受DragonUIImageView信号
- (void)handleViewSignal_UIImageView:(DragonViewSignal *)signal
{
    if ([signal is:[UIImageView SDWEBIMGDOWNSUCCESS]]) {
        
        UIImageView *dict = (UIImageView *)[signal source];
        
        
        [[_muA_asiScrol objectAtIndex:a] displayImage:dict.image];
        
        
    }
}


#pragma mark- 只接受UIScrollView信号
- (void)handleViewSignal_DragonUIScrollView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUIScrollView SCROLLVIEWDIDENDDECELERATING]]) {//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;滚动停止
        DLogInfo(@"");
        
        NSDictionary *dict = (NSDictionary *)[signal object];
        UIScrollView *scrollView = [dict objectForKey:@"scrollView"];
        
        if (scrollView == _scrollV){
            CGFloat x = scrollView.contentOffset.x;
            if (x==offset){
                
            }
            else {
                
                
                offset = x;
                a = offset/(_scrollV.frame.size.width);
                
                
                
               
                //删除
                if ([[_muA_asiScrol objectAtIndex:a] zoomImageView]) {
                    
                    [[[_muA_asiScrol objectAtIndex:a] zoomImageView] removeFromSuperview];
                    [((ASImageScrollView *)[_muA_asiScrol objectAtIndex:a]) releaseZoomImageView];
                }
                
                [[[_muA_asiScrol objectAtIndex:a] getzoomImageView] setImageWithURL:[NSURL URLWithString:[[_muA_photoList objectAtIndex:a]pic_url_s]] placeholderImage:[UIImage imageNamed:@"noface_32.png"]];
                [_barView setCenterLabelText:[@"" stringByAppendingFormat:@"场馆图片(%d/%d)",(a+1),[_muA_photoList count]]];
                
                
                //重置
                for (UIScrollView *s in scrollView.subviews){
                    if ([s isKindOfClass:[UIScrollView class]]){
                        [s setZoomScale:0.0];
                    }
                }
            }
        }
        
        
        
    }
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
                NSArray *list=[response.data objectForKey:@"photoList"];
                
                for (NSDictionary *d in list) {
                    BoyaPhotoListModel *Model = [BoyaPhotoListModel JSONReflection:d];
                    if (!_muA_photoList) {
                        _muA_photoList=[NSMutableArray arrayWithObject:Model];
                        [_muA_photoList retain];
                    }else{
                        [_muA_photoList addObject:Model];
                    }
                }
                
                
                _muA_asiScrol = [[NSMutableArray alloc]init];
                
                if ([_muA_photoList count] > 0) {
                    //循环创建图片
                    for (int i = 0; i < [_muA_photoList count]; i++) {
                        
                        
                        ASImageScrollView *imgV=[[ASImageScrollView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds)*i, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-orginy)];
                        imgV.backgroundColor = [UIColor clearColor];
                        imgV.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                        [_scrollV addSubview:imgV];
                        [_muA_asiScrol addObject:imgV];
                        RELEASE(imgV);
                    }
                    
                    [[[_muA_asiScrol objectAtIndex:0] zoomImageView] setImageWithURL:[NSURL URLWithString:[[[_muA_photoList objectAtIndex:0]pic_url_s] stringByAddingPercentEscapesUsingEncoding]] placeholderImage:[UIImage imageNamed:@"noface_32.png"]];
                    _scrollV.contentSize = CGSizeMake(_scrollV.frame.size.width*[_muA_photoList count], _scrollV.frame.size.height);
                    [_barView setCenterLabelText:[@"" stringByAppendingFormat:@"场馆图片(1/%d)",[_muA_photoList count]]];
                    
                }else {
                    
                  // [self sendViewSignal:[DragonUINavigationBar BUTTON_BACK]];
                    [self performSelector:@selector(test) withObject:self afterDelay:.5f];
                    
                    
                }
                
                
            }else //处理操作失败
            {
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
                
                [_barView setCenterLabelText:@"场馆图片"];
            }
            
            [self.view setUserInteractionEnabled:YES];
            
            
            
        }
        
    }else if ([request failed])
    {
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:@"网络链接失败！"];
        
    }
    
}

- (void)test
{
    [self.drNavigationController popVCAnimated:YES];
}

@end
