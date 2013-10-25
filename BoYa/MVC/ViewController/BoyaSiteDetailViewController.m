//
//  BoyaSiteDetailViewController.m
//  BoYa
//
//  Created by zhangchao on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaSiteDetailViewController.h"
#import "UIImageView+Init.h"
#import "BoyaMainViewController.h"
#import "UITableView+property.h"
#import "KeyNotes.h"
#import "BoyaParameter.h"
#import "BoyaCellForSite.h"
#import "Dragon_CommentMethod.h"
#import "UIView+DragonCategory.h"
#import "BoyaCellForActivityDetail.h"
#import "BoyaCellForBus_CarMsg.h"
#import "BoyaCellForCommentDetail.h"
#import "BoyaHttpMethod.h"
#import "Dragon_Request.h"
#import "BoyaNoticeView.h"
#import "BoyaSiteCommentModel.h"
#import "UIImage+Save.h"
#import "UIView+Animations.h"
#import "Dragon_Device.h"
#import "NSString+Count.h"
#import "BoyaSiteImgViewController.h"
#import "NSString+Count.h"
#import "XiTongFaceCode.h"
#import "analysisXiTongFace.h"

@interface BoyaSiteDetailViewController ()

@end

@implementation BoyaSiteDetailViewController

@synthesize _model;

#pragma mark- ViewController信号
- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    [super handleViewSignal:signal];
    
    if ([signal is:DragonViewController.CREATE_VIEWS]) {
        //        self.view.backgroundColor=[CommentMethod color:152 green:245 blue:255 alpha:1];//152 245 255
//        self.view.userInteractionEnabled=YES;
        
//        {
//            UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
//            UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(5, kH_UINavigationController, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self.view Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
//            [imgV release];
//        }
        
        {
            _tbv = [[DragonUITableView alloc] initWithFrame:CGRectMake(10, kH_UINavigationController+Boya_H_TOPTAB/2, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds)-kH_StateBar-kH_UINavigationController-30) isNeedUpdate:YES];
            _tbv._cellH=100;
            _tbv.scrollEnabled=YES;
            [self.view addSubview:_tbv];
            _tbv.backgroundColor=/*[UIColor colorWithRed:248 green:248 blue:255 alpha:1]*/ [UIColor whiteColor];//248 248 255
            _tbv.tag=-1;
            _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
            [_tbv release];
            _tbv.headerView.hidden=YES;
            _tbv.footerView.hidden=YES;
        }
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){
        
    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
        if (_barView) {
            [_barView setCenterLabelText:@"场馆详情"];
            //        self.view.backgroundColor=[DragonCommentMethod color:152 green:245 blue:255 alpha:1];//152 245 255
            //        _barView.backgroundColor=self.view.backgroundColor;
            [_barView setLeftLabelTextColor:[UIColor whiteColor]];
            [_barView setLeftLabelFont:[UIFont systemFontOfSize:22]];
            [_barView hideOrShowbackBt:NO];
            [_barView._leftLabel changePosInSuperViewWithAlignment:2];
            
            {
//                [_barView setRightBt:@"btn_post_a" hightIMG:@"btn_post_b"];
                [_barView setRightBt:@"btn_post" hightIMG:nil];
                _barView.rightBt.tag=-1;
//                [_barView.rightBt changePosInSuperViewWithAlignment:1];

            }
        }

    }
    
    //    DLogInfo(@"signal name === %@", signal.name);
    
}

#pragma mark- 只接受tbv信号
static NSString *reuseIdentifier = @"reuseIdentifier";//场馆cell
static NSString *str_BoyaCellForActivityDetail = @"BoyaCellForActivityDetail";//场馆描述cell
static NSString *str_BoyaCellForBus_CarMsg = @"BoyaCellForBus_CarMsg";//公交|停车cell
static NSString *str_BoyaCellForCommentDetail = @"BoyaCellForCommentDetail";//评论cell

