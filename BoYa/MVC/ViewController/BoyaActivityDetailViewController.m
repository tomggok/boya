//
//  BoyaActivityDetailViewController.m
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaActivityDetailViewController.h"
#import "UIImageView+Init.h"
#import "BoyaMainViewController.h"
#import "UITableView+property.h"
#import "KeyNotes.h"
#import "BoyaParameter.h"
#import "BoyaCellForActivity.h"
#import "Dragon_CommentMethod.h"
#import "UIView+DragonCategory.h"
#import "BoyaCellForActivityDetail.h"
#import "Dragon_Request.h"
#import "BoyaHttpMethod.h"
#import "BoyaNoticeView.h"
#import "BoyaUinfoModel.h"
#import "BoyaActivityViewController.h"
#import "BoyaMainViewController.h"

@interface BoyaActivityDetailViewController ()

@end

@implementation BoyaActivityDetailViewController

@synthesize _model;

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
            _tbv = [[DragonUITableView alloc] initWithFrame:CGRectMake(10, kH_UINavigationController+Boya_H_TOPTAB/2, CGRectGetWidth(self.view.bounds)-20, CGRectGetHeight(self.view.bounds)-kH_StateBar-(mainCon)._tabbar.frame.size.height-kH_UITabBarController-Boya_H_TOPTAB/2-10) isNeedUpdate:NO];
            _tbv._cellH=130;
            [self.view addSubview:_tbv];
            _tbv.backgroundColor=/*[UIColor colorWithRed:248 green:248 blue:255 alpha:1]*/ [UIColor whiteColor];//248 248 255
            _tbv.tag=-1;
            _tbv.separatorStyle=UITableViewCellSeparatorStyleNone;
            [_tbv release];
        }
        
//        if(_model.isMyActive==2)
        {
            UIView *v=[[UIView alloc]initWithFrame:CGRectMake(_tbv.frame.origin.x, _tbv.frame.origin.y+_tbv.frame.size.height, _tbv.frame.size.width, 50)];
            v.backgroundColor=_tbv.backgroundColor;
//            v.backgroundColor=[UIColor redColor];
            [self.view addSubview:v];
            v.tag=-11;
            [v release];
            
            {
                NSString *str=nil;
                switch (_model.isMyActive) {
                    case 1:
                    {
                        str=@"gray";
                    }
                        break;
                    case 2:
                    {
                        str=@"green";
                    }
                        break;
                    case 3:
                    {
                        str=@"gray_stop";
                    }
                        break;
                    default:
                        break;
                }
                UIImage *img=[UIImage imageNamed:str];
                _bt_signUp = [[DragonUIButton alloc] initWithFrame:CGRectMake(5, 2, v.frame.size.width-10, /*v.frame.size.height-10*/ img.size.height/2)];
                _bt_signUp.tag=-1;
                [_bt_signUp setImage:img forState:UIControlStateNormal];
                [_bt_signUp addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
                [_bt_signUp addSignal:[DragonUIButton TOUCH_DOWN] forControlEvents:UIControlEventTouchDown];
                
                [v addSubview:_bt_signUp];
                [_bt_signUp release];

                if (_model.isMyActive==1 || _model.isMyActive==3) {
                    _bt_signUp.enabled=NO;
                    [_bt_signUp setImage:img forState:UIControlStateDisabled];

                }else{
                    _bt_signUp.enabled=YES;
                }
            }
        }
        
        
        
    }else if ([signal is:DragonViewController.DID_APPEAR]){
        
    }else if ([signal is:[DragonViewController LAYOUT_VIEWS]])
    {
//        self.view.backgroundColor=[DragonCommentMethod color:152 green:245 blue:255 alpha:1];//152 245 255
//        _barView.backgroundColor=self.view.backgroundColor;
        [_barView setCenterLabelText:@"活动详情"];
        [_barView setLeftLabelTextColor:[UIColor whiteColor]];
        [_barView setLeftLabelFont:[UIFont systemFontOfSize:22]];
        [_barView hideOrShowbackBt:NO];
        [_barView._leftLabel changePosInSuperViewWithAlignment:2];
    }
    
    //    DLogInfo(@"signal name === %@", signal.name);
    
}

#pragma mark- 只接受tbv信号
static NSString *str_BoyaCellForActivityDetail = @"BoyaCellForActivityDetail";
static NSString *reuseIdentifier = @"reuseIdentifier";

