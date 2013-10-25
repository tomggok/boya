//
//  BoyaRelatedMeViewController.m
//  BoYa
//
//  Created by zhangchao on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaRelatedMeViewController.h"
#import "UIImageView+Init.h"
#import "BoyaMainViewController.h"
#import "UITableView+property.h"
#import "KeyNotes.h"
#import "BoyaParameter.h"
#import "BoyaCellForSite.h"
#import "BoyaCellForActivity.h"
#import "Dragon_CommentMethod.h"
#import "BoyaHttpMethod.h"
#import "Dragon_Request.h"
#import "BoyaNoticeView.h"
#import "BoyaSiteModel.h"
#import "BoyaActivityModel.h"
#import "BoyaSiteDetailViewController.h"
#import "UIView+DragonCategory.h"
#import "BoyaActivityDetailViewController.h"
#import "ShowDetailsViewController.h"
#import "Dragon_CommentMethod.h"
#import "UIViewController+KNSemiModal.h"

@interface BoyaRelatedMeViewController ()

@end

@implementation BoyaRelatedMeViewController

@synthesize _tbv_VisitedSite;

//生成无数据或无网络时提示按钮的背景和提示按钮
-(void)createNoDataBackView:(NSInteger)type/*0: 无网络  1:无数据*/
{
    if (!_v_noDataBackView) {
        BoyaMainViewController *mainCon=((BoyaMainViewController *)([self.drNavigationController getViewController:[BoyaMainViewController class]]));

        _v_noDataBackView=[[UIView alloc]initWithFrame:CGRectMake(10, kH_UINavigationController+Boya_H_TOPTAB, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds)-kH_StateBar-(mainCon)._tabbar.frame.size.height-kH_UITabBarController)];
        _v_noDataBackView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:_v_noDataBackView];
        [_v_noDataBackView release];
        
        {
            UIImage *img=[UIImage imageNamed:((type==0)?(@"bg_noNet"):(@"bg_noContents"))];
            DragonUIButton *bt = [[DragonUIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
            bt.tag=-3;
            [bt setImage:img forState:UIControlStateNormal];
            [bt addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
            [bt addSignal:[DragonUIButton TOUCH_DOWN] forControlEvents:UIControlEventTouchDown];
            [_v_noDataBackView addSubview:bt];
            [bt release];
            [bt changePosInSuperViewWithAlignment:2];
        }
    }else{
        _v_noDataBackView.hidden=NO;
        
        DragonUIButton *bt=(DragonUIButton *)[_v_noDataBackView viewWithTag:-3];
        UIImage *img=[UIImage imageNamed:((type==0)?(@"bg_noNet"):(@"bg_noContents"))];
        [bt setFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
        [bt setImage:img forState:UIControlStateNormal];
        [bt changePosInSuperViewWithAlignment:2];
    }
}

#pragma mark- ViewController信号
- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    [super handleViewSignal:signal];
    
    if ([signal is:DragonViewController.CREATE_VIEWS]) {
        self.view.backgroundColor=[UIColor clearColor];
        self.view.userInteractionEnabled=YES;
        
        {
            UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
            UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(5, kH_UINavigationController, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self.view Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [imgV release];
            imgV.hidden=YES;
            
            {
                _bt_VisitedSite = [[DragonUIButton alloc] initWithFrame:CGRectMake(10, imgV.frame.origin.y+imgV.frame.size.height+5, 150, 30)];
                _bt_VisitedSite.tag=-1;
                [_bt_VisitedSite setTitle:@"我游览的场馆"];
                [_bt_VisitedSite setTitleFont:[UIFont systemFontOfSize:17]];
                [_bt_VisitedSite addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                [_bt_VisitedSite addSignal:[DragonUIButton TOUCH_DOWN] forControlEvents:UIControlEventTouchDown];
                _bt_VisitedSite.backgroundColor=[DragonCommentMethod color:95 green:158 blue:160 alpha:1];//   95 158 160
                [self.view addSubview:_bt_VisitedSite];
                [_bt_VisitedSite release];
            }
        }
        
        {
            _bt_RegisteredActivity = [[DragonUIButton alloc] initWithFrame:CGRectMake(_bt_VisitedSite.frame.origin.x+_bt_VisitedSite.frame.size.width, _bt_VisitedSite.frame.origin.y, _bt_VisitedSite.frame.size.width, _bt_VisitedSite.frame.size.height)];
            _bt_RegisteredActivity.tag=-2;
            [_bt_RegisteredActivity setTitle:@"我报名的活动"];
            [_bt_RegisteredActivity setTitleFont:[UIFont systemFontOfSize:17]];
            [_bt_RegisteredActivity addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
            [_bt_RegisteredActivity addSignal:[DragonUIButton TOUCH_DOWN] forControlEvents:UIControlEventTouchDown];
            _bt_RegisteredActivity.backgroundColor=[UIColor clearColor];
            
            [self.view addSubview:_bt_RegisteredActivity];
            [_bt_RegisteredActivity release];
        }
        
        {
            BoyaMainViewController *mainCon=((BoyaMainViewController *)([self.drNavigationController getViewController:[BoyaMainViewController class]]));
            _tbv_VisitedSite = [[DragonUITableView alloc] initWithFrame:CGRectMake(10, kH_UINavigationController+Boya_H_TOPTAB, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds)-kH_StateBar-(mainCon)._tabbar.frame.size.height-kH_UITabBarController-Boya_H_TOPTAB) isNeedUpdate:YES];
            _tbv_VisitedSite._cellH=100;
//            [self.view addSubview:_tbv_VisitedSite];
            _tbv_VisitedSite.backgroundColor=/*[UIColor colorWithRed:248 green:248 blue:255 alpha:1]*/ [UIColor whiteColor];//248 248 255
            _tbv_VisitedSite.tag=-1;
            _tbv_VisitedSite.separatorStyle=UITableViewCellSeparatorStyleNone;
//            [_tbv_VisitedSite release];
        }
        
        {
            _v_whiteView=[[UIView alloc]initWithFrame:_tbv_VisitedSite.frame];
            _v_whiteView.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:_v_whiteView];
            [_v_whiteView release];
        }
        
        {//我浏览的场馆列表 HTTP请求
            [self.view setUserInteractionEnabled:NO];
            DragonRequest *request = [BoyaHttpMethod myPlaceListByLast:@"" size:k_PageSize isAlert:YES receive:self];
            [request setTag:1];
            
            if (!request) {//无网路
                [self.view setUserInteractionEnabled:YES];
                [self createNoDataBackView:0];
            }
        }
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){
        
        if (_tbv_VisitedSite._b_isNeedResizeCell && _tbv_VisitedSite.superview) {//我浏览的场馆列表 HTTP请求
            
            [_bt_VisitedSite didTouchUpInside];

            [self.view setUserInteractionEnabled:NO];
            DragonRequest *request = [BoyaHttpMethod myPlaceListByLast:@"" size:k_PageSize isAlert:YES receive:self];
            [request setTag:3];
            if (!request) {//无网路
                [_tbv_VisitedSite.headerView changeState:VIEWTYPEHEADER];
                [self.view setUserInteractionEnabled:YES];
            }
            
            (_tbv_VisitedSite._b_isNeedResizeCell)=NO;
        }else if (_tbv_VisitedSite._b_isNeedResizeCell && !_tbv_VisitedSite.superview){//从二维码扫描界面跳到此页面且_tbv_VisitedSite的数据源还没下载
            [_bt_VisitedSite didTouchUpInside];
            (_tbv_VisitedSite._b_isNeedResizeCell)=NO;
        }
    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
        [_barView setLeftLabelText:@"与我相关"];
//        self.view.backgroundColor=[DragonCommentMethod color:152 green:245 blue:255 alpha:1];//152 245 255
//        _barView.backgroundColor=self.view.backgroundColor;
    }
    
}

#pragma mark- 只接受tbv信号
static NSString *reuseIdentifier_BoyaCellForSite = @"reuseIdentifier_BoyaCellForSite";
static NSString *reuseIdentifier_BoyaCellForActivity = @"reuseIdentifier_BoyaCellForActivity";//我报名的活动cell

- (void)handleViewSignal_DragonUITableView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUITableView TABLENUMROWINSEC]])//numberOfRowsInSection
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        UITableView *tableView = [dict objectForKey:@"tableView"];
        
        NSNumber *s = [NSNumber numberWithInteger:((tableView.tag==-1)?(_muA_siteListData.count):(_muA_ActivityListData.count))];
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
        
        switch (tableView.tag) {
            case -1://我浏览的场馆
            {
                
                if(indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0)
                {
                    BoyaCellForSite *cell = [[[BoyaCellForSite alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier_BoyaCellForSite] autorelease];
                    [cell setContent:[_muA_siteListData objectAtIndex:indexPath.row] indexPath:indexPath tbv:tableView];
                    
                    if (!tableView._muA_differHeightCellView) {
                        tableView._muA_differHeightCellView=[NSMutableArray arrayWithCapacity:10];
                    }
                    if (![tableView._muA_differHeightCellView containsObject:cell]) {
                        [tableView._muA_differHeightCellView addObject:cell];
                    }
                    
                    //            NSNumber *s = [NSNumber numberWithInteger:cell.frame.size.height];
//                    [signal setReturnValue:[NSNumber numberWithInt:tableView._cellH]];
                    [signal setReturnValue:[NSNumber numberWithInteger:cell.frame.size.height]];
                }else{//之前计算过的cell
                    //            NSNumber *s = [NSNumber numberWithInteger:((BoyaCellForSite *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row-1]).frame.size.height];
                    [signal setReturnValue:[NSNumber numberWithInteger:((BoyaCellForSite *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row]).frame.size.height]];
                }
            }
                break;
            case -2://我参与的活动
            {
                if(indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0)
                {
                    BoyaCellForActivity *cell = [[[BoyaCellForActivity alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier_BoyaCellForActivity] autorelease];
                    [cell setContent:[_muA_ActivityListData objectAtIndex:indexPath.row] indexPath:indexPath tbv:tableView];
                    
                    if (!tableView._muA_differHeightCellView) {
                        tableView._muA_differHeightCellView=[NSMutableArray arrayWithCapacity:10];
                    }
                    if (![tableView._muA_differHeightCellView containsObject:cell]) {
                        [tableView._muA_differHeightCellView addObject:cell];
                    }
                    
                    //            NSNumber *s = [NSNumber numberWithInteger:cell.frame.size.height];
//                    [signal setReturnValue:[NSNumber numberWithInt:tableView._cellH]];
                    [signal setReturnValue:[NSNumber numberWithInteger:cell.frame.size.height]];
                }else{//之前计算过的cell
                    //            NSNumber *s = [NSNumber numberWithInteger:((BoyaCellForSite *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row-1]).frame.size.height];
//                    [signal setReturnValue:[NSNumber numberWithInt:tableView._cellH]];
                    [signal setReturnValue:[NSNumber numberWithInteger:((BoyaCellForActivity *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row]).frame.size.height]];
                }
            }
                break;
            default:
                break;
        }
        
        
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
        
        [signal setReturnValue:[tableview._muA_differHeightCellView objectAtIndex:(indexPath.row)]];
        
        if (tableview.contentSize.height<tableview.frame.size.height) {
            ((DragonUITableView *)tableview).footerView.hidden=YES;
        }else{
            ((DragonUITableView *)tableview).footerView.hidden=NO;
        }
        
    }else if ([signal is:[DragonUITableView TABLEDIDSELECT]])//选中cell
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        UITableView *tableview = [dict objectForKey:@"tableView"];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        
        switch (tableview.tag) {
            case -1:
            {
                BoyaSiteDetailViewController *con=[[BoyaSiteDetailViewController alloc]init];
                con._model=[_muA_siteListData objectAtIndex:indexPath.row];
                
                BoyaMainViewController *mainCon=(BoyaMainViewController *)[[self.view superview] viewController];
                [mainCon.drNavigationController pushViewController:con animated:YES];
                [con release];
            }
                break;
            case -2:
            {
                NSDictionary *dict = (NSDictionary *)[signal object];
                //        UITableView *tableview = [dict objectForKey:@"tableView"];
                NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
                
                BoyaActivityDetailViewController *con=[[BoyaActivityDetailViewController alloc]init];
                con._model=[_muA_ActivityListData objectAtIndex:indexPath.row];
                BoyaMainViewController *mainCon=(BoyaMainViewController *)[[self.view superview] viewController];
                [mainCon.drNavigationController pushViewController:con animated:YES];
                [con release];
                
            }
                break;
            default:
                break;
        }
        
        [tableview deselectRowAtIndexPath:indexPath animated:YES];
       
    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDENDDRAGGING]])//滚动停止
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        DragonUITableView *tableview = [dict objectForKey:@"scrollView"];
//        BOOL decelerate = [[dict objectForKey:@"decelerate"] boolValue];
        
        switch (tableview.tag) {
            case -1://我浏览的场馆
            {
                switch ([tableview tableViewDidEndDragging]) {
                    case RETURNREFRESH://下拉刷新
                    {//我浏览的场馆列表 HTTP请求
                        [self.view setUserInteractionEnabled:NO];
                        DragonRequest *request = [BoyaHttpMethod myPlaceListByLast:@"" size:k_PageSize isAlert:YES receive:self];
                        [request setTag:3];
                        if (!request) {//无网路
                            [_tbv_VisitedSite.headerView changeState:VIEWTYPEHEADER];
                            [self.view setUserInteractionEnabled:YES];
                        }
                    }
                        break;
                    case RETURNLOADMORE://加载更多
                    {//我浏览的场馆列表 HTTP请求
                        [self.view setUserInteractionEnabled:NO];
                        BoyaSiteModel *model=[_muA_siteListData objectAtIndex:_muA_siteListData.count-1];
                        DragonRequest *request = [BoyaHttpMethod myPlaceListByLast:model.orderid size:k_PageSize isAlert:YES receive:self];
                        [request setTag:2];
                        
                        if (!request) {//无网路
                            [_tbv_VisitedSite.footerView changeState:VIEWTYPEFOOTER];
                            [self.view setUserInteractionEnabled:YES];
                        }

                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            case -2://我参与的活动
            {
                switch ([tableview tableViewDidEndDragging]) {
                    case RETURNREFRESH://下拉刷新
                    {//我报名的活动列表 HTTP请求
                        [self.view setUserInteractionEnabled:NO];
                        DragonRequest *request = [BoyaHttpMethod myActiveListBylast:@"" size:k_PageSize isAlert:YES receive:self];
                        [request setTag:5];
                        
                        if (!request) {//无网路
                            [_tbv_RegisteredActivity.headerView changeState:VIEWTYPEHEADER];
                            [self.view setUserInteractionEnabled:YES];
                        }
                    }
                        break;
                    case RETURNLOADMORE://加载更多
                    {//我报名的活动列表 HTTP请求
                        [self.view setUserInteractionEnabled:NO];
                        DragonRequest *request = [BoyaHttpMethod myActiveListBylast:((BoyaActivityModel *)[_muA_ActivityListData objectAtIndex:_muA_ActivityListData.count-1]).orderid size:k_PageSize isAlert:YES receive:self];
                        [request setTag:6];
                        
                        if (!request) {//无网路
                            [_tbv_RegisteredActivity.footerView changeState:VIEWTYPEFOOTER];
                            [self.view setUserInteractionEnabled:YES];
                        }
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDSCROLL]])
    {
        [_tbv_VisitedSite tableViewDidDragging];
        [_tbv_RegisteredActivity tableViewDidDragging];
    }
}

#pragma mark- 接受DragonUIImageView信号
- (void)handleViewSignal_DragonUIImageView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUIImageView TAP]]) {
        DragonUIImageView *imgV=signal.source;
        
        //        ShowDetailsViewController *con=[[ShowDetailsViewController alloc]initWithImg:imgV.image];
        BoyaMainViewController *mainCon=(BoyaMainViewController *)[[self.view superview] viewController];
        {
            _scrollV = [[ASImageScrollView alloc] initWithFrame:self.view.bounds];
            [_scrollV displayImage:imgV.image];
            [self.view addSubview:_scrollV];
            [_scrollV release];
            _scrollV.hidden=YES;
        }
        [mainCon presentSemiView:_scrollV];
        
        //        [imgV release];
    }
}