- (void)handleViewSignal_DragonUITableView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUITableView TABLENUMROWINSEC]])//numberOfRowsInSection
    {
        NSNumber *s = [NSNumber numberWithInteger:4+_muA_siteCommentList.count];
        [signal setReturnValue:s];
        
    }else if ([signal is:[DragonUITableView TABLENUMOFSEC]])//numberOfSectionsInTableView
    {
        NSNumber *s = [NSNumber numberWithInteger:1];
        [signal setReturnValue:s];
        
    }
    else if ([signal is:[DragonUITableView TABLEHEIGHTFORROW]])//heightForRowAtIndexPath
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        UITableView *tableView = [dict objectForKey:@"tableView"];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        if (indexPath.row==0) {
            if(indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0)
            {
                BoyaCellForSite *cell = [[[BoyaCellForSite alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
                [cell setContent:_model indexPath:indexPath tbv:tableView];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                
                [cell._imgV_showImg addSignal:[DragonUIImageView TAP] object:nil];

                if (!tableView._muA_differHeightCellView) {
                    tableView._muA_differHeightCellView=[NSMutableArray arrayWithCapacity:10];
                }
                if (![tableView._muA_differHeightCellView containsObject:cell]) {
                    [tableView._muA_differHeightCellView addObject:cell];
                }
                
                [signal setReturnValue:[NSNumber numberWithInteger:cell.frame.size.height]];
                //            [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
            }else{//之前计算过的cell
                //            [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
                [signal setReturnValue:[NSNumber numberWithInteger:((BoyaCellForSite *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row]).frame.size.height]];
                
            }
//            [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
        }else if (indexPath.row==1){
            if (indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0) {
                BoyaCellForActivityDetail *cell = [[[BoyaCellForActivityDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_BoyaCellForActivityDetail] autorelease];
                [cell setContent:[NSDictionary dictionaryWithObjectsAndKeys:_model.Place_content,[NSNumber numberWithInt:1], nil] indexPath:indexPath tbv:tableView];
                
                if (!tableView._muA_differHeightCellView) {
                    tableView._muA_differHeightCellView=[NSMutableArray arrayWithCapacity:10];
                }
                if (![tableView._muA_differHeightCellView containsObject:cell]) {
                    [tableView._muA_differHeightCellView addObject:cell];
                }
                
                NSNumber *s = [NSNumber numberWithInteger:cell.frame.size.height];
                [signal setReturnValue:s];
            }else{//之前计算过的cell
                NSNumber *s = [NSNumber numberWithInteger:((BoyaCellForActivityDetail *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row]).frame.size.height];
                [signal setReturnValue:s];
            }
           
        }else if (indexPath.row==2||indexPath.row==3)//公交|停车信息
        {
            if(indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0)
            {
                BoyaCellForBus_CarMsg *cell = [[[BoyaCellForBus_CarMsg alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_BoyaCellForBus_CarMsg] autorelease];
                [cell setContent:_model indexPath:indexPath tbv:tableView];
                
                if (!tableView._muA_differHeightCellView) {
                    tableView._muA_differHeightCellView=[NSMutableArray arrayWithCapacity:10];
                }
                if (![tableView._muA_differHeightCellView containsObject:cell]) {
                    [tableView._muA_differHeightCellView addObject:cell];
                }
                
                NSNumber *s = [NSNumber numberWithInteger:cell.frame.size.height];
                [signal setReturnValue:s];
                
//                if (indexPath.row==3) {//HTTP请求
//                    [self.view setUserInteractionEnabled:NO];
//                    DragonRequest *request = [BoyaHttpMethod siteCommentListByPlaceid:_model.Place_id last:@"" size:@"1" isAlert:YES receive:self];
//                    [request setTag:1];
//                }
            }else{//之前计算过的cell
                NSNumber *s = [NSNumber numberWithInteger:((BoyaCellForBus_CarMsg *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row]).frame.size.height];
                [signal setReturnValue:s];
            }
        }else if (indexPath.row>=4)//评论
        {
            if(indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0)
            {
                BoyaCellForCommentDetail *cell = [[[BoyaCellForCommentDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_BoyaCellForCommentDetail] autorelease];
                [cell setContent:[_muA_siteCommentList objectAtIndex:indexPath.row-4] indexPath:indexPath tbv:tableView];
                
                if (!tableView._muA_differHeightCellView) {
                    tableView._muA_differHeightCellView=[NSMutableArray arrayWithCapacity:10];
                }
                if (![tableView._muA_differHeightCellView containsObject:cell]) {
                    [tableView._muA_differHeightCellView addObject:cell];
                }
                
                NSNumber *s = [NSNumber numberWithInteger:cell.frame.size.height];
                [signal setReturnValue:s];
            }else{//之前计算过的cell
                NSNumber *s = [NSNumber numberWithInteger:((BoyaCellForCommentDetail *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row]).frame.size.height];
                [signal setReturnValue:s];
            }
        }
//        else if (indexPath.row==5)//更多
//        {
//            [signal setReturnValue:[NSNumber numberWithInteger:kH_cellDefault]];
//
//        }
       
    }
    else if ([signal is:[DragonUITableView TABLETITLEFORHEADERINSECTION]])//titleForHeaderInSection
    {
        [signal setReturnValue:nil];
        
    }
    else if ([signal is:[DragonUITableView TABLEVIEWFORHEADERINSECTION]])//viewForHeaderInSection
    {
        [signal setReturnValue:nil];
        
    }//
    else if ([signal is:[DragonUITableView TABLETHEIGHTFORHEADERINSECTION]])//heightForHeaderInSection
    {
        [signal setReturnValue:[NSNumber numberWithFloat:0.0]];
    }
    else if ([signal is:[DragonUITableView TABLECELLFORROW]])//cell
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        UITableView *tableview = [dict objectForKey:@"tableView"];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        switch (indexPath.row) {
            case 0:
            case 1://场馆描述
            case 2://公交信息
            case 3://停车信息
            default://评论
            {
                if (indexPath.row==3 &&_muA_siteCommentList.count==0) {//HTTP请求
//                    [self.view setUserInteractionEnabled:NO];
                    DragonRequest *request = [BoyaHttpMethod siteCommentListByPlaceid:_model.Place_id last:@"" size:@"1" isAlert:NO receive:self];
                    [request setTag:1];
                }
                [signal setReturnValue:[tableview._muA_differHeightCellView objectAtIndex:(indexPath.row)]];
            }
                
                break;
        }
        
    }else if ([signal is:[DragonUITableView TABLEDIDSELECT]])//选中cell
    {

    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDENDDRAGGING]])//滚动停止
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        DragonUITableView *tableview = [dict objectForKey:@"scrollView"];
        //        BOOL decelerate = [[dict objectForKey:@"decelerate"] boolValue];
        
        {
            switch ([tableview tableViewDidEndDragging]) {
                case RETURNLOADMORE://加载更多
                {//HTTP请求
                    [self.view setUserInteractionEnabled:NO];
                    BoyaSiteModel *model=[_muA_siteCommentList objectAtIndex:_muA_siteCommentList.count-1];
                    DragonRequest *request = [BoyaHttpMethod siteCommentListByPlaceid:model.Place_id last:model.orderid size:k_PageSize isAlert:YES receive:self];
                    [request setTag:2];
                    
                    if (!request) {//无网路
                        [_tbv.footerView changeState:VIEWTYPEFOOTER];
                        [self.view setUserInteractionEnabled:YES];
                    }
                }
                    break;
                case RETURNREFRESH:
                {
                    [UIView animateWithDuration:0.0 animations:^{//避免_tbv.headerView隐藏时下拉后没自动上回
                    }completion:^(BOOL b){
                        [_tbv.headerView changeState:VIEWTYPEHEADER];
                    }];
                }
                    break;
                default:
                    break;
            }
        }
    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDSCROLL]])
    {
        [_tbv tableViewDidDragging];
    }
}