- (void)handleViewSignal_DragonUITableView:(DragonViewSignal *)signal
{
    if ([signal is:[DragonUITableView TABLENUMROWINSEC]])//numberOfRowsInSection
    {
        NSNumber *s = [NSNumber numberWithInteger:2];
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
//        if (indexPath.row==0) {
//            [signal setReturnValue:[NSNumber numberWithInt:_tbv._cellH]];
//        }else if (indexPath.row==1)
        
        switch (indexPath.row) {
            case 0:
                if(indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0)
                {
                    BoyaCellForActivity *cell = [[[BoyaCellForActivity alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
                    [cell setContent:_model indexPath:indexPath tbv:tableView];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;

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
                break;
            case 1://活动介绍
            {
                if (indexPath.row==tableView._muA_differHeightCellView.count/*只创建没计算过的cell*/ || !tableView._muA_differHeightCellView || [tableView._muA_differHeightCellView count]==0) {
                    
                    BoyaCellForActivityDetail *cell = [[[BoyaCellForActivityDetail alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_BoyaCellForActivityDetail] autorelease];
                    [cell setContent:[NSDictionary dictionaryWithObjectsAndKeys:_model.ac_descrpit,[NSNumber numberWithInt:0], nil] indexPath:indexPath tbv:tableView];
                    
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
        
        {
            [signal setReturnValue:[tableview._muA_differHeightCellView objectAtIndex:indexPath.row]];
        }
        
        
        
    }else if ([signal is:[DragonUITableView TABLEDIDSELECT]])//选中cell
    {
        BoyaActivityDetailViewController *con=[[BoyaActivityDetailViewController alloc]init];
        BoyaMainViewController *mainCon=(BoyaMainViewController *)[[self.view superview] viewController];
        
        [mainCon.drNavigationController pushViewController:con animated:YES];
        [con release];
        
    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDENDDRAGGING]])//滚动停止
    {
        
    }else if ([signal is:[DragonUITableView TABLESCROLLVIEWDIDSCROLL]])
    {
    }
}

#pragma mark- 只接受按钮信号
- (void)handleViewSignal_DragonUIButton:(DragonViewSignal *)signal{
    if ([signal is:[DragonUIButton TOUCH_UP_INSIDE]]) {
        DragonUIButton *bt=(DragonUIButton *)signal.source;
        switch (bt.tag) {
            case -1://报名
            {
                if (_model.isMyActive==2) {
                    [self signUp];//创建报名按钮点击视图
                }
                
            }
                break;
            case -2://取消按钮
            {
                
                [_v_comment removeFromSuperview];
                _v_comment = nil;
                //********************取消请求
                
            }
                break;
            case -3://确定按钮
            {
                [self.view setUserInteractionEnabled:NO];
                DragonRequest *request = [BoyaHttpMethod activeid:_model.ac_id name:_inputMessage[0].text phone:_inputMessage[1].text school:_inputMessage[2].text class:_inputMessage[3].text QQ:_inputMessage[4].text mail:_inputMessage[5].text isAlert:YES receive:self];
                [request setTag:1];
                
            }
                break;
                    default:
                break;
        }
    }else if ([signal is:[DragonUIButton TOUCH_DOWN]]){
//        DragonUIButton *bt=(DragonUIButton *)signal.source;
//        if (_model.isMyActive==1) {
//            bt.enabled=NO;
//        }else{
//            bt.enabled=YES;
//        }
    }
}

//报名界面
-(void)signUp {
    
    _v_comment=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height)];
    _v_comment.backgroundColor=[UIColor blackColor];
    
    [self.view addSubview:_v_comment];
    RELEASE(_v_comment);
    
    
    {//取消按钮
        DragonUIButton *bt_cancel = [[DragonUIButton alloc] initWithFrame:CGRectMake(25, 25, 40, 20)];
        [self setBtn:bt_cancel btnTag:-2 btnTitle:@"取消" font:20 idView:_v_comment];//按钮tag不确定
        bt_cancel.alpha=0;
        
        //发送按钮
        DragonUIButton *bt_send = [[DragonUIButton alloc] initWithFrame:CGRectMake(screenShows.size.width-65, bt_cancel.frame.origin.y, bt_cancel.frame.size.width,bt_cancel.frame.size.height)];
        [self setBtn:bt_send btnTag:-3 btnTitle:@"确定" font:20 idView:_v_comment];//按钮tag不确定
        bt_send.alpha=0;
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _v_comment.alpha=0.8;
        [self.view viewWithTag:-2].alpha=1;
        [self.view viewWithTag:-3].alpha=1;
    }];
    
    
    BoyaUinfoModel *byModel = [BoyaUinfoModel JSONReflection:SHARED.uinfo];
    NSString *strName = [NSString stringWithFormat:@"%@", byModel.urealname];
    NSString *strPhone = [NSString stringWithFormat:@"%@", byModel.phone];
    NSString *strSchool = [NSString stringWithFormat:@"%@", byModel.school];
    NSString *strClass = [NSString stringWithFormat:@"%@", byModel.class];
    NSString *strQQ = [NSString stringWithFormat:@"%@", byModel.QQ];
    NSString *strMail = [NSString stringWithFormat:@"%@", byModel.mail];
    
    
    NSArray *a = [NSArray arrayWithObjects:@"姓名",@"电话",@"学校",@"班级",@" QQ",@"邮箱", nil];
    NSArray *b = [NSArray arrayWithObjects:strName,strPhone,strSchool,strClass,strQQ,strMail,nil];
    
    for (int i = 0; i < 6; i++) {
        
        _inputMessage[i] = [[DragonUITextField alloc] initWithFrame:CGRectMake(10, 65+i*45, CGRectGetWidth(self.view.frame)-20, 40)];
        _inputMessage[i].delegate = self;
        _inputMessage[i].placeholder=[a objectAtIndex:i];//UITextField 的初始隐藏文字，当然这个文字的字体大小颜色都可以改，重写uitextfield，下次介绍
        _inputMessage[i].contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//UITextField 上下对齐
        _inputMessage[i].contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;//UITextField 左边对齐
        _inputMessage[i].font=[UIFont fontWithName:@"Times New Roman" size:20];
        _inputMessage[i].tag = i;
        [_inputMessage[i] setBackgroundColor:[UIColor whiteColor]];
        _inputMessage[i].clearButtonMode = UITextFieldViewModeAlways;
        _inputMessage[i].borderStyle = UITextBorderStyleRoundedRect;
        
        _inputMessage[i].text = [b objectAtIndex:i];
        
        [_v_comment addSubview:_inputMessage[i]];
        RELEASE(_inputMessage[i]);
    }
    
    _inputMessage[5].returnKeyType = UIReturnKeyDone;
    
}

//btn方法
-(void)setBtn:(DragonUIButton*)btn btnTag:(int)tag btnTitle:(NSString*)title font:(int)num idView:(id)view {
    
    btn.tag = tag;
    btn.adjustsImageWhenHighlighted = YES;
    [btn setTitle:title];
    btn.backgroundColor=[UIColor clearColor];
    [btn setTitleFont:[UIFont systemFontOfSize:num]];
    [btn addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    RELEASE(btn);
}


//键盘开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField:textField up:YES];
}

//键盘结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField up:NO];
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int animatedDistance;
    int moveUpValue = textField.frame.origin.y+ textField.frame.size.height;
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = 216-(460-moveUpValue-5-35);
    }
    else
    {
        animatedDistance = 162-(320-moveUpValue-5);
    }
    
    if(animatedDistance>0)
    {
        const int movementDistance = animatedDistance;
        const float movementDuration = 0.3f;
        int movement = (up ? -movementDistance : movementDistance);
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        _v_comment.frame = CGRectOffset(_v_comment.frame, 0, movement);
        [UIView commitAnimations];
    }
}


//键盘换行
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    int a =  textField.tag +1;
    if (a > 4) {
        if (a > 5) {
            [textField resignFirstResponder];
            return YES;
        }else {
            a = 5;
            _inputMessage[a].returnKeyType = UIReturnKeyDone;
        }
        
    }
    
    [_inputMessage[a] becomeFirstResponder];
    
    return YES;
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
                
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:@"发送成功！"];
                
                [self performSelector:@selector(removeComment) withObject:nil afterDelay:2.0];
                
