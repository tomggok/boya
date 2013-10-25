//
//  BoyaActivityViewController.m
//  BoYa
//
//  Created by zhangchao on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaActivityViewController.h"
#import "UIImageView+Init.h"
#import "BoyaMainViewController.h"
#import "UITableView+property.h"
#import "KeyNotes.h"
#import "BoyaParameter.h"
#import "BoyaCellForActivity.h"
#import "Dragon_CommentMethod.h"
#import "BoyaActivityDetailViewController.h"
#import "UIView+DragonCategory.h"
#import "BoyaHttpMethod.h"
#import "Dragon_Request.h"
#import "BoyaNoticeView.h"
#import "BoyaActivityModel.h"
#import "BoyaAreaModel.h"
#import "BoyaTypeModel.h"
#import "BoyaTimeModel.h"
#import "NSObject+DragonDatabase.h"
#import "NSString+SBJSON.h"
#import "JSON.h"
#import "ShowDetailsViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "UITableView+property.h"
#import "AppDelegate.h"

@interface BoyaActivityViewController ()

@end

@implementation BoyaActivityViewController

@synthesize _tbv;

#pragma mark- 生成无数据或无网络时提示按钮的背景和提示按钮
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
        
//        {
//            UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
//            UIImageView *imgV=[[UIImageView alloc] initWithFrame:CGRectMake(5, kH_UINavigationController, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self.view Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
//            [imgV release];
//        }
        
        {
            BoyaMainViewController *mainCon=((BoyaMainViewController *)([self.drNavigationController getViewController:[BoyaMainViewController class]]));
            _tbv = [[DragonUITableView alloc] initWithFrame:CGRectMake(10, kH_UINavigationController+Boya_H_TOPTAB, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds)-kH_StateBar-(mainCon)._tabbar.frame.size.height-kH_UITabBarController-Boya_H_TOPTAB) isNeedUpdate:YES];
            _tbv._cellH=130;
//            [self.view addSubview:_tbv];
            _tbv.backgroundColor=/*[UIColor colorWithRed:248 green:248 blue:255 alpha:1]*/ [UIColor whiteColor];//248 248 255
            _tbv.tag=-1;
            _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
//            [_tbv release];
        }

        {
            _menu_allType= [[BoyaSINavigationMenuView alloc] initWithFrame:CGRectMake(5, kH_UINavigationController, 90, 35) title:@"全部类别"];//点击按钮
            [_menu_allType displayMenuInView:self.view];
            _menu_allType.items = [NSMutableArray arrayWithObjects:k_noData, nil];
            _menu_allType.menuButton.title.shadowColor=Nil;
            [_menu_allType.menuButton initArrowImage:[UIImage imageNamed:@"arrow_select"]];
            _menu_allType.menuButton.title.font=[UIFont systemFontOfSize:15];
            [self.view addSubview:_menu_allType];
            _menu_allType.tag=-1;
            RELEASE(_menu_allType);
        }
        {
            _menu_allArea= [[BoyaSINavigationMenuView alloc] initWithFrame:CGRectMake(_menu_allType.frame.origin.x+_menu_allType.frame.size.width+10, _menu_allType.frame.origin.y, _menu_allType.frame.size.width, _menu_allType.frame.size.height) title:@"全部区县"];//点击按钮
            [_menu_allArea displayMenuInView:self.view];
            _menu_allArea.items = [NSMutableArray arrayWithObjects:k_noData, nil];
            _menu_allArea.menuButton.title.shadowColor=Nil;
            [_menu_allArea.menuButton initArrowImage:[UIImage imageNamed:@"arrow_select"]];
            _menu_allArea.menuButton.title.font=[UIFont systemFontOfSize:15];
            [self.view addSubview:_menu_allArea];
            _menu_allArea.tag=-2;
            RELEASE(_menu_allArea);
        }
        
        {
            _menu_startTime= [[BoyaSINavigationMenuView alloc] initWithFrame:CGRectMake(_menu_allArea.frame.origin.x+_menu_allArea.frame.size.width+10, _menu_allArea.frame.origin.y, _menu_allArea.frame.size.width, _menu_allArea.frame.size.height) title:@"全部时间"];//点击按钮
            [_menu_startTime displayMenuInView:self.view];
            _menu_startTime.items = [NSMutableArray arrayWithObjects:k_noData, nil];
            _menu_startTime.menuButton.title.shadowColor=Nil;
            _menu_startTime.menuButton.title.font=[UIFont systemFontOfSize:15];
            [_menu_startTime.menuButton initArrowImage:[UIImage imageNamed:@"arrow_select"]];
            [self.view addSubview:_menu_startTime];
            _menu_startTime.tag=-3;
            RELEASE(_menu_startTime);
        }
        
        _str_typeID=@"";
        _str_areaID=@"";
        _str_timeID=@"";
        
        {
            UIView *v=[[UIView alloc]initWithFrame:_tbv.frame];
            v.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:v];
            [v release];
        }
        
        [self loadDefaultListData];
        
    }else if ([signal is:DragonViewController.WILL_APPEAR]){
        if (_tbv._b_isNeedResizeCell) {//是否需要刷新数据源
            {//HTTP请求
                [self.view setUserInteractionEnabled:NO];
                DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:@"" size:k_PageSize isAlert:YES receive:self];
                [request setTag:3];
            }
            
            _tbv._b_isNeedResizeCell=NO;
        }
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){
//        self.view.userInteractionEnabled=YES;

    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
        [_barView setLeftLabelText:@"活动"];
//        self.view.backgroundColor=[DragonCommentMethod color:152 green:245 blue:255 alpha:1];//152 245 255
//        _barView.backgroundColor=self.view.backgroundColor;

    }
    
    //    DLogInfo(@"signal name === %@", signal.name);
    
}