#pragma mark- 只接受按钮信号
- (void)handleViewSignal_DragonUIButton:(DragonViewSignal *)signal{
    if ([signal is:[DragonUIButton TOUCH_UP_INSIDE]]) {
        DragonUIButton *bt=(DragonUIButton *)signal.source;
        switch (bt.tag) {
            case -1://场馆评论
            {
                if (!_v_comment) {
                    _v_comment=[[UIView alloc]initWithFrame:CGRectMake(0, -kH_StateBar, screen.size.width, screen.size.height)];
                    _v_comment.backgroundColor=[UIColor blackColor];
//                    [[[UIApplication sharedApplication]keyWindow]addSubview:_v_comment];
                    [self.view addSubview:_v_comment];
                    [_v_comment release];
                    
                    if(!_v_input){
                        //                    UIImage *img=[UIImage imageNamed:@"input.png"];
                        //                    img=[img stretchableImageWithLeftCapWidth:self.view.frame.size.width-20 topCapHeight:125];
                        [_v_input= [BoyaCustomInputView alloc]initWithFrame:CGRectMake(10, 60, self.view.frame.size.width-20, 125) input_bg:nil placeHolder:@"请输入评论文字" btSignal:nil];
                        [self.view addSubview:_v_input];
                        _v_input._originFrame=CGRectMake(_v_input.frame.origin.x, _v_input.frame.origin.y, _v_input.frame.size.width, _v_input.frame.size.height);
                        [_v_input release];
                        [_v_input._textV becomeFirstResponder];
                        _v_input._textV.maxLength=140;
                        _v_input.alpha=0;
                        
                        
                        _statusLabel = [[DragonUILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 160, 50, 25)];
                        _statusLabel.backgroundColor = [UIColor clearColor];
                        _statusLabel.textColor = [UIColor grayColor];
                        _statusLabel.font = [UIFont systemFontOfSize:13];
                        _statusLabel.textAlignment = UITextAlignmentLeft;
                        _statusLabel.text = @"0/140";
                        [self.view addSubview:_statusLabel];
//                        RELEASE(_statusLabel);
                        
                    }
                    
                    {//取消按钮
                        DragonUIButton *bt_cancel = [[DragonUIButton alloc] initWithFrame:CGRectMake(15, 15, 40, 20)];
                        bt_cancel.tag=-2;
                        bt_cancel.adjustsImageWhenHighlighted = YES;
                        [bt_cancel setTitle:@"取消"];
                        bt_cancel.backgroundColor=[UIColor clearColor];
                        [bt_cancel setTitleFont:[UIFont boldSystemFontOfSize:19]];
                        //                        [_btCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_mainbtn"] forState:UIControlStateNormal];
                        [bt_cancel addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                        [self.view addSubview:bt_cancel];
                        [bt_cancel release];
                        bt_cancel.alpha=0;
                        
                        {//发送按钮
                            DragonUIButton *bt_send = [[DragonUIButton alloc] initWithFrame:CGRectMake(screenShows.size.width-55, bt_cancel.frame.origin.y, bt_cancel.frame.size.width,bt_cancel.frame.size.height)];
                            bt_send.tag=-3;
                            bt_send.adjustsImageWhenHighlighted = YES;
                            [bt_send setTitle:@"发送"];
                            bt_send.backgroundColor=[UIColor clearColor];
                            [bt_send setTitleFont:[UIFont boldSystemFontOfSize:19]];
//                        [_btCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_mainbtn"] forState:UIControlStateNormal];
                            [bt_send addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                            [self.view addSubview:bt_send];
                            [bt_send release];
                            bt_send.alpha=0;
                        }
                    }
                    
                    {//得分按钮
                        if (!_bt_Score1) {
                            UIImage *img=[UIImage imageNamed:@"star_no"];
                            _bt_Score1 = [[DragonUIButton alloc] initWithFrame:CGRectMake(_v_input.frame.origin.x, _v_input.frame.origin.y+_v_input.frame.size.height+5, img.size.width/2,img.size.height/2)];
                            _bt_Score1.tag=-101;
                            _bt_Score1.adjustsImageWhenHighlighted = YES;
                            _bt_Score1.backgroundColor=[UIColor clearColor];
                            [_bt_Score1 setImage:img forState:UIControlStateNormal];
                            [_bt_Score1 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                            [self.view addSubview:_bt_Score1];
                            [_bt_Score1 release];
                            _bt_Score1.alpha=0;
                        }
                        
                        if (!_bt_Score2) {
                            UIImage *img=[UIImage imageNamed:@"star_no"];
                            _bt_Score2 = [[DragonUIButton alloc] initWithFrame:CGRectMake(_bt_Score1.frame.origin.x+_bt_Score1.frame.size.width+10, _bt_Score1.frame.origin.y, img.size.width/2,img.size.height/2)];
                            _bt_Score2.tag=-102;
                            _bt_Score2.adjustsImageWhenHighlighted = YES;
                            _bt_Score2.backgroundColor=[UIColor clearColor];
                            [_bt_Score2 setImage:img forState:UIControlStateNormal];
                            [_bt_Score2 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                            [self.view addSubview:_bt_Score2];
                            [_bt_Score2 release];
                            _bt_Score2.alpha=0;
                        }
                        
                        if (!_bt_Score3) {
                            UIImage *img=[UIImage imageNamed:@"star_no"];
                            _bt_Score3 = [[DragonUIButton alloc] initWithFrame:CGRectMake(_bt_Score2.frame.origin.x+_bt_Score2.frame.size.width+10, _bt_Score1.frame.origin.y, img.size.width/2,img.size.height/2)];
                            _bt_Score3.tag=-103;
                            _bt_Score3.adjustsImageWhenHighlighted = YES;
                            _bt_Score3.backgroundColor=[UIColor clearColor];
                            [_bt_Score3 setImage:img forState:UIControlStateNormal];
                            [_bt_Score3 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                            [self.view addSubview:_bt_Score3];
                            [_bt_Score3 release];
                            _bt_Score3.alpha=0;
                        }
                        
                        if (!_bt_Score4) {
                            UIImage *img=[UIImage imageNamed:@"star_no"];
                            _bt_Score4 = [[DragonUIButton alloc] initWithFrame:CGRectMake(_bt_Score3.frame.origin.x+_bt_Score3.frame.size.width+10, _bt_Score3.frame.origin.y, img.size.width/2,img.size.height/2)];
                            _bt_Score4.tag=-104;
                            _bt_Score4.adjustsImageWhenHighlighted = YES;
                            _bt_Score4.backgroundColor=[UIColor clearColor];
                            [_bt_Score4 setImage:img forState:UIControlStateNormal];
                            [_bt_Score4 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                            [self.view addSubview:_bt_Score4];
                            [_bt_Score4 release];
                            _bt_Score4.alpha=0;
                        }
                        
                        if (!_bt_Score5) {
                            UIImage *img=[UIImage imageNamed:@"star_no"];
                            _bt_Score5 = [[DragonUIButton alloc] initWithFrame:CGRectMake(_bt_Score4.frame.origin.x+_bt_Score4.frame.size.width+10, _bt_Score4.frame.origin.y, img.size.width/2,img.size.height/2)];
                            _bt_Score5.tag=-105;
                            _bt_Score5.adjustsImageWhenHighlighted = YES;
                            _bt_Score5.backgroundColor=[UIColor clearColor];
                            [_bt_Score5 setImage:img forState:UIControlStateNormal];
                            [_bt_Score5 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                            [self.view addSubview:_bt_Score5];
                            [_bt_Score5 release];
                            _bt_Score5.alpha=0;
                        }
                    }
                    
                    [UIView animateWithDuration:0.3 animations:^{
//                        _v_comment.backgroundColor=[DragonCommentMethod color:54 green:54 blue:54 alpha:1];
                        _v_comment.alpha=0.8;
                        _v_input.alpha=1;
                        _bt_Score1.alpha=1;
                        _bt_Score2.alpha=1;
                        _bt_Score3.alpha=1;
                        _bt_Score4.alpha=1;
                        _bt_Score5.alpha=1;

                        [self.view viewWithTag:-2].alpha=1;
                        [self.view viewWithTag:-3].alpha=1;
                    }];
                    
                    score=0;
                }
                
              
            }
                break;
                
            case -2://取消按钮
            {
                {//收起键盘
                    [_v_input._textV setActive:NO];
                    
                    [_v_input removeFromSuperview];
                    _v_input=nil;
                    
                }
                
                [_v_comment removeFromSuperview];
                _v_comment=nil;
                
                [[self.view viewWithTag:-2] removeFromSuperview];
                [[self.view viewWithTag:-3] removeFromSuperview];
                [_bt_Score1 removeFromSuperview];
                _bt_Score1=nil;
                [_bt_Score2 removeFromSuperview];
                _bt_Score2=nil;
                [_bt_Score3 removeFromSuperview];
                _bt_Score3=nil;
                [_bt_Score4 removeFromSuperview];
                _bt_Score4=nil;
                [_bt_Score5 removeFromSuperview];
                _bt_Score5=nil;
                
                RELEASEVIEW(_statusLabel);
            }
                break;
                
            case -3://发送按钮
            {
                if ([DragonDevice hasInternetConnection] == NO) {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:@"发送失败，请检查网络！"];
                    break;
                }
                
                if ((_v_input._textV.text=[_v_input._textV.text TrimmingStringBywhitespaceCharacterSet]).length>0/*避免空内容*/) {
                    [self.view setUserInteractionEnabled:NO];
                    
                    {//HTTP请求
                        [self.view setUserInteractionEnabled:NO];
                        DragonRequest *request = [BoyaHttpMethod sendSiteCommentByContent:((_v_input._textV.text=[_v_input._textV.text stringByReplacingOccurrencesOfString:@"'" withString:@"\\'" options:NSCaseInsensitiveSearch range:NSMakeRange(0, _v_input._textV.text.length)])) placeid:_model.Place_id v:[NSString stringWithFormat:@"%d",score] isAlert:YES receive:self];
                        [request setTag:3];
                    }
                }
            }
                break;
                
            case -101://得分按钮1
            case -102:
            case -103:
            case -104:
            case -105:
            {
               
                bt.selected=!bt.selected;
                [bt setImage:((bt.selected)?([UIImage imageNamed:@"star_yes"]):([UIImage imageNamed:@"star_no"])) forState:UIControlStateNormal];
                
                if (!bt.selected) {
                    score--;
                    
                    for (int i=1; i<bt.tag+106; i++) {
                        DragonUIButton *bt_other=(DragonUIButton *)[self.view viewWithTag:bt.tag-i];
                        if (bt_other.selected) {
                            bt_other.selected=!bt_other.selected;
                            [bt_other setImage:((bt_other.selected)?([UIImage imageNamed:@"star_yes"]):([UIImage imageNamed:@"star_no"])) forState:UIControlStateNormal];
                            score--;
                        }
                    }
                    
                    
                }else{
                    score++;
                    
                    for (int i=1; i<(bt.tag*-1)-100; i++) {
                        DragonUIButton *bt_other=(DragonUIButton *)[self.view viewWithTag:bt.tag+i];
                        if (!bt_other.selected) {
                            bt_other.selected=!bt_other.selected;
                            [bt_other setImage:((bt_other.selected)?([UIImage imageNamed:@"star_yes"]):([UIImage imageNamed:@"star_no"])) forState:UIControlStateNormal];
                            score++;
                        }
                    }
                }
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark- 只接受DragonUIImageView信号
- (void)handleViewSignal_DragonUIImageView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUIImageView TAP]]) {
        BoyaSiteImgViewController *con=[[BoyaSiteImgViewController alloc]init];
        //        BoyaMainViewController *mainCon=(BoyaMainViewController *)[[self.view superview] viewController];
        con._str_placeid=_model.Place_id;
        [self.drNavigationController pushViewController:con animated:YES];
        [con release];
    }
}


#pragma mark- 只接受UITextView信号
- (void)handleViewSignal_DragonUITextView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUITextView TEXTVIEWSHOULDBEGINEDITING]])//textViewShouldBeginEditing
    {
        DLogInfo(@"");
    }else  if ([signal is:[DragonUITextView TEXTVIEWDIDBEGINEDITING]])//textViewDidBeginEditing
    {
        
    }else  if ([signal is:[DragonUITextView TEXT_OVERFLOW]])//文字超长
    {
        [signal returnNO];
        
    }else  if ([signal is:[DragonUITextView TEXTVIEW]])//shouldChangeTextInRange
    {
        NSMutableDictionary *muD = (NSMutableDictionary *)[signal object];
        NSString *emString=[muD objectForKey:@"text"];
        
        if ([NSString isContainsEmoji:emString]) {
            
            [signal setReturnValue:[DragonViewSignal NO_VALUE]];
        }

        
    }else  if ([signal is:[DragonUITextView TEXTVIEWDIDCHANGE]])//textViewDidChange
    {
        NSMutableDictionary *muD = (NSMutableDictionary *)[signal object];
        DragonUITextView *textView=[muD objectForKey:@"textView"];
        
        _statusLabel.text = [@"" stringByAppendingFormat:@"%d/140",[textView.text length]];
        
    }else  if ([signal is:[DragonUITextView TEXTVIEWDIDCHANGESELECTION]])//textViewDidChangeSelection
    {
    }else  if ([signal is:[DragonUITextView TEXTVIEWSHOULDENDEDITING]])//textViewShouldEndEditing
    {
        
    }else  if ([signal is:[DragonUITextView TEXTVIEWDIDENDEDITING]])//textViewDidEndEditing
    {
       
    }
}


#pragma mark- HTTP
- (void)handleRequest:(DragonRequest *)request receiveObj:(id)receiveObj
{
    
    if ([request succeed])
    {
        switch (request.tag) {
            case 1://获取场馆评论列表
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"commentList"];
                    for (NSDictionary *d in list) {
                        BoyaSiteCommentModel *Model = [BoyaSiteCommentModel JSONReflection:d];
                        if (!_muA_siteCommentList) {
                            _muA_siteCommentList=[NSMutableArray arrayWithObject:Model];
                            [_muA_siteCommentList retain];
                        }else{
                            [_muA_siteCommentList addObject:Model];
                        }                        
                    }
                    
                    if (_muA_siteCommentList.count>0) {
                        [_tbv reloadData:NO];
                        _tbv.footerView.hidden=NO;
                    }
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [self.view setUserInteractionEnabled:YES];
                
            }
                break;
                
            case 2://加载更多场馆列表
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"commentList"];
                    for (NSDictionary *d in list) {
                        BoyaSiteCommentModel *Model = [BoyaSiteCommentModel JSONReflection:d];
                        {
                            [_muA_siteCommentList addObject:Model];
                        }                        
                    }
                    
                    if (list.count>0) {
                        [_tbv reloadData:NO];
                        
                    }else{
                        [_tbv.footerView changeState:PULLSTATEEND];
                    }
                    
                    [self.view setUserInteractionEnabled:YES];
                    return;
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [self.view setUserInteractionEnabled:YES];
                [_tbv.footerView changeState:PULLSTATEEND];
                
                
            }
                break;
            case 3://提交场馆评论
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    {
                        {//收起键盘
                            [_v_input._textV setActive:NO];
                            
                            [_v_input removeFromSuperview];
                            _v_input=nil;
                            
                        }
                        
                        [_v_comment removeFromSuperview];
                        _v_comment=nil;
                        
                        [[self.view viewWithTag:-2] removeFromSuperview];
                        [[self.view viewWithTag:-3] removeFromSuperview];
                        [_bt_Score1 removeFromSuperview];
                        _bt_Score1=nil;
                        [_bt_Score2 removeFromSuperview];
                        _bt_Score2=nil;
                        [_bt_Score3 removeFromSuperview];
                        _bt_Score3=nil;
                        [_bt_Score4 removeFromSuperview];
                        _bt_Score4=nil;
                        [_bt_Score5 removeFromSuperview];
                        _bt_Score5=nil;
                        
                        RELEASEVIEW(_statusLabel);
                    }
                    
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                    
                    {//重新加载评论列表
                        [_muA_siteCommentList removeAllObjects];
                        [_tbv._muA_differHeightCellView removeAllObjects];
                        {//HTTP请求
                            [self.view setUserInteractionEnabled:NO];
                            DragonRequest *request = [BoyaHttpMethod siteCommentListByPlaceid:_model.Place_id last:@"" size:@"1" isAlert:YES receive:self];
                            [request setTag:1];
                        }
                    }
                   
                    
                    [self.view setUserInteractionEnabled:YES];
                    return;
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [self.view setUserInteractionEnabled:YES];
                [_tbv.footerView changeState:PULLSTATEEND];
                
                
            }
                break;
            default:
                break;
        }
        
    }else if ([request failed])
    {
        BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
        {
            BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
            [notice setNoticeText:[response message]];
        }
        [self.view setUserInteractionEnabled:YES];
        
        if (request.tag==2) {
            [_tbv.footerView changeState:VIEWTYPEFOOTER];
        }
    }
    
}


@end