//                _label.text = @"扫描成功!";
//                _labelDesc.text = @"您的扫描结果已添加到\r\n【与我相关】-【我游览的场馆】栏目";
//                _btCenter.hidden = NO;
//                _btCenter.tag = 1;
//                [_btCenter setTitle:@"点击查看" forState:UIControlStateNormal];
                
                {//更新内存里的活动信息
                    _model.isMyActive=1;
                    _model.ac_sigup_number=[NSString stringWithFormat:@"%d",([_model.ac_sigup_number intValue]+1)];
                    
                    [_tbv._muA_differHeightCellView removeAllObjects];
                    [_tbv reloadData];
                    
                    [_bt_signUp setImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
                    
                    BoyaMainViewController *con=(BoyaMainViewController *)[self.drNavigationController getViewController:[BoyaMainViewController class]];
                    BoyaActivityViewController *ac=(BoyaActivityViewController *)[[con.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG] viewController];
                    ac._tbv._b_isNeedResizeCell=YES;
                }
               
            }else //处理操作失败
            {
                BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
                [notice setNoticeText:[response message]];
                
//                {//更新内存里的活动信息
//                    _model.isMyActive=1;
//                    _model.ac_sigup_number=[NSString stringWithFormat:@"%d",([_model.ac_sigup_number intValue]+1)];
//                    
//                    [_tbv._muA_differHeightCellView removeAllObjects];
//                    [_tbv reloadData];
//                    
//                    [_bt_signUp setImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
//                    
//                    BoyaMainViewController *con=(BoyaMainViewController *)[self.drNavigationController getViewController:[BoyaMainViewController class]];
//                    BoyaActivityViewController *ac=(BoyaActivityViewController *)[[con.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG] viewController];
//                    ac._tbv._b_isNeedResizeCell=YES;
//                }
                
//                _label.text = @"扫描失败!";
//                _labelDesc.text = @"";
//                _btCenter.hidden = NO;
//                _btCenter.tag = 0;
//                [_btCenter setTitle:@"重新扫描" forState:UIControlStateNormal];
                
            }
            
            [self.view setUserInteractionEnabled:YES];
            
        }
        
    }else if ([request failed])
    {
        BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
        [notice setNoticeText:@"发送失败！"];
        
//        BoyaResponseModel *response = (BoyaResponseModel *)receiveObj;
//        {
//            BoyaNoticeView *notice = [[[BoyaNoticeView alloc] init] autorelease];
//            [notice setNoticeText:[response message]];
//        }
//        [self.view setUserInteractionEnabled:YES];
    }
    
}

- (void)removeComment {
    
    [_v_comment removeFromSuperview];
    _v_comment = nil;
}


@end
