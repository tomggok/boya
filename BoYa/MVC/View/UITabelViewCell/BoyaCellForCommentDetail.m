//
//  BoyaCellForCommentDetail.m
//  BoYa
//
//  Created by zhangchao on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCellForCommentDetail.h"
#import "UIImageView+Init.h"
#import "UIView+DragonCategory.h"
#import "UITableView+property.h"
#import "BoyaSiteCommentModel.h"
#import "Dragon_CommentMethod.h"

@implementation BoyaCellForCommentDetail

-(void)setContent:(id)data indexPath:(NSIndexPath *)indexPath tbv:(UITableView *)tbv
{
    BoyaSiteCommentModel *model=data;
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    if (!data) {
        return;
    }
    if (!_lb_name) {
        _lb_name=[[DragonUILabel alloc]initWithFrame:CGRectMake(10, 5, 0, 0)];
        _lb_name.backgroundColor=[UIColor clearColor];
        _lb_name.textAlignment=UITextAlignmentLeft;
        _lb_name.font=[UIFont systemFontOfSize:15];
        _lb_name._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_name.frame.origin.x, 100);
        _lb_name.text=model.Member_name;
        [_lb_name setNeedCoretext:NO];
        _lb_name.textColor=[DragonCommentMethod color:49 green:148 blue:151 alpha:1];
        _lb_name.numberOfLines=0;
        _lb_name.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
        [_lb_name sizeToFitByconstrainedSize];
        
        [self addSubview:_lb_name];
        [_lb_name release];
        
    }

    if (!_lb_time) {
        _lb_time=[[DragonUILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _lb_time.backgroundColor=[UIColor clearColor];
        _lb_time.textAlignment=UITextAlignmentRight;
        _lb_time.font=[UIFont systemFontOfSize:11];
        _lb_time._constrainedSize=CGSizeMake(100, 20);
        _lb_time.text=model.Com_time;
        [_lb_time setNeedCoretext:NO];
        _lb_time.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
        _lb_time.numberOfLines=1;
        _lb_time.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
        [_lb_time sizeToFitByconstrainedSize];
        
        [self addSubview:_lb_time];
        [_lb_time release];
        [_lb_time setFrame:CGRectMake(self.frame.size.width-_lb_time.frame.size.width-25, _lb_name.frame.origin.y+_lb_name.frame.size.height-_lb_time.frame.size.height, _lb_time.frame.size.width, _lb_time.frame.size.height)];
    }
    
    if (!_v_score) {/*五颗星的背景*/
        _v_score=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 20)];
        _v_score.backgroundColor=[UIColor clearColor];
        int star=[model.Com_star intValue]/2;        
        _muA_imgV_score=[NSMutableArray arrayWithCapacity:10];
        for (int i=1; i<6; i++) {
            UIImage *img=[UIImage imageNamed:((i<=star)?(@"star_yes"):(@"star_no"))];
            DragonUIImageView *imgV=[[DragonUIImageView alloc]initWithFrame:CGRectMake(((i-1)*20), 0, 20, 20) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:nil superView:_v_score Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [imgV release];
            [_v_score setFrame:CGRectMake(0, 0, imgV.frame.origin.x+imgV.frame.size.width, imgV.frame.size.height)];
            [_muA_imgV_score addObject:imgV];
        }
        
        [self addSubview:_v_score];
        [_v_score release];
        if (_lb_name.frame.origin.x+_lb_name.frame.size.width+5+_v_score.frame.size.width>_lb_time.frame.origin.x) {//评分移到下一行
            [_v_score setFrame:CGRectMake(_lb_name.frame.origin.x, _lb_name.frame.origin.y+_lb_name.frame.size.height+5, _v_score.frame.size.width, _v_score.frame.size.height)];
        }else{//放_lb_name右边
            [_v_score setFrame:CGRectMake(_lb_name.frame.origin.x+_lb_name.frame.size.width+5, _lb_name.frame.origin.y+_lb_name.frame.size.height-_v_score.frame.size.height, _v_score.frame.size.width, _v_score.frame.size.height)];
//            _v_score.center=CGPointMake(_v_score.center.x, _lb_name.center.y);
        }
    }
    
    if (!_lb_content) {
        _lb_content=[[DragonUILabel alloc]initWithFrame:CGRectMake(_lb_name.frame.origin.x, _v_score.frame.origin.y+_v_score.frame.size.height+5, 0, 0)];
        _lb_content.backgroundColor=[UIColor clearColor];
        _lb_content.textAlignment=UITextAlignmentLeft;
        _lb_content.font=[UIFont systemFontOfSize:13];
        _lb_content._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_content.frame.origin.x*2, 1000);
        _lb_content.text=model.Com_content;
        [_lb_content setNeedCoretext:NO];
        _lb_content.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
        _lb_content.numberOfLines=0;
        _lb_content.lineBreakMode=NSLineBreakByCharWrapping;
        [_lb_content sizeToFitByconstrainedSize];
        
        [self addSubview:_lb_content];
        [_lb_content release];
        
    }
    
    if (!_imgV_separatorLine) {//
        UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
        _imgV_separatorLine=[[DragonUIImageView alloc]initWithFrame:CGRectMake(0, _lb_content.frame.origin.y+_lb_content.frame.size.height+10, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
        [_imgV_separatorLine release];
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _imgV_separatorLine.frame.origin.y+_imgV_separatorLine.frame.size.height)];
}

@end
