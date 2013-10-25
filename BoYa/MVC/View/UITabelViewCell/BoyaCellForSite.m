//
//  BoyaCellForSite.m
//  BoYa
//
//  Created by zhangchao on 13-5-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaCellForSite.h"
#import "UIImageView+Init.h"
#import "UIView+DragonCategory.h"
#import "UITableView+property.h"
#import "BoyaSiteModel.h"
#import "NSObject+KVO.h"
#import "UIImageView+WebCache.h"
#import "Dragon_CommentMethod.h"
#import "NSString+Count.h"

@implementation BoyaCellForSite

@synthesize _imgV_showImg;

-(void)setContent:(id)data indexPath:(NSIndexPath *)indexPath tbv:(UITableView *)tbv{

    BoyaSiteModel *model=(BoyaSiteModel *)data;
    if (model) {
        
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = [DragonCommentMethod color:221 green:254 blue:255 alpha:1];;
        self.selectedBackgroundView = bgView;
        [bgView release];
        
        //列表图片
        if (!_imgV_showImg) {
//            UIImage *img=model._imgV_showImg.image;
//            _imgV_showImg=model._imgV_showImg;
//            [_imgV_showImg setFrame:CGRectMake(10, 5,100, 75)];
//            [self addSubview:_imgV_showImg];
            
            _imgV_showImg=[[DragonUIImageView alloc]initWithFrame:CGRectMake(10, 5,100, 75) backgroundColor:[DragonCommentMethod color:152 green:245 blue:255 alpha:0] image:_imgV_showImg.image isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_showImg release];
            [_imgV_showImg setFrame:CGRectMake(_imgV_showImg.frame.origin.x, tbv._cellH/2-_imgV_showImg.frame.size.height/2, _imgV_showImg.frame.size.width, _imgV_showImg.frame.size.height)];//上下居中
            
            NSString *encondeUrl=/*[DragonCommentMethod encodeURL:model.pic]*/ [model.cover stringByAddingPercentEscapesUsingEncoding];//把str里的 "" ,‘:’, ‘/’, ‘%’, ‘#’, ‘;’, and ‘@’. Note that ‘%’转成 UTF-8. 避免服务器发的url里有这些特殊字符从而导致 ([NSURL URLWithString:encondeUrl] == nil)
            
            if ([NSURL URLWithString:encondeUrl] == nil) {
                [_imgV_showImg setImage:[UIImage imageNamed:@"no_pic.png"]];
            }else {
                [_imgV_showImg setImageWithURL:[NSURL URLWithString:encondeUrl] placeholderImage:[UIImage imageNamed:@"no_pic.png"]];
            }
            
            
//            [_imgV_showImg addSignal:[DragonUIImageView TAP] object:nil];
//            [((BoyaSiteModel *)data)._imgV_showImg addObserverObj:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:[self class]];

        }else{
//            _imgV_showImg=model._imgV_showImg;
        }
        
        //列表标题
        if (!_lb_name) {
            _lb_name=[[DragonUILabel alloc]initWithFrame:CGRectMake(_imgV_showImg.frame.origin.x+_imgV_showImg.frame.size.width+5, _imgV_showImg.frame.origin.y-5, 0, 0)];
            _lb_name.backgroundColor=[UIColor clearColor];
            _lb_name.textAlignment=UITextAlignmentLeft;
            _lb_name.font=[UIFont systemFontOfSize:15];
            _lb_name._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_name.frame.origin.x, 120);
            _lb_name.text=[model.Place_name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_lb_name setNeedCoretext:NO];
            _lb_name.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_name.numberOfLines=0;
            _lb_name.lineBreakMode=NSLineBreakByCharWrapping;//
            [_lb_name sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_name];
            [_lb_name release];
            
        }else{
            _lb_name.text=model.Place_name;
            [_lb_name sizeToFitByconstrainedSize];
        }
        
        if (!_imgV_time) {
            UIImage *img=[UIImage imageNamed:@"icon_time"];
            _imgV_time=[[DragonUIImageView alloc]initWithFrame:CGRectMake(_lb_name.frame.origin.x, _lb_name.frame.origin.y+_lb_name.frame.size.height+10,12, 12) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_time release];
        }else{
            
        }
        //列表文字
        if (!_lb_time) {
            _lb_time=[[DragonUILabel alloc]initWithFrame:CGRectMake(_imgV_time.frame.origin.x+_imgV_time.frame.size.width+5, _imgV_time.frame.origin.y, 0, 0)];
            _lb_time.backgroundColor=[UIColor clearColor];
            _lb_time.textAlignment=UITextAlignmentLeft;
            _lb_time.font=[UIFont systemFontOfSize:11];
            _lb_time._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_time.frame.origin.x, 118);
            _lb_time.text=[model.place_time stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_lb_time setNeedCoretext:NO];
            _lb_time.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_time.numberOfLines=0;
            _lb_time.lineBreakMode=NSLineBreakByWordWrapping;
            
            if (!_lb_time.text || [_lb_time.text isEqualToString:@""]) {
                _lb_time.text=@"暂无数据";
            }
            
            [_lb_time sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_time];
            [_lb_time release];
            
        }else{
            _lb_time.text=model.place_time;
            [_lb_time sizeToFitByconstrainedSize];
        }
        
        if (!_imgV_adress) {
            UIImage *img=[UIImage imageNamed:@"icon_site"];
            _imgV_adress=[[DragonUIImageView alloc]initWithFrame:CGRectMake(_imgV_time.frame.origin.x, (([_lb_time.text isEqualToString:@"" ] || !_lb_time.text)?(_imgV_time.frame.origin.y+_imgV_time.frame.size.height+5):(_lb_time.frame.origin.y+_lb_time.frame.size.height+5)),12, 12) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_adress release];
        }else{
            
        }
        
        //列表地址
        if (!_lb_adress) {
            _lb_adress=[[DragonUILabel alloc]initWithFrame:CGRectMake(_imgV_adress.frame.origin.x+_imgV_adress.frame.size.width+5, _imgV_adress.frame.origin.y, 0, 0)];
            _lb_adress.backgroundColor=[UIColor clearColor];
            _lb_adress.textAlignment=UITextAlignmentLeft;
            _lb_adress.font=[UIFont systemFontOfSize:11];
            _lb_adress._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_adress.frame.origin.x, 118);
            _lb_adress.text=[model.place_address stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_lb_adress setNeedCoretext:NO];
            _lb_adress.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_adress.numberOfLines=0;
            _lb_adress.lineBreakMode=NSLineBreakByCharWrapping;//.
            
            if (!_lb_adress.text || [_lb_adress.text isEqualToString:@""]) {
                _lb_adress.text=@"暂无数据";
            }
            
            [_lb_adress sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_adress];
            [_lb_adress release];
            
        }else{
            _lb_adress.text=model.place_address;
            [_lb_adress sizeToFitByconstrainedSize];
        }
        
        if (!_imgV_call) {
            UIImage *img=[UIImage imageNamed:@"icon_tel"];
            _imgV_call=[[DragonUIImageView alloc]initWithFrame:CGRectMake(_imgV_adress.frame.origin.x, /*_imgV_adress.frame.origin.y+_imgV_adress.frame.size.height+5*/ (([_lb_adress.text isEqualToString:@"" ] || !_lb_adress.text)?(_imgV_adress.frame.origin.y+_imgV_adress.frame.size.height+5):(_lb_adress.frame.origin.y+_lb_adress.frame.size.height+5)),12, 12) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_call release];
        }else{
            
        }
        //列表电话
        if (!_lb_call) {
            _lb_call=[[DragonUILabel alloc]initWithFrame:CGRectMake(_imgV_call.frame.origin.x+_imgV_call.frame.size.width+5, _imgV_call.frame.origin.y, 0, 0)];
            _lb_call.backgroundColor=[UIColor clearColor];
            _lb_call.textAlignment=UITextAlignmentLeft;
            _lb_call.font=[UIFont systemFontOfSize:11];
            _lb_call._constrainedSize=CGSizeMake(tbv.frame.size.width-_lb_call.frame.origin.x, 118);
            _lb_call.text=[model.place_phone stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [_lb_call setNeedCoretext:NO];
            _lb_call.textColor=[DragonCommentMethod color:51 green:51 blue:51 alpha:1];
            _lb_call.numberOfLines=0;
            _lb_call.lineBreakMode=NSLineBreakByCharWrapping;//
            
            if (!_lb_call.text || [_lb_call.text isEqualToString:@""]) {
                _lb_call.text=@"暂无数据";
            }
            [_lb_call sizeToFitByconstrainedSize];
            
            [self addSubview:_lb_call];
            [_lb_call release];
            
        }else{
            _lb_call.text=model.place_phone;
            [_lb_call sizeToFitByconstrainedSize];
        }
        
        if (!_imgV_separatorLine) {//
            UIImage *img=[UIImage imageNamed:@"sepLine620.png"];
            _imgV_separatorLine=[[DragonUIImageView alloc]initWithFrame:CGRectMake(0, /*_imgV_call.frame.origin.y+_imgV_call.frame.size.height+10*/ (([_lb_call.text isEqualToString:@"" ] || !_lb_call.text)?(_imgV_call.frame.origin.y+_imgV_call.frame.size.height+5):(_lb_call.frame.origin.y+_lb_call.frame.size.height+5)), img.size.width/2, img.size.height/2) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:NO masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
            [_imgV_separatorLine release];
        }
        
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _imgV_separatorLine.frame.origin.y+_imgV_separatorLine.frame.size.height)];
        [_imgV_showImg changePosInSuperViewWithAlignment:1];
    }
}


- (void) observeValueForKeyPath:(NSString *)keyPath
					   ofObject:(id)object
						 change:(NSDictionary *)change
						context:(void *)context
{
  Class class=(Class)context;
  NSString *className=[NSString stringWithCString:object_getClassName(class) encoding:NSUTF8StringEncoding];

    if ([className isEqualToString:[NSString stringWithCString:object_getClassName([self class]) encoding:NSUTF8StringEncoding]]) {
        _imgV_showImg.image=[change objectForKey:@"new"];

    }else{//将不能处理的 key 转发给 super 的 observeValueForKeyPath 来处理
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
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
