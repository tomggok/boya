//
//  BoyaCellForActivityDetail.m
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCellForActivityDetail.h"
#import "UIView+DragonCategory.h"
#import "UITableView+property.h"
#import "UIImageView+Init.h"

@implementation BoyaCellForActivityDetail

-(void)setContent:(id)data/*key==0:活动介绍 key==1:场馆介绍*/ indexPath:(NSIndexPath *)indexPath tbv:(UITableView *)tbv{

    NSDictionary *d=data;
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    if (!_lb_IntroductionOfActivities) {
        _lb_IntroductionOfActivities=[[DragonUILabel alloc]initWithFrame:CGRectMake(10, 5, 0, 0)];
        _lb_IntroductionOfActivities.backgroundColor=[UIColor clearColor];
        _lb_IntroductionOfActivities.textAlignment=UITextAlignmentLeft;
        [_lb_IntroductionOfActivities setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        _lb_IntroductionOfActivities._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_IntroductionOfActivities.frame.origin.x, 100);
        _lb_IntroductionOfActivities.text=([((NSNumber *)[[d allKeys]objectAtIndex:0]) intValue]==0)?(@"活动介绍"):(@"场馆介绍");
        [_lb_IntroductionOfActivities setNeedCoretext:NO];
        _lb_IntroductionOfActivities.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
        _lb_IntroductionOfActivities.numberOfLines=1;
        _lb_IntroductionOfActivities.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
        [_lb_IntroductionOfActivities sizeToFitByconstrainedSize];
        
        [self addSubview:_lb_IntroductionOfActivities];
        [_lb_IntroductionOfActivities release];
        
    }
    
    if (!_lb_IntroductionOfActivitiesContent) {
        _lb_IntroductionOfActivitiesContent=[[DragonUILabel alloc]initWithFrame:CGRectMake(_lb_IntroductionOfActivities.frame.origin.x, _lb_IntroductionOfActivities.frame.origin.y+_lb_IntroductionOfActivities.frame.size.height+10, 0, 0)];
        _lb_IntroductionOfActivitiesContent.backgroundColor=[UIColor clearColor];
        _lb_IntroductionOfActivitiesContent.textAlignment=UITextAlignmentLeft;
        _lb_IntroductionOfActivitiesContent.font=[UIFont systemFontOfSize:13];
        _lb_IntroductionOfActivitiesContent._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_IntroductionOfActivitiesContent.frame.origin.x*2, 1000);
        _lb_IntroductionOfActivitiesContent.text=[[d allValues]objectAtIndex:0];
        [_lb_IntroductionOfActivitiesContent setNeedCoretext:NO];
        _lb_IntroductionOfActivitiesContent.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
        _lb_IntroductionOfActivitiesContent.numberOfLines=0;
        _lb_IntroductionOfActivitiesContent.lineBreakMode=NSLineBreakByCharWrapping;
        [_lb_IntroductionOfActivitiesContent sizeToFitByconstrainedSize];
        
        [self addSubview:_lb_IntroductionOfActivitiesContent];
        [_lb_IntroductionOfActivitiesContent release];
        
    }
    if (!_imgV_separatorLine) {//
        UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
        _imgV_separatorLine=[[DragonUIImageView alloc]initWithFrame:CGRectMake(0, _lb_IntroductionOfActivitiesContent.frame.origin.y+_lb_IntroductionOfActivitiesContent.frame.size.height+10, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
        [_imgV_separatorLine release];
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _imgV_separatorLine.frame.origin.y+_imgV_separatorLine.frame.size.height)];
}


@end
