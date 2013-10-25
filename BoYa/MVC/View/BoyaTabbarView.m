//
//  tabbarView.m
//  tabbarTest
//
//  Created by Kevin Lee on 13-5-6.
//  Copyright (c) 2013年 Kevin. All rights reserved.
//

#import "BoyaTabbarView.h"
#import "CALayer+Custom.h"
@implementation BoyaTabbarView

@synthesize _bt1,_bt2,_bt3,_bt4,_btCenter,_imgV_tabbarView,_imgV_tabbarViewCenter;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setFrame:frame];
//        [self setBackgroundColor:[UIColor blueColor]];
        [self layoutView];
    }
    return self;
}

-(void)layoutView
{
    
//    _imgV_tabbarView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_0"]];
    _imgV_tabbarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, /*9*/ self.frame.size.height-45, /*_imgV_tabbarView.bounds.size.width*/ screenShows.size.width, /*51*/45)];
//    [_imgV_tabbarView setFrame:CGRectMake(0, 9, /*_imgV_tabbarView.bounds.size.width*/ screenShows.size.width, /*51*/)];
    [_imgV_tabbarView setUserInteractionEnabled:YES];
    _imgV_tabbarView.backgroundColor=[DragonCommentMethod color:107 green:212 blue:216 alpha:1.f];
    
//    _imgV_tabbarViewCenter = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_mainbtn_bg"]];
//
//    _imgV_tabbarViewCenter.center = CGPointMake(self.center.x, self.bounds.size.height/2.0);
//    
//    [_imgV_tabbarViewCenter setUserInteractionEnabled:YES];
    
//    _btCenter = [UIButton buttonWithType:UIButtonTypeCustom];
//    _btCenter.adjustsImageWhenHighlighted = YES;
//    [_btCenter setBackgroundImage:[UIImage imageNamed:@"tabbar_mainbtn"] forState:UIControlStateNormal];
//    [_btCenter setFrame:CGRectMake(0, 0, 46, 46)];
//    _btCenter.center =CGPointMake(_imgV_tabbarViewCenter.bounds.size.width/2.0, _imgV_tabbarViewCenter.bounds.size.height/2.0 + 5) ;
//    _btCenter.tag=2;
    
//    [/*_imgV_tabbarViewCenter*/_imgV_tabbarView addSubview:_btCenter];
    
    [self addSubview:_imgV_tabbarView];
    [_imgV_tabbarView release];
    
//    [self addSubview:_imgV_tabbarViewCenter];
    
    [self layoutBtn];

}

-(void)layoutBtn
{
    {
        UIImage *img=[UIImage imageNamed:@"tab_place_b"];

    _bt1 = [[DragonUIButton alloc] initWithFrame:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];
    _bt1.tag=0;
    [_bt1 setImage:img forState:UIControlStateNormal];
    [_bt1 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
    [_imgV_tabbarView addSubview:_bt1];
    [_bt1 release];
    }
    
{
    UIImage *img=[UIImage imageNamed:@"tab_list_a"];

    _bt2 = [[DragonUIButton alloc] initWithFrame:CGRectMake(img.size.width/2, 0, img.size.width/2, img.size.height/2)];
    _bt2.tag=1;
    [_bt2 setImage:img forState:UIControlStateNormal];
    [_bt2 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
    [_imgV_tabbarView addSubview:_bt2];
    [_bt2 release];
}

    {
        UIImage *img=[UIImage imageNamed:@"tab_mine_a"];

    _bt3 = [[DragonUIButton alloc] initWithFrame:CGRectMake(img.size.width+_btCenter.frame.size.width, 0, img.size.width/2, img.size.height/2)];
    _bt3.tag=3;
        [_bt3 setImage:img forState:UIControlStateNormal];
    [_bt3 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
    [_imgV_tabbarView addSubview:_bt3];
    [_bt3 release];
    }

    {
        UIImage *img=[UIImage imageNamed:@"tab_set_a"];
        
    _bt4 = [[DragonUIButton alloc] initWithFrame:CGRectMake(_bt3.frame.origin.x+_bt3.frame.size.width, 0, img.size.width/2, img.size.height/2)];
    _bt4.tag=4;
        [_bt4 setImage:img forState:UIControlStateNormal];
    [_bt4 addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
    [_imgV_tabbarView addSubview:_bt4];
    [_bt4 release];
    }
    
    {
        UIImage *img=[UIImage imageNamed:@"btn_qrcode"];
        _btCenter = [[DragonUIButton alloc] initWithFrame:CGRectMake(0, (img.size.height/2-_imgV_tabbarView.frame.size.height), img.size.width/2, img.size.height/2)];
        _btCenter.tag=2;
        _btCenter.adjustsImageWhenHighlighted = YES;
        [_btCenter setBackgroundImage:[UIImage imageNamed:@"btn_qrcode"] forState:UIControlStateNormal];
        [_btCenter setBackgroundImage:[UIImage imageNamed:@"btn_qrcode_b"] forState:UIControlStateSelected];
        [_btCenter setBackgroundImage:[UIImage imageNamed:@"btn_qrcode_b"] forState:UIControlStateHighlighted];
        [_btCenter addSignal:[DragonUIButton TOUCH_UP_INSIDE] forControlEvents:UIControlEventTouchUpInside];
        [_imgV_tabbarView addSubview:_btCenter];
        //        [_btCenter.layer AddShadowByShadowColor:[UIColor blackColor] shadowOffset:CGSizeMake(-3, 5) shadowOpacity:1 shadowRadius:1];
        _btCenter.center =CGPointMake/*(_imgV_tabbarViewCenter.bounds.size.width/2.0, _imgV_tabbarViewCenter.bounds.size.height/2.0 )*/ (self.center.x+1, /*self.bounds.size.height/2.0*/ _btCenter.frame.origin.y) ;
        [_btCenter release];
    }
    
    UIImage *img=[UIImage imageNamed:@"tab_mine_a"];
    [_bt3 setFrame:CGRectMake(img.size.width+_btCenter.frame.size.width-2, 0, img.size.width/2, img.size.height/2)];
    
    UIImage *img2=[UIImage imageNamed:@"tab_set_a"];
    [_bt4 setFrame:CGRectMake(_bt3.frame.origin.x+_bt3.frame.size.width, 0, img2.size.width/2, img2.size.height/2)];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
