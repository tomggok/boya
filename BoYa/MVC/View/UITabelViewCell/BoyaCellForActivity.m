//
//  BoyaCellForActivity.m
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCellForActivity.h"
#import "UIImageView+Init.h"
#import "UIView+DragonCategory.h"
#import "UITableView+property.h"
#import "Dragon_UIImageView.h"
#import "BoyaActivityModel.h"
#import "UIImageView+WebCache.h"
#import "NSString+Count.h"

@implementation BoyaCellForActivity

-(void)setContent:(id)data indexPath:(NSIndexPath *)indexPath tbv:(UITableView *)tbv{
    
    BoyaActivityModel *model=(BoyaActivityModel *)data;

    if (model) {
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [DragonCommentMethod color:221 green:254 blue:255 alpha:1];;
        self.selectedBackgroundView = bgView;
        [bgView release];
        
        //列表标题
        if (!_lb_name) {
            _lb_name=[[DragonUILabel alloc]initWithFrame:CGRectMake(10, 10, 0, 0)];
            _lb_name.backgroundColor=[UIColor clearColor];
            _lb_name.textAlignment=UITextAlignmentLeft;
            _lb_name.font=[UIFont systemFontOfSize:15];
            _lb_name._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_name.frame.origin.x, 120);
            _lb_name.text=model.ac_title;
            [_lb_name setNeedCoretext:NO];
            _lb_name.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_name.numberOfLines=0;
            _lb_name.lineBreakMode=NSLineBreakByWordWrapping;//
            [_lb_name sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_name];
            [_lb_name release];
            
        }else{
            _lb_name.text=model.ac_title;
            [_lb_name sizeToFitByconstrainedSize];
        }
        
        if (!_imgV_showImg) {
            //            UIImage *img=model._imgV_showImg.image;
//            _imgV_showImg=(DragonUIImageView *)model._imgV_showImg;
//            [_imgV_showImg setFrame:CGRectMake(_lb_name.frame.origin.x, _lb_name.frame.origin.y+_lb_name.frame.size.height+10,100, 75)];
//            [self addSubview:_imgV_showImg];
            
            _imgV_showImg=[[DragonUIImageView alloc]initWithFrame:CGRectMake(_lb_name.frame.origin.x, _lb_name.frame.origin.y+_lb_name.frame.size.height+10,100, 75) backgroundColor:[DragonCommentMethod color:152 green:245 blue:255 alpha:0] image:_imgV_showImg.image isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_showImg release];
//            [_imgV_showImg setFrame:CGRectMake(_imgV_showImg.frame.origin.x, tbv._cellH/2-_imgV_showImg.frame.size.height/2, _imgV_showImg.frame.size.width, _imgV_showImg.frame.size.height)];//上下居中
            
            NSString *encondeUrl=/*[DragonCommentMethod encodeURL:model.pic]*/ [model.pic stringByAddingPercentEscapesUsingEncoding];//把str里的 "" ,‘:’, ‘/’, ‘%’, ‘#’, ‘;’, and ‘@’. Note that ‘%’转成 UTF-8. 避免服务器发的url里有这些特殊字符从而导致 ([NSURL URLWithString:encondeUrl] == nil)
            
            if ([NSURL URLWithString:encondeUrl] == nil) {
                [_imgV_showImg setImage:[UIImage imageNamed:@"no_pic.png"]];
            }else
            {
                [_imgV_showImg setImageWithURL:[NSURL URLWithString:encondeUrl] placeholderImage:[UIImage imageNamed:@"no_pic.png"]];

            }
            
            
           //            [_imgV_showImg addSignal:[DragonUIImageView TAP] object:nil];

        }else{
//            _imgV_showImg=(DragonUIImageView *)model._imgV_showImg;
        }
        
        if (!_imgV_flag) {
            NSString *str=nil;
            switch ([model.ac_flag intValue]) {
                case 1:
                {
                    str=@"note_soon";
                }
                    break;
                case 2:
                {
                    str=@"note_now";
                }
                    break;
                case 3:
                {
                    str=@"note_over";
                }
                    break;
                default:
                    break;
            }
            UIImage *img=[UIImage imageNamed:str];
            _imgV_flag=[[DragonUIImageView alloc]initWithFrame:CGRectMake(_imgV_showImg.frame.origin.x, _imgV_showImg.frame.origin.y,img.size.width/2, img.size.height/2) backgroundColor:[DragonCommentMethod color:152 green:245 blue:255 alpha:0] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_flag release];            
        }

        //列表时间
        if (!_imgV_time) {
            UIImage *img=[UIImage imageNamed:@"icon_time"];
            _imgV_time=[[DragonUIImageView alloc]initWithFrame:CGRectMake(_imgV_showImg.frame.origin.x+_imgV_showImg.frame.size.width+5, _imgV_showImg.frame.origin.y,12, 12) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_time release];
        }else{
            
        }

        if (!_lb_time) {
            _lb_time=[[DragonUILabel alloc]initWithFrame:CGRectMake(_imgV_time.frame.origin.x+_imgV_time.frame.size.width+5, _imgV_time.frame.origin.y, 0, 0)];
            _lb_time.backgroundColor=[UIColor clearColor];
            _lb_time.textAlignment=UITextAlignmentLeft;
            _lb_time.font=[UIFont systemFontOfSize:11];
            _lb_time._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_time.frame.origin.x-20, 30);
            _lb_time.text=[NSString stringWithFormat:@"%@至%@",model.ac_time,model.ac_endtime];
            [_lb_time setNeedCoretext:NO];
            _lb_time.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_time.numberOfLines=1;
            _lb_time.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
            
            if (!_lb_time.text || [_lb_time.text isEqualToString:@""]) {
                _lb_time.text=@"暂无数据";
            }
            
            [_lb_time sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_time];
            [_lb_time release];
            
        }else{
            _lb_time.text=[NSString stringWithFormat:@"%@至%@",model.ac_time,model.ac_endtime];
            [_lb_time sizeToFitByconstrainedSize];
        }
        //报名截止
        if (!_lb_sigUptime) {
            _lb_sigUptime=[[DragonUILabel alloc]initWithFrame:CGRectMake(_lb_time.frame.origin.x, _lb_time.frame.origin.y+_lb_time.frame.size.height, 0, 0)];
            _lb_sigUptime.backgroundColor=[UIColor clearColor];
            _lb_sigUptime.textAlignment=UITextAlignmentLeft;
            _lb_sigUptime.font=[UIFont systemFontOfSize:11];
            _lb_sigUptime._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_time.frame.origin.x-20, 30);
            _lb_sigUptime.text=[NSString stringWithFormat:@"%@报名截止",model.ac_regtime];
            [_lb_sigUptime setNeedCoretext:NO];
            _lb_sigUptime.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_sigUptime.numberOfLines=1;
            _lb_sigUptime.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
            
            if (!_lb_sigUptime.text || [_lb_sigUptime.text isEqualToString:@""]) {
                _lb_sigUptime.text=@"暂无数据";
            }
            
            [_lb_sigUptime sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_sigUptime];
            [_lb_sigUptime release];
            
        }else{
            _lb_sigUptime.text=[NSString stringWithFormat:@"%@报名截止",model.ac_regtime];
            [_lb_sigUptime sizeToFitByconstrainedSize];
        }

        if (!_imgV_adress) {
            UIImage *img=[UIImage imageNamed:@"icon_site"];
            _imgV_adress=[[DragonUIImageView alloc]initWithFrame:CGRectMake(_imgV_time.frame.origin.x, _lb_sigUptime.frame.origin.y+_lb_sigUptime.frame.size.height+5,12, 12) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_adress release];
        }else{
            
        }

        if (!_lb_adress) {
            _lb_adress=[[DragonUILabel alloc]initWithFrame:CGRectMake(_imgV_adress.frame.origin.x+_imgV_adress.frame.size.width+5, _imgV_adress.frame.origin.y, 0, 0)];
            _lb_adress.backgroundColor=[UIColor clearColor];
            _lb_adress.textAlignment=UITextAlignmentLeft;
            _lb_adress.font=[UIFont systemFontOfSize:11];
            _lb_adress._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_adress.frame.origin.x, 8);
            _lb_adress.text=model.ac_addr;
            [_lb_adress setNeedCoretext:NO];
            _lb_adress.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_adress.numberOfLines=1;
            _lb_adress.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
            
            if (!_lb_adress.text || [_lb_adress.text isEqualToString:@""]) {
                _lb_adress.text=@"暂无数据";
            }
            
            [_lb_adress sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_adress];
            [_lb_adress release];
            
        }else{
            _lb_adress.text=model.ac_addr;
            [_lb_adress sizeToFitByconstrainedSize];
        }
        
        if (!_lb_numberOfRegistration) {
            _lb_numberOfRegistration=[[DragonUILabel alloc]initWithFrame:CGRectMake(_lb_adress.frame.origin.x, _imgV_adress.frame.origin.y+_imgV_adress.frame.size.height+10, 250, 100)];
            _lb_numberOfRegistration.backgroundColor=[UIColor clearColor];
            _lb_numberOfRegistration.textAlignment=UITextAlignmentLeft;
            _lb_numberOfRegistration.font=[UIFont boldSystemFontOfSize:20];
            _lb_numberOfRegistration._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_numberOfRegistration.frame.origin.x, 100);
            _lb_numberOfRegistration.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_numberOfRegistration.numberOfLines=1;
            _lb_numberOfRegistration.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
            _lb_numberOfRegistration.text=model.ac_sigup_number;
            [_lb_numberOfRegistration sizeToFitByconstrainedSize];