#pragma mark- 请求默认列表数据
-(void)loadDefaultListData
{
    if ([_str_typeID isEqualToString:@""] && [_str_areaID isEqualToString:@""] && [_str_timeID isEqualToString:@""]) {//如果请求的是默认列表
        {
            NSMutableString *tableName=[NSMutableString stringWithString:((AppDelegate *)([[UIApplication sharedApplication] delegate])).userName];
            [tableName appendString:@"_"];
            [tableName appendString:INTERFACEActive_ActiveList];
            
            self.DB.
            FROM(tableName).
            GET();
            
            if (self.DB.resultCount > 0)//读缓存
            {
                [_muA_ActivityListData removeAllObjects];
                RELEASEOBJ(_muA_ActivityListData);
                
                _muA_ActivityListData=[[NSMutableArray alloc]initWithCapacity:10];
                NSDictionary *data=[[[self.DB.resultArray objectAtIndex:0] objectForKey:DATABASELOGINRESPONSE] JSONValue];
                {
                    NSArray *list=[data objectForKey:@"activeList"];
                    for (NSDictionary *d in list) {
                        BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
                        if (!_muA_ActivityListData) {
                            _muA_ActivityListData=[NSMutableArray arrayWithObject:Model];
                            [_muA_ActivityListData retain];
                        }else{
                            [_muA_ActivityListData addObject:Model];
                        }
                        
                    }
                    
                    if (_muA_ActivityListData.count>0) {
                        if (!_tbv.superview) {
                            [self.view addSubview:_tbv];
                            [_tbv release];
                            
                            [_tbv.headerView updateTimeLabel];
                            [_tbv.footerView updateTimeLabel];
                        }else{
                            [_tbv reloadData:NO];
                            if (_muA_ActivityListData.count>0) {
                                [_tbv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                            }
                        }
                        _v_noDataBackView.hidden=YES;

                    }
                    
                }
                
                {//取所有类别和地区,时间   HTTP请求
                    [self.view setUserInteractionEnabled:NO];
                    DragonRequest *request = [BoyaHttpMethod activityType_Area_timeByType:_str_typeID area:_str_areaID time:_str_timeID isAlert:YES receive:self];
                    [request setTag:4];
                }
                
            }else{//HTTP请求
                [self.view setUserInteractionEnabled:NO];
                DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:@"" size:k_PageSize isAlert:YES receive:self];
                [request setTag:1];
                
                if (!request) {//无网路
                    [self.view setUserInteractionEnabled:YES];
                    [self createNoDataBackView:0];
                }
            }
            
        }
    }else{//HTTP请求
        [self.view setUserInteractionEnabled:NO];
        DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:@"" size:k_PageSize isAlert:YES receive:self];
        [request setTag:1];
        
        if (!request) {//无网路
            [self.view setUserInteractionEnabled:YES];
            [self createNoDataBackView:0];
        }
    }
}


