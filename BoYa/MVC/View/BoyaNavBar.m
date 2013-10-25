//
//  BoyaNavBar.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaNavBar.h"
#import "NSString+Size.h"
#import "BoyaBaseViewController.h"

@implementation BoyaNavBar

@synthesize _leftLabel;
@synthesize _centerLabel;
@synthesize rightBt = _rightBt;

- (void)dealloc
{
    RELEASEVIEW(_leftLabel);
    RELEASEVIEW(_leftImgView);
    RELEASEVIEW(_centerLabel);
    RELEASEOBJ(_rightBt);
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _leftLabel = [[DragonUILabel alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
        [_leftLabel setTextColor:[UIColor whiteColor]];
        [_leftLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_leftLabel];
        
        _leftImgView = [[DragonUIImageView alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
        [self addSubview:_leftImgView];

        _centerLabel = [[DragonUILabel alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
        [_centerLabel setTextColor:[UIColor whiteColor]];
        [_centerLabel setBackgroundColor:[UIColor clearColor]];
        [_centerLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_centerLabel];
        
        UIImageView *lineImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 43, 300, 2)];
        [lineImg setImage:[UIImage imageNamed:@"topline_light.png"]];
        [self addSubview:lineImg];
        [lineImg release];
        
        
        _rightBt = [[DragonUIButton alloc] initWithFrame:CGRectMake(15, 15, 10, 10)];
        [_rightBt setTitleColor:[UIColor whiteColor]];
        [_rightBt setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_rightBt];
        
    }
    return self;
}

- (void)setRightBt:(NSString *)imgNameNormal hightIMG:(NSString *)imgNameHighLighted{
    UIImage *imgNor = [UIImage imageNamed:imgNameNormal];
    UIImage *imgSel = [UIImage imageNamed:imgNameHighLighted];
    
    [_rightBt setImage:imgNor forState:UIControlStateNormal];
    [_rightBt setImage:imgSel forState:UIControlStateHighlighted];
    [_rightBt setFrame:CGRectMake(CGRectGetWidth(self.frame)-10-imgNor.size.width/2, 45 - (imgNor.size.height/2)-8, imgNor.size.width/2, imgNor.size.height/2)];
//    [_rightBt setBackgroundColor:[UIColor redColor]];
    
    int nlength = CGRectGetWidth(_rightBt.frame);
    
    UIImage *imageUnderLine = [UIImage imageNamed:@"topline_dark.png"];
    DragonUIImageView *imgULine = [[DragonUIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-10-imgNor.size.width/2, 43, nlength, imageUnderLine.size.height/2)];
    [imgULine setImage:imageUnderLine];
    [self addSubview:imgULine];
    RELEASE(imgULine);
}


- (void)setRightText:(NSString *)rightBtText{
    [_rightBt setTitle:rightBtText];
    
    CGSize textSzie = [_rightBt.title createActiveFrameByfontSize:_rightBt.titleFont
                                                     constrainedSize:CGSizeMake(1000, 1000)
                                                       lineBreakMode:NSLineBreakByTruncatingTail];
    
    [_rightBt setFrame:CGRectMake(CGRectGetWidth(self.frame)-10-textSzie.width, 45 - textSzie.height-3, textSzie.width, textSzie.height)];
    
    //根据文字长度，添加阴影下划线
    int nlength = CGRectGetWidth(_rightBt.frame);
    
    UIImage *imageUnderLine = [UIImage imageNamed:@"topline_dark.png"];
    DragonUIImageView *imgULine = [[DragonUIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)-10-textSzie.width, 43, nlength, imageUnderLine.size.height/2)];
    [imgULine setImage:imageUnderLine];
    [self addSubview:imgULine];
    RELEASE(imgULine);
}

//设置左边图片
- (void)setLeftImg:(UIImage *)img
{
    [_leftImgView setImage:img];
    [_leftImgView setFrame:CGRectMake(15, (45 - img.size.height/2)/2, img.size.width/2, img.size.height/2)];
}

//设置返回按钮图片
- (void)setLeftBtImg:(UIImage *)img
{
    [_backBt setBackgroundImage:img forState:UIControlStateNormal];
    [_backBt setFrame:CGRectMake(10, 45-(img.size.height/2)-7, img.size.width/2, img.size.height/2)];
}

//设置label文字
- (void)setLeftLabelText:(NSString *)text
{
    [_leftLabel setText:text];
    
    [self autoLabelFrame];
}

//设置label文字颜色
- (void)setLeftLabelTextColor:(UIColor *)color
{
    [_leftLabel setTextColor:color];
}

//设置居中文字
- (void)setCenterLabelText:(NSString *)text
{
    [_centerLabel setText:text];
    
    [self autoCenterLabelFrame];
}

- (void)setCenterLabelTextColor:(UIColor *)color
{
    [_centerLabel setTextColor:color];
}


- (void)setCenterLabelFont:(UIFont *)font
{
    [_centerLabel setFont:font];
    
    [self autoCenterLabelFrame];
}

-(void)hideOrShowbackleftLabel:(BOOL)b
{
    _leftLabel.hidden=b;
}

//设置label字体大小
- (void)setLeftLabelFont:(UIFont *)font
{
    [_leftLabel setFont:font];
    
    [self autoLabelFrame];
}

- (void)autoCenterLabelFrame{
    CGSize textSzie = [_centerLabel.text createActiveFrameByfontSize:_centerLabel.font
                                                   constrainedSize:CGSizeMake(1000, 1000)
                                                     lineBreakMode:_leftLabel.lineBreakMode];
    [_centerLabel setTextAlignment:NSTextAlignmentCenter];
    
    [_centerLabel setFrame:CGRectMake(10, 45 - textSzie.height - 4, 300, textSzie.height)];
}

- (void)autoLabelFrame
{
    CGSize textSzie = [_leftLabel.text createActiveFrameByfontSize:_leftLabel.font
                                                   constrainedSize:CGSizeMake(1000, 1000)
                                                     lineBreakMode:_leftLabel.lineBreakMode];
    
    CGFloat frameX = 10;
    if (!self.isTop)
    {
        frameX = _backBt.frame.origin.x + _backBt.frame.size.width + 10;
    }else
    {
        if (_leftImgView.image)
        {
            frameX = _leftImgView.frame.origin.x + _leftImgView.frame.size.width;
        }
        
    }
    [_leftLabel setFrame:CGRectMake(frameX, 45 - textSzie.height - 4, textSzie.width, textSzie.height)];
    
    
    if ([_leftLabel.text length] == 0 && _backBt.hidden == YES)
        return;

//根据文字长度，添加阴影下划线
//    int nlength = [_leftLabel.text sizeWithFont:[_leftLabel font]].width+frameX-10;
    int nlength = frameX + textSzie.width-10;
    
    if (!self.isTop) {
        nlength = nlength -10;
    }
    
    
    UIImage *imageUnderLine = [UIImage imageNamed:@"topline_dark.png"];
    DragonUIImageView *imgULine = [[DragonUIImageView alloc] initWithFrame:CGRectMake(10, 43, nlength, imageUnderLine.size.height/2)];
    [imgULine setImage:imageUnderLine];
    [self addSubview:imgULine];
    RELEASE(imgULine);
}

-(void)hideOrShowbackBt:(BOOL)b
{
    _backBt.hidden = b;
}

//显示隐藏右视图
-(void)hideOrShowRightView:(BOOL)b
{
    [self viewWithTag:-1].hidden=b;
}

-(DragonUILabel *)_leftLabel
{
    return _leftLabel;
}


@end