#pragma mark- 只接受Bt信号
- (void)handleViewSignal_DragonUIButton:(DragonViewSignal *)signal{
    if ([signal is:[DragonUIButton TOUCH_UP_INSIDE]]) {
        DragonUIButton *bt=(DragonUIButton *)signal.source;
//        _bt_VisitedSite.selected=!_bt_VisitedSite.selected;
//        _bt_RegisteredActivity.selected=!_bt_RegisteredActivity.selected;

        switch (bt.tag) {
            case -1://我浏览的场馆
            {
                _bt_RegisteredActivity.backgroundColor=[UIColor clearColor];
                _bt_VisitedSite.backgroundColor=[DragonCommentMethod color:95 green:158 blue:160 alpha:1];
                _tbv_VisitedSite.hidden=NO;
                _tbv_RegisteredActivity.hidden=YES;
                
                if (!_tbv_VisitedSite.superview) {//未加载过场馆数据
                    {//我浏览的场馆列表 HTTP请求
                        [self.view setUserInteractionEnabled:NO];
                        DragonRequest *request = [BoyaHttpMethod myPlaceListByLast:@"" size:k_PageSize isAlert:YES receive:self];
                        [request setTag:1];
                        
                        if (!request) {//无网路
                            [self.view setUserInteractionEnabled:YES];
                            [self createNoDataBackView:0];
                        }
                    }
                }else{
                    _v_noDataBackView.hidden=YES;
                }
            }
                break;
            case -2://我报名的活动
            {
                _bt_VisitedSite.backgroundColor=[UIColor clearColor];
                _bt_RegisteredActivity.backgroundColor=[DragonCommentMethod color:95 green:158 blue:160 alpha:1];
                _tbv_VisitedSite.hidden=YES;
                
                if (!_tbv_RegisteredActivity) {
                    _tbv_RegisteredActivity = [[DragonUITableView alloc] initWithFrame:_tbv_VisitedSite.frame isNeedUpdate:YES];
                    _tbv_RegisteredActivity._cellH=130;
//                    [self.view addSubview:_tbv_RegisteredActivity];
                    _tbv_RegisteredActivity.backgroundColor=/*[UIColor colorWithRed:248 green:248 blue:255 alpha:1]*/ [UIColor whiteColor] ;//248 248 255
                    _tbv_RegisteredActivity.tag=-2;
                    _tbv_RegisteredActivity.separatorStyle=UITableViewCellSeparatorStyleNone;
//                    [_tbv_RegisteredActivity release];
                    
                    {//我报名的活动列表 HTTP请求
                        [self.view setUserInteractionEnabled:NO];
                        DragonRequest *request = [BoyaHttpMethod myActiveListBylast:@"" size:k_PageSize isAlert:YES receive:self];
                        [request setTag:4];
                        
                        if (!request) {//无网路
                            [self.view setUserInteractionEnabled:YES];
                            [self createNoDataBackView:0];
                        }
                    }
                }else{
                    if (!_tbv_RegisteredActivity.superview) {
                        {//我报名的活动列表 HTTP请求
                            [self.view setUserInteractionEnabled:NO];
                            DragonRequest *request = [BoyaHttpMethod myActiveListBylast:@"" size:k_PageSize isAlert:YES receive:self];
                            [request setTag:4];
                            
                            if (!request) {//无网路
                                [self.view setUserInteractionEnabled:YES];
                                [self createNoDataBackView:0];
                            }
                        }
                    }else{
                        _tbv_RegisteredActivity.hidden=NO;
                        _v_noDataBackView.hidden=YES;
                    }
                }
            }
                break;
            case -3://无数据|无网络提示按钮
            {
                if (!_tbv_VisitedSite.hidden) {//我浏览的场馆列表 HTTP请求
                    [self.view setUserInteractionEnabled:NO];
                    DragonRequest *request = [BoyaHttpMethod myPlaceListByLast:@"" size:k_PageSize isAlert:YES receive:self];
                    [request setTag:1];
                    
                    if (!request) {//无网路
                        [self.view setUserInteractionEnabled:YES];
                        [self createNoDataBackView:0];
                    }
                }else{//我报名的活动列表 HTTP请求
                    [self.view setUserInteractionEnabled:NO];
                    DragonRequest *request = [BoyaHttpMethod myActiveListBylast:@"" size:k_PageSize isAlert:YES receive:self];
                    [request setTag:4];
                    
                    if (!request) {//无网路
                        [self.view setUserInteractionEnabled:YES];
                        [self createNoDataBackView:0];
                    }
                }
            }
            default:
                break;
        }
    }else if ([signal is:[DragonUIButton TOUCH_DOWN]]){
        DragonUIButton *bt=(DragonUIButton *)signal.source;
        switch (bt.tag) {
            case -1://我浏览的场馆
            {
                bt.backgroundColor=[DragonCommentMethod color:95 green:158 blue:160 alpha:1];//95 158 160 
                _bt_RegisteredActivity.backgroundColor=[UIColor clearColor];

            }
                break;
            case -2://我报名的活动
            {
                bt.backgroundColor=[DragonCommentMethod color:95 green:158 blue:160 alpha:1];
                _bt_VisitedSite.backgroundColor=[UIColor clearColor];
                
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark- HTTP
- (void)handleRequest:(DragonRequest *)request receiveObj:(id)receiveObj
{
    
    if ([request succeed])
    {
        switch (request.tag) {
            case 1://获取我浏览的场馆列表
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"placeList"];
                    if (list.count>0) {
                        [_muA_siteListData removeAllObjects];
                    }
                    
                    for (NSDictionary *d in list) {
                        BoyaSiteModel *Model = [BoyaSiteModel JSONReflection:d];
                        if (!_muA_siteListData) {
                            _muA_siteListData=[NSMutableArray arrayWithObject:Model];
                            [_muA_siteListData retain];
                        }else{
                            [_muA_siteListData addObject:Model];
                        }
                    }
                    
                    if (_muA_siteListData.count>0) {
                        if (!_tbv_VisitedSite.superview) {
                            [self.view addSubview:_tbv_VisitedSite];
                            [_tbv_VisitedSite release];
                            _tbv_VisitedSite.hidden=NO;
                        }else{
                            _tbv_VisitedSite.hidden=NO;
                        }
                        
                        _v_noDataBackView.hidden=YES;
                    }else{
                        [self createNoDataBackView:1];
                    }
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                    
                    [self createNoDataBackView:1];

                }
                
                [self.view setUserInteractionEnabled:YES];
                
                
            }
                break;
                
            case 2://加载更多场馆列表
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"placeList"];
                    for (NSDictionary *d in list) {
                        BoyaSiteModel *Model = [BoyaSiteModel JSONReflection:d];
                        {
                            [_muA_siteListData addObject:Model];
                        }
                        
                    }
                    
                    if (list.count>0) {
                        [_tbv_VisitedSite reloadData:NO];
                        
                    }else{
                        [_tbv_VisitedSite.footerView changeState:PULLSTATEEND];
                    }
                    
                    [self.view setUserInteractionEnabled:YES];
                    return;
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [self.view setUserInteractionEnabled:YES];
                [_tbv_VisitedSite.footerView changeState:PULLSTATEEND];
                
                
            }
                break;
            case 3://刷新我浏览的场馆
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    
                    NSArray *list=[response.data objectForKey:@"placeList"];
                    if (list.count>0) {
                        [_muA_siteListData removeAllObjects];
                        [_tbv_VisitedSite._muA_differHeightCellView removeAllObjects];
                        
                    }
                    
                    for (NSDictionary *d in list) {
                        BoyaSiteModel *Model = [BoyaSiteModel JSONReflection:d];
                        {
                            [_muA_siteListData addObject:Model];
                        }
                    }
                    
                    if (list.count>0) {
                        [_tbv_VisitedSite reloadData:NO];
                        if (_muA_siteListData.count>0) {
                            [_tbv_VisitedSite scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                        }
                    }{//
                        [_tbv_VisitedSite.headerView changeState:VIEWTYPEHEADER];
                    }
                    
                    [self.view setUserInteractionEnabled:YES];
                    return;
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [_tbv_VisitedSite.headerView changeState:VIEWTYPEHEADER];
                [self.view setUserInteractionEnabled:YES];
                
            }
                break;
                
            case 4://我报名的活动列表 
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"activeList"];
                    for (NSDictionary *d in list) {
                        BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
                        Model.isMyActive=1;
                        if (!_muA_ActivityListData) {
                            _muA_ActivityListData=[NSMutableArray arrayWithObject:Model];
                            [_muA_ActivityListData retain];
                        }else{
                            [_muA_ActivityListData addObject:Model];
                        }
                    }
                    
                    if (_muA_ActivityListData.count>0) {
                        if (!_tbv_RegisteredActivity.superview) {
                            [self.view addSubview:_tbv_RegisteredActivity];
                            [_tbv_RegisteredActivity release];
                            _tbv_RegisteredActivity.hidden=NO;
                        }else{
                            _tbv_RegisteredActivity.hidden=NO;
                        }
                        
                        _v_noDataBackView.hidden=YES;
                    }else{
                        [self createNoDataBackView:1];

                    }
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                    [self createNoDataBackView:1];

                }
                
                [self.view setUserInteractionEnabled:YES];
                
            }
                break;
            case 5://刷新我参与的活动
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    
                    NSArray *list=[response.data objectForKey:@"activeList"];
                    if (list.count>0) {
                        [_muA_ActivityListData removeAllObjects];
                        [_tbv_RegisteredActivity._muA_differHeightCellView removeAllObjects];
                        
                    }
                    
                    for (NSDictionary *d in list) {
                        BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
                        Model.isMyActive=1;

                        {
                            [_muA_ActivityListData addObject:Model];
                        }
                    }
                    
                    if (list.count>0) {
                        [_tbv_RegisteredActivity reloadData:NO];
                        if (_muA_ActivityListData.count>0) {
                            [_tbv_RegisteredActivity scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                        }
                    }{//隐藏搜索
                        [_tbv_RegisteredActivity.headerView changeState:VIEWTYPEHEADER];
                    }
                    
                    [self.view setUserInteractionEnabled:YES];
                    return;
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [_tbv_RegisteredActivity.headerView changeState:VIEWTYPEHEADER];
                [self.view setUserInteractionEnabled:YES];
                
            }
                break;
            case 6://加载更多我参与的活动列表
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"activeList"];
                    for (NSDictionary *d in list) {
                        BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
                        Model.isMyActive=1;

                        {
                            [_muA_ActivityListData addObject:Model];
                        }
                        
                    }
                    
                    if (list.count>0) {
                        [_tbv_RegisteredActivity reloadData:NO];
                        
                    }else{
                        [_tbv_RegisteredActivity.footerView changeState:PULLSTATEEND];
                    }
                    
                    [self.view setUserInteractionEnabled:YES];
                    return;
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [self.view setUserInteractionEnabled:YES];
                [_tbv_RegisteredActivity.footerView changeState:PULLSTATEEND];
                
                
            }
                break;

            default:
                break;
        }
        
    }else if ([request failed])//网络失败
    {
        BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
        {
            BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
            [notice setNoticeText:[response message]];
        }
        [self.view setUserInteractionEnabled:YES];
        
        switch (request.tag) {
            case 1://我浏览的场馆
            case 4://我参与的活动
            {
                [self createNoDataBackView:0];
            }
                break;
                
            case 3://
            {
                [_tbv_VisitedSite.headerView changeState:VIEWTYPEHEADER];
            }
                break;
            case 5://
            {
                [_tbv_RegisteredActivity.headerView changeState:VIEWTYPEHEADER];
            }
            default:
                break;
        }
    }
    
}


@end