#pragma mark- 只接受tbv信号
static NSString *reuseIdentifier = @"reuseIdentifier";

- (void)handleViewSignal_DragonUITableView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUITableView TABLENUMROWINSEC]])//numberOfRowsInSection
    {
        NSNumber *s = [NSNumber numberWithInteger:_muA_ActivityListData.count];
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
//        [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
        
        if(indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0)
        {
            BoyaCellForActivity *cell = [[[BoyaCellForActivity alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
            [cell setContent:[_muA_ActivityListData objectAtIndex:indexPath.row] indexPath:indexPath tbv:tableView];
            
            if (!tableView._muA_differHeightCellView) {
                tableView._muA_differHeightCellView=[NSMutableArray arrayWithCapacity:10];
            }
            if (![tableView._muA_differHeightCellView containsObject:cell]) {
                [tableView._muA_differHeightCellView addObject:cell];
            }
            
            //            NSNumber *s = [NSNumber numberWithInteger:cell.frame.size.height];
//            [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
            [signal setReturnValue:[NSNumber numberWithInteger:cell.frame.size.height]];

        }else{//之前计算过的cell
            //            NSNumber *s = [NSNumber numberWithInteger:((BoyaCellForSite *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row-1]).frame.size.height];
//            [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
            [signal setReturnValue:[NSNumber numberWithInteger:((BoyaCellForActivity *)[tableView._muA_differHeightCellView objectAtIndex:indexPath.row]).frame.size.height]];

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
        
        BoyaActivityDetailViewController *con=[[BoyaActivityDetailViewController alloc]init];
        con._model=[_muA_ActivityListData objectAtIndex:indexPath.row];
        
        BoyaMainViewController *mainCon=(BoyaMainViewController *)[[self.view superview] viewController];
        [mainCon.drNavigationController pushViewController:con animated:YES];
        [con release];
        
        [tableview deselectRowAtIndexPath:indexPath animated:YES];
        
    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDENDDRAGGING]])//滚动停止
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        DragonUITableView *tableview = [dict objectForKey:@"scrollView"];
        //        BOOL decelerate = [[dict objectForKey:@"decelerate"] boolValue];
        
        {
            switch ([tableview tableViewDidEndDragging]) {
                case RETURNREFRESH://下拉刷新
                {//HTTP请求
                    [self.view setUserInteractionEnabled:NO];
                    DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:@"" size:k_PageSize isAlert:YES receive:self];
                    [request setTag:3];
                    
                    if (!request) {//无网路
                        [_tbv.headerView changeState:VIEWTYPEHEADER];
                        [self.view setUserInteractionEnabled:YES];
                    }
                }
                    break;
                case RETURNLOADMORE://加载更多                    
                {//HTTP请求
                    
                    if([_str_areaID isEqualToString:@""] && [_str_typeID isEqualToString:@""] && [_str_timeID isEqualToString:@""]){//加载 默认列表的更多
                        self.DB.
                        FROM(INTERFACEActive_ActiveList).
                        GET();
                        
                        if (self.DB.resultCount > 0)//读缓存
                        {
                            NSString *str_lastID=[[self.DB.resultArray objectAtIndex:self.DB.resultCount-1] objectForKey:DATABASEMAILLASTID];
                            if (/*![str_lastID isEqualToString:((BoyaSiteModel *)_muA_siteListData.lastObject).orderid]*/ [str_lastID intValue]!=[(((BoyaActivityModel *)_muA_ActivityListData.lastObject).orderid) intValue]) {//有缓存
                                NSDictionary *data=[[[self.DB.resultArray objectAtIndex:(_muA_ActivityListData.count/k_PageSize.intValue)] objectForKey:DATABASELOGINRESPONSE] JSONValue];
                                
                                NSArray *list=[data objectForKey:@"activeList"];
                                
                                for (NSDictionary *d in list) {
                                    BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
                                    {
                                        [_muA_ActivityListData addObject:Model];
                                    }
                                    
                                }
                                
                                if (list.count>0) {
                                    [_tbv reloadData:NO];
                                    
                                }else{
                                    [_tbv.footerView changeState:PULLSTATEEND];
                                }
                                
                            }else{//HTTP请求
                                if (_muA_ActivityListData.count>0) {
                                    [self.view setUserInteractionEnabled:NO];
                                    BoyaActivityModel *model=[_muA_ActivityListData objectAtIndex:_muA_ActivityListData.count-1];
                                    DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:model.orderid size:k_PageSize isAlert:YES receive:self];
                                    [request setTag:2];
                                    
                                    if (!request) {//无网路
                                        [_tbv.footerView changeState:VIEWTYPEFOOTER];
                                        [self.view setUserInteractionEnabled:YES];
                                    }
                                }
                                
                            }
                            
                        }else{//HTTP请求
                            if (_muA_ActivityListData.count>0) {
                                [self.view setUserInteractionEnabled:NO];
                                BoyaActivityModel *model=[_muA_ActivityListData objectAtIndex:_muA_ActivityListData.count-1];
                                DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:model.orderid size:k_PageSize isAlert:YES receive:self];
                                [request setTag:2];
                                
                                if (!request) {//无网路
                                    [_tbv.footerView changeState:VIEWTYPEFOOTER];
                                    [self.view setUserInteractionEnabled:YES];
                                }
                            }
                            
                        }
                        
                    }else{//HTTP请求 非默认列表的更多
                        if (_muA_ActivityListData.count>0) {
                            [self.view setUserInteractionEnabled:NO];
                            BoyaActivityModel *model=[_muA_ActivityListData objectAtIndex:_muA_ActivityListData.count-1];
                            DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:model.orderid size:k_PageSize isAlert:YES receive:self];
                            [request setTag:2];
                            
                            if (!request) {//无网路
                                [_tbv.footerView changeState:VIEWTYPEFOOTER];
                                [self.view setUserInteractionEnabled:YES];
                            }
                        }
                        
                    }
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

#pragma mark- 只接受Bt信号
- (void)handleViewSignal_DragonUIButton:(DragonViewSignal *)signal{
    if ([signal is:[DragonUIButton TOUCH_UP_INSIDE]]) {
        DragonUIButton *bt=(DragonUIButton *)signal.source;
        switch (bt.tag) {
            case -3://无数据|无网络提示按钮
            {//HTTP请求
                [self.view setUserInteractionEnabled:NO];
                DragonRequest *request = [BoyaHttpMethod ActivityListByType:_str_typeID area:_str_areaID time:_str_timeID last:@"" size:k_PageSize isAlert:YES receive:self];
                [request setTag:1];
                
                if (!request) {//无网路
                    [self.view setUserInteractionEnabled:YES];
                    [self createNoDataBackView:0];
                }
            }
            default:
                break;
        }
    }else if ([signal is:[DragonUIButton TOUCH_DOWN]]){
        
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

#pragma mark- 只接受BoyaSINavigationMenuView弹出的下拉列表相关消息
- (void)handleViewSignal_BoyaSINavigationMenuView:(DragonViewSignal *)signal
{
    BoyaSINavigationMenuView *menu=signal.source;
    
    if ([signal is:[BoyaSINavigationMenuView SHOW]]) {
        switch (menu.tag) {
            case -1://全部类型
            {
                [_menu_allArea onHideMenu];
                [_menu_startTime onHideMenu];

                [_menu_allType onShowMenu];
            }
                break;
            case -2://全部区县
            {
                [_menu_allType onHideMenu];
                [_menu_startTime onHideMenu];

                [ _menu_allArea onShowMenu];
            }
                break;
            case -3://开始时间
            {
                [_menu_allType onHideMenu];
                [_menu_allArea onHideMenu];

                [ _menu_startTime onShowMenu];
            }
                break;
            default:
                break;
        }
    }else if ([signal is:[BoyaSINavigationMenuView HIDE]]){
        [menu onHideMenu];
    }else if ([signal is:[BoyaSINavigationMenuView SELECT]]){//选中cell
        switch (menu.tag) {
            case -1://全部类型
            {
                if (_muA_typeList.count==0) {
                    {//取所有类别和地区,时间   HTTP请求
                        DragonRequest *request = [BoyaHttpMethod activityType_Area_timeByType:_str_typeID area:_str_areaID time:_str_timeID isAlert:YES receive:self];
                        [request setTag:4];
                    }
                    break;
                }
                NSInteger n = [((NSNumber *)[signal object]) intValue];
                menu.menuButton.title.text=((BoyaTypeModel *)([_muA_typeList objectAtIndex:n])).typename;
                _str_typeID=((BoyaTypeModel *)([_muA_typeList objectAtIndex:n])).typeid;
                [_str_typeID retain];
                
                {//刷新活动列表
                    [_muA_ActivityListData removeAllObjects];
                    [_tbv._muA_differHeightCellView removeAllObjects];
                    
                    [self loadDefaultListData];

                }
            }
                break;
            case -2://全部区县
            {
                if (_muA_areaList.count==0) {
                    {//取所有类别和地区,时间   HTTP请求
                        DragonRequest *request = [BoyaHttpMethod activityType_Area_timeByType:_str_typeID area:_str_areaID time:_str_timeID isAlert:YES receive:self];
                        [request setTag:4];
                    }
                    break;
                }
                NSInteger n = [((NSNumber *)[signal object]) intValue];
                menu.menuButton.title.text=((BoyaAreaModel *)([_muA_areaList objectAtIndex:n])).areaname;
                _str_areaID=((BoyaAreaModel *)([_muA_areaList objectAtIndex:n])).areaid;
                [_str_areaID retain];
                
                {//刷新活动列表
                    [_muA_ActivityListData removeAllObjects];
                    [_tbv._muA_differHeightCellView removeAllObjects];
                    
                    [self loadDefaultListData];

                }
            }
                break;
                
            case -3://全部时间
            {
                if (_muA_timeList.count==0) {
                    {//取所有类别和地区,时间   HTTP请求
                        DragonRequest *request = [BoyaHttpMethod activityType_Area_timeByType:_str_typeID area:_str_areaID time:_str_timeID isAlert:YES receive:self];
                        [request setTag:4];
                    }
                    break;
                }
                
                NSInteger n = [((NSNumber *)[signal object]) intValue];
                menu.menuButton.title.text=((BoyaTimeModel *)([_muA_timeList objectAtIndex:n])).timename;
                _str_timeID=((BoyaTimeModel *)([_muA_timeList objectAtIndex:n])).timeid;
                [_str_timeID retain];
                
                {//刷新活动列表
                    [_muA_ActivityListData removeAllObjects];
                    [_tbv._muA_differHeightCellView removeAllObjects];
                    
                    [self loadDefaultListData];
                }
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
            case 1://获取活动列表
            {                
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"activeList"];
                    for (NSDictionary *d in list) {
                        BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
//                        Model.isMyActive=2;
                        if (!_muA_ActivityListData) {
                            _muA_ActivityListData=[NSMutableArray arrayWithObject:Model];
                            [_muA_ActivityListData retain];
                        }else{
                            [_muA_ActivityListData addObject:Model];
                        }
                        
                    }
                    
                    if (_muA_ActivityListData.count>0) {
                        if (!_tbv.superview) {
                            [self.view addSubview:_tbv];
                            [_tbv release];
                            _tbv.hidden=NO;

                            [_tbv.headerView updateTimeLabel];
                            [_tbv.footerView updateTimeLabel];
                        }else{
                            [_tbv reloadData:NO];
                            if (_muA_ActivityListData.count>0) {
                                [_tbv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                            }
                        }
                        
                    }else{//没数据
                        [_tbv reloadData:YES];
                    }
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [self.view setUserInteractionEnabled:YES];
                
                {//取所有类别和地区,时间   HTTP请求
                    [self.view setUserInteractionEnabled:NO];
                    DragonRequest *request = [BoyaHttpMethod activityType_Area_timeByType:_str_typeID area:_str_areaID time:_str_timeID isAlert:YES receive:self];
                    [request setTag:4];
                }
            }
                break;
                
            case 2://加载更多场馆列表
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    NSArray *list=[response.data objectForKey:@"activeList"];
                    for (NSDictionary *d in list) {
                        BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
                        {
                            [_muA_ActivityListData addObject:Model];
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
            case 3://刷新场馆列表
            {
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    
                    NSArray *list=[response.data objectForKey:@"activeList"];
                    if (list.count>0) {
                        [_muA_ActivityListData removeAllObjects];
                        [_tbv._muA_differHeightCellView removeAllObjects];
                    }
                    
                    for (NSDictionary *d in list) {
                        BoyaActivityModel *Model = [BoyaActivityModel JSONReflection:d];
                        {
                            [_muA_ActivityListData addObject:Model];
                        }
                    }
                    
                    if (list.count>0) {
                        [_tbv reloadData:NO];
                        if (_muA_ActivityListData.count>0) {
                            [_tbv scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
                        }
                        
                        if( [[response.data objectForKey:@"area"] intValue]==0 && [[response.data objectForKey:@"type"] intValue]==-1 && [[response.data objectForKey:@"time"] intValue]==0){//刷新默认列表时,删除数据库表
                            
                            NSMutableString *tableName=[NSMutableString stringWithString:((AppDelegate *)([[UIApplication sharedApplication] delegate])).userName];
                            [tableName appendString:@"_"];
                            [tableName appendString:INTERFACEActive_ActiveList];

                            self.DB.
                            FROM(tableName).
                            DROP();
                        }
                        
                    }{//隐藏搜索
                        [_tbv.headerView changeState:VIEWTYPEHEADER];
                    }
                    
                    [self.view setUserInteractionEnabled:YES];
                    return;
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [_tbv.headerView changeState:VIEWTYPEHEADER];
                [self.view setUserInteractionEnabled:YES];
                
            }
                break;
                
            case 4:// 取活动类型、地区和日期关联
            {
                DLogInfo(@"request === %@", request.responseString);
                
                BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
                
                if ([[response code] isEqualToString:@"1"])
                {
                    {//获取区域数据
                        NSArray *areaList=[response.data objectForKey:@"areaList"];
//                        if (areaList.count>0)
                        {
                            
                            {
                                [_menu_allArea.items removeAllObjects];
                                _menu_allArea.items=Nil;
                                
                                if (!_menu_allArea.items) {
                                    _menu_allArea.items=[NSMutableArray arrayWithObject:@"全部区县"];
                                    //                            [_menu_allArea.items retain];
                                }
                            }
                            
                            {
                                [_muA_areaList removeAllObjects];
                                _muA_areaList=nil;
                                
                                BoyaAreaModel *Model_temp = [BoyaAreaModel JSONReflection:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"",@"",@"全部区县", nil] forKeys:[NSArray arrayWithObjects:@"count",@"areaid",@"areaname", nil]]];
                                if (!_muA_areaList) {
                                    _muA_areaList=[NSMutableArray arrayWithObject:Model_temp];
                                    [_muA_areaList retain];
                                }else{
                                    [_muA_areaList addObject:Model_temp];
                                }
                            }
                            
                        }
                        for (NSDictionary *d in areaList) {
                            BoyaAreaModel *Model = [BoyaAreaModel JSONReflection:d];
                            if (!_menu_allArea.items) {
                                _menu_allArea.items=[NSMutableArray arrayWithObject:@"全部区县"];
                                //                            [_menu_allArea.items retain];
                            }else{
                                [_menu_allArea.items addObject:Model.areaname];
                            }
                            
                            if (!_muA_areaList) {
                            }else{
                                [_muA_areaList addObject:Model];
                            }
                        }
                    }
                    
                    {//获取类别数据
                        NSArray *typeList=[response.data objectForKey:@"typeList"];
//                        if (typeList.count>0)
                        {
                            {
                                [_menu_allType.items removeAllObjects];
                                _menu_allType.items=Nil;
                                if (!_menu_allType.items) {
                                    _menu_allType.items=[NSMutableArray arrayWithObject:@"全部类别"];
                                }
                            }
                          
                            {
                                [_muA_typeList removeAllObjects];
                                _muA_typeList=Nil;
                                BoyaTypeModel *Model_temp = [BoyaTypeModel JSONReflection:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"",@"",@"全部类别", nil] forKeys:[NSArray arrayWithObjects:@"count",@"typeid",@"typename", nil]]];
                                if (!_muA_typeList) {
                                    _muA_typeList=[NSMutableArray arrayWithObject:Model_temp];
                                    [_muA_typeList retain];
                                }else{
                                    [_muA_typeList addObject:Model_temp];
                                }
                            }
                          
                        }
                        for (NSDictionary *d in typeList) {
                            BoyaTypeModel *Model = [BoyaTypeModel JSONReflection:d];
                            if (!_menu_allType.items) {
                                _menu_allType.items=[NSMutableArray arrayWithObject:@"全部类别"];
                            }else{
                                [_menu_allType.items addObject:Model.typename];
                            }
                            
                            if (!_muA_typeList) {
                                _muA_typeList=[NSMutableArray arrayWithObject:Model];
                                [_muA_typeList retain];
                            }else{
                                [_muA_typeList addObject:Model];
                            }
                        }
                    }
                    
                    {//获取时间数据
                        NSArray *timeList=[response.data objectForKey:@"timeList"];
//                        if (timeList.count>0)
                        {
                            {
                                [_menu_startTime.items removeAllObjects];
                                _menu_startTime.items=Nil;
                                if (!_menu_startTime.items) {
                                    _menu_startTime.items=[NSMutableArray arrayWithObject:@"全部时间"];
                                }
                            }
                           
                            {
                                [_muA_timeList removeAllObjects];
                                _muA_timeList=Nil;
                                BoyaTimeModel *Model_temp = [BoyaTimeModel JSONReflection:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"",@"",@"全部时间", nil] forKeys:[NSArray arrayWithObjects:@"count",@"timeid",@"timename", nil]]];
                                if (!_muA_timeList) {
                                    _muA_timeList=[NSMutableArray arrayWithObject:Model_temp];
                                    [_muA_timeList retain];
                                }else{
                                    [_muA_timeList addObject:Model_temp];
                                }
                            }
                        }
                        
                        for (NSDictionary *d in timeList) {
                            BoyaTimeModel *Model = [BoyaTimeModel JSONReflection:d];
                            if (!_menu_startTime.items) {
                                _menu_startTime.items=[NSMutableArray arrayWithObject:/*Model.timename*/ @"全部时间"];
                            }else{
                                [_menu_startTime.items addObject:Model.timename];
                            }
                            
                            if (!_muA_timeList) {
                                _muA_timeList=[NSMutableArray arrayWithObject:Model];
                                [_muA_timeList retain];
                            }else{
                                [_muA_timeList addObject:Model];
                            }
                        }
                    }
                    
                }else //处理操作失败
                {
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:[response message]];
                }
                
                [self.view setUserInteractionEnabled:YES];
                
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
    }
    
}
@end
