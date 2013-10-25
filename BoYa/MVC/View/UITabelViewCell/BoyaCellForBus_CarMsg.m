//
//  BoyaCellForBus_CarMsg.m
//  BoYa
//
//  Created by zhangchao on 13-5-29.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCellForBus_CarMsg.h"
#import "UIImageView+Init.h"
#import "UIView+DragonCategory.h"
#import "UITableView+property.h"
#import "BoyaSiteModel.h"

@implementation BoyaCellForBus_CarMsg

-(void)setContent:(id)data indexPath:(NSIndexPath *)indexPath tbv:(UITableView *)tbv
{
    BoyaSiteModel *model=(BoyaSiteModel *)data;
    self.selectionStyle=UITableViewCellSelectionStyleNone;

    if (!_lb_title) {
        _lb_title=[[DragonUILabel alloc]initWithFrame:CGRectMake(10, 5, 0, 0)];
        _lb_title.backgroundColor=[UIColor clearColor];
        _lb_title.textAlignment=UITextAlignmentLeft;
        [_lb_title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13]];
        _lb_title._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_title.frame.origin.x, 100);
        _lb_title.text=((indexPath.row==2)?(@"公交信息"):(@"停车信息"));
        [_lb_title setNeedCoretext:NO];
        _lb_title.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
        _lb_title.numberOfLines=1;
        _lb_title.lineBreakMode=NSLineBreakByTruncatingTail;//一行显示不够用...
        [_lb_title sizeToFitByconstrainedSize];
        
        [self addSubview:_lb_title];
        [_lb_title release];
        
    }else{
        _lb_title.text=((indexPath.row==2)?(@"公交信息"):(@"停车信息"));
    }
    
    if (!_lb_content) {
        _lb_content=[[DragonUILabel alloc]initWithFrame:CGRectMake(_lb_title.frame.origin.x, _lb_title.frame.origin.y+_lb_title.frame.size.height+10, 0, 0)];
        _lb_content.backgroundColor=[UIColor clearColor];
        _lb_content.textAlignment=UITextAlignmentLeft;
        _lb_content.font=[UIFont systemFontOfSize:13];
        _lb_content._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_content.frame.origin.x*2, 1000);
        _lb_content.text=((indexPath.row==2)?(model.bus):(model.stop));
        [_lb_content setNeedCoretext:NO];
        _lb_content.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
        _lb_content.numberOfLines=0;
        _lb_content.lineBreakMode=NSLineBreakByCharWrapping;
        
        if (!_lb_content.text || [_lb_content.text isEqualToString:@""] || [_lb_content.text isEqualToString:@"0"] ) {
            _lb_content.text=@"数据更新中 , 即将开放";
        }else if(indexPath.row==3 && _lb_content.text &&![_lb_content.text isEqualToString:@"0"]){
            _lb_content.text=[NSString stringWithFormat:@"还剩%@个停车位",(model.stop)];
        }
        
        [_lb_content sizeToFitByconstrainedSize];
        
        [self addSubview:_lb_content];
        [_lb_content release];
        
    }else{
//        _lb_content.text=((indexPath.row==2)?(model.bus):(model.stop));
//        [_lb_content sizeToFitByconstrainedSize];
    }
    
    if (!_imgV_separatorLine) {//
        UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
        _imgV_separatorLine=[[DragonUIImageView alloc]initWithFrame:CGRectMake(0, _lb_content.frame.origin.y+_lb_content.frame.size.height+10, img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
        [_imgV_separatorLine release];
    }
    
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _imgV_separatorLine.frame.origin.y+_imgV_separatorLine.frame.size.height)];
}

@end
