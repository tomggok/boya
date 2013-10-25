//
//  BoyaSettingViewController.m
//  BoYa
//
//  Created by cham on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaSettingViewController.h"
#import "UIImageView+Init.h"
#import "BoyaMainViewController.h"
#import "UITableView+property.h"
#import "KeyNotes.h"
#import "BoyaParameter.h"
#import "BoyaCellForSite.h"
#import "Dragon_CommentMethod.h"
#import "BoyaSiteDetailViewController.h"
#import "UIView+DragonCategory.h"
#import "BoyaRequest.h"
#import "BoyaUinfoModel.h"
#import "BoyaHttpMethod.h"
#import "BoyaUpgradeModel.h"
#import "BoyaUpgardeInfoModel.h"

@interface BoyaSettingViewController ()

@end

@implementation BoyaSettingViewController

#pragma mark- ViewController信号
- (void)handleViewSignal_DragonViewController:(DragonViewSignal *)signal
{
    [super handleViewSignal:signal];

    if ([signal is:DragonViewController.CREATE_VIEWS]) {
        BoyaMainViewController *mainCon=((BoyaMainViewController *)([self.drNavigationController getViewController:[BoyaMainViewController class]]));
        _tbv = [[DragonUITableView alloc] initWithFrame:CGRectMake(10, kH_UINavigationController+Boya_H_TOPTAB/2, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds)-kH_StateBar-(mainCon)._tabbar.frame.size.height-kH_UITabBarController-Boya_H_TOPTAB/2) isNeedUpdate:NO];
        _tbv._cellH=kH_cellDefault;
        _tbv.scrollEnabled=YES;
        [self.view addSubview:_tbv];
        _tbv.backgroundColor=/*[UIColor colorWithRed:248 green:248 blue:255 alpha:1]*/ [UIColor whiteColor];//248 248 255
        _tbv.tag=-1;
        _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
        RELEASE(_tbv);
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){

    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
        {
        [_barView setLeftLabelText:@"设置"];
        }

        //    DLogInfo(@"signal name === %@", signal.name);
    
}

#pragma mark- 只接受tbv信号

- (void)handleViewSignal_DragonUITableView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUITableView TABLENUMROWINSEC]])//numberOfRowsInSection
    {
        NSNumber *s = [NSNumber numberWithInteger:3];
        [signal setReturnValue:s];
        
    }else if ([signal is:[DragonUITableView TABLENUMOFSEC]])//numberOfSectionsInTableView
    {
        NSNumber *s = [NSNumber numberWithInteger:1];
        [signal setReturnValue:s];
        
    }
    else if ([signal is:[DragonUITableView TABLEHEIGHTFORROW]])//heightForRowAtIndexPath
    {
        //        NSDictionary *dict = (NSDictionary *)[signal object];
        //        UITableView *tableView = [dict objectForKey:@"tableView"];
        //        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
        
        
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
        
        static NSString *reuseIdentifier = @"reuseIdentifier";
        
        UITableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:reuseIdentifier];
        
        if (!cell) {
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
        }
        
        [cell.textLabel setFont:[UIFont systemFontOfSize:15]];
        cell.textLabel.highlightedTextColor = [DragonCommentMethod color:51 green:51 blue:51 alpha:1];
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        cell.selectedBackgroundView.backgroundColor = kH_CellSelColor;
        
        switch (indexPath.row) {
            case 0://昵称
            {
                
                
                BoyaUinfoModel *byModel = [BoyaUinfoModel JSONReflection:SHARED.uinfo];
                NSString *strSex = [NSString stringWithFormat:@"%@", byModel.sex];
                NSString *strUname = [NSString stringWithFormat:@"%@", byModel.uname];
                cell.textLabel.text=strUname;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                int nlength = [cell.textLabel.text sizeWithFont:[cell.textLabel font]].width+17;
                
                UIImage *imgSex = nil;
                
                if ([strSex isEqualToString:@"1"]) {
                    imgSex = [UIImage imageNamed:@"icon_male.png"];
                }
                else if ([strSex isEqualToString:@"0"]) {
                    imgSex = [UIImage imageNamed:@"icon_female.png"];
                }
                
                DragonUIImageView *viewSex = [[DragonUIImageView alloc] initWithFrame:CGRectMake(nlength, 15, 11, 14)];
                [viewSex setImage:imgSex];
                [cell addSubview:viewSex];
                [viewSex release];        
            }
                break;
            case 1://
            {
                cell.textLabel.text=@"版本检测";
                NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
                
                DragonUILabel *lbVersion = [[DragonUILabel alloc] initWithFrame:CGRectMake(200, 12, 80, 20)];
                [lbVersion setTextAlignment:UITextAlignmentRight];
                [lbVersion setText:[NSString stringWithFormat:@"v%@", version]];
                [lbVersion setFont:[UIFont systemFontOfSize:12]];
                [lbVersion setTextColor:[DragonCommentMethod color:49 green:148 blue:151 alpha:1.f]];
                [cell addSubview:lbVersion];
                [lbVersion release];
            }
                break;
            case 2://
            {
                cell.textLabel.text=@"注销退出";
            }
                break;
            default:
                break;
        }

        
        if (![cell viewWithTag:-1]) {//
            UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
            DragonUIImageView *_imgV_separatorLine=[[DragonUIImageView alloc]initWithFrame:CGRectMake(0, tableview._cellH-img.size.height/2, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:cell Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_separatorLine release];
            _imgV_separatorLine.tag=-1;
        }
        
        [signal setReturnValue:cell];
        
    }else if ([signal is:[DragonUITableView TABLEDIDSELECT]])//选中cell
    {
        NSDictionary *dict = (NSDictionary *)[signal object];
        NSIndexPath *indexPath = [dict objectForKey:@"indexPath"];
        UITableView *tableview = [dict objectForKey:@"tableView"];

        switch (indexPath.row){
            case 1:
            {
                DragonRequest *request = [BoyaHttpMethod upgrade:@"ios" version:[[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey] isAlert:YES receive:self];
                [request setTag:1];
            }
                break;
            case 2:
            {
                BoyaRequest *request = [[[BoyaRequest alloc] init] autorelease];
                [request handleLogout];
            }
                break;
        }

        [tableview deselectRowAtIndexPath:indexPath animated:YES];

    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDENDDRAGGING]])//滚动停止
    {
        
    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDSCROLL]])
    {
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
            
            if ([[response code] isEqualToString:@"1"]){
                BoyaUpgradeModel *upgradeModel = [BoyaUpgradeModel JSONReflection:response.data];
                BoyaUpgardeInfoModel *uinfoModel = [BoyaUpgardeInfoModel JSONReflection:upgradeModel.info];
                
                NSString *strNew  = [NSString stringWithFormat:@"%@", upgradeModel.new];
                
                if ([strNew isEqualToString:@"1"]) {
                    NSURL *url = [NSURL URLWithString:uinfoModel.downUrl];
                    [[UIApplication sharedApplication] openURL:url];
                }
                else{
                    BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                    [notice setNoticeText:@"当前已是最新版本"];
                }

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