//            {
//                NSString *numberOfRegistration=model.ac_sigup_number;
//                _lb_numberOfRegistration.text=[NSString stringWithFormat:@"%@人已报名",numberOfRegistration];
//                _lb_numberOfRegistration.FONT(@"0",[NSString stringWithFormat:@"%d",numberOfRegistration.length],@"20.f");
//                _lb_numberOfRegistration.FONT([NSString stringWithFormat:@"%d",numberOfRegistration.length],[NSString stringWithFormat:@"%d",4],@"11.f");
//                [_lb_numberOfRegistration setNeedCoretext:YES];
//            }
            

            [self addSubview:_lb_numberOfRegistration];
            [_lb_numberOfRegistration release];
            
        }else{
//            NSString *numberOfRegistration=model.ac_sigup_number;
//            _lb_numberOfRegistration.text=[NSString stringWithFormat:@"%@人已报名",numberOfRegistration];
//            _lb_numberOfRegistration.FONT(@"0",[NSString stringWithFormat:@"%d",numberOfRegistration.length],@"20.f");
//            [_lb_numberOfRegistration setNeedCoretext:YES];
        }
        
        if (!_lb_mingrenshu) {
            _lb_mingrenshu=[[DragonUILabel alloc]initWithFrame:CGRectMake(_lb_numberOfRegistration.frame.origin.x+_lb_numberOfRegistration.frame.size.width+5, 0,0,0)];
            _lb_mingrenshu.backgroundColor=[UIColor clearColor];
            _lb_mingrenshu.textAlignment=UITextAlignmentLeft;
            _lb_mingrenshu.font=[UIFont boldSystemFontOfSize:10];
            _lb_mingrenshu._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_mingrenshu.frame.origin.x, 100);
            _lb_mingrenshu.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_mingrenshu.numberOfLines=1;
            _lb_mingrenshu.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
            _lb_mingrenshu.text=@"人已报名";
            [_lb_mingrenshu sizeToFitByconstrainedSize];
            [_lb_mingrenshu setFrame:CGRectMake(_lb_mingrenshu.frame.origin.x, _lb_numberOfRegistration.frame.origin.y+_lb_numberOfRegistration.frame.size.height-_lb_mingrenshu.frame.size.height-3, _lb_mingrenshu.frame.size.width, _lb_mingrenshu.frame.size.height)];
            
            [self addSubview:_lb_mingrenshu];
            [_lb_mingrenshu release];
            
        }
        
        if (!_imgV_separatorLine) {//
            UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
            _imgV_separatorLine=[[DragonUIImageView alloc]initWithFrame:CGRectMake(0, /*tbv._cellH-img.size.height/2*/(([_lb_numberOfRegistration.text isEqualToString:@"" ] || !_lb_numberOfRegistration.text)?(_imgV_adress.frame.origin.y+_imgV_adress.frame.size.height+5):(_lb_numberOfRegistration.frame.origin.y+_lb_numberOfRegistration.frame.size.height+5)), img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_separatorLine release];
        }
        
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _imgV_separatorLine.frame.origin.y+_imgV_separatorLine.frame.size.height)];

    }
}

#pragma mark- 只接受DragonUIImageView信号
- (void)handleViewSignal_UIImageView:(DragonViewSignal *)signal
{
    if ([signal is:[UIImageView SDWEBIMGDOWNFAILURE]]) {
        
        [_imgV_showImg setImage:[UIImage imageNamed:@"no_pic.png"]];
    }
    
    
}

@end
