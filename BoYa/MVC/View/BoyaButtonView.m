//
//  BoyaButtonView.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaButtonView.h"
#import "Dragon_CommentMethod.h"

@implementation BoyaButtonView

@synthesize btString = _btString;
@synthesize textFont = _textFont;
@synthesize addSignal = _addSignal;
@synthesize btTag = _btTag;

- (void)dealloc
{
    RELEASEOBJ(_btString);
    RELEASEVIEW(signBt);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    
    return [self initWithFrame:frame textFont:0 title:@"" signal:@""];
}

- (id)initWithFrame:(CGRect)frame textFont:(CGFloat)textFont title:(NSString *)title signal:(NSString *)signalName
{
    self = [super initWithFrame:frame];
    if (self) {
        signBt = [[DragonUIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self addSubview:signBt];
        [self signBtView:textFont title:title signal:signalName];
    }
    return self;
    
}

- (NSInteger)btTag
{
    return signBt.tag;
}

- (void)setBtTag:(NSInteger)btTag
{
    _btTag = btTag;
    signBt.tag = _btTag;
}

- (void)setTextFont:(CGFloat)textFont
{
    _textFont = textFont;
    
    [self signBtView:_textFont title:@"" signal:@""];
}

- (void)setBtString:(NSString *)btString
{
    if (_btString == btString)
    {
        return;
    }
    [_btString release];
    _btString = [btString retain];
    
    [self signBtView:0 title:_btString signal:@""];
    
}

- (void)setAddSignal:(NSString *)addSignal
{
    if (_addSignal == addSignal)
    {
        return;
    }
    [_addSignal release];
    _addSignal = [addSignal retain];
    
    [self signBtView:0 title:@"" signal:_addSignal];
}

//登录按钮
- (void)signBtView:(CGFloat)textFont title:(NSString *)title signal:(NSString *)signalName
{
    if (signalName && signalName.length > 0)
    {
        [signBt addSignal:signalName forControlEvents:UIControlEventTouchUpInside];
    }
    
    [signBt setBackgroundImage:[UIImage imageNamed:@"btn_login_a.png"] forState:UIControlStateNormal];
    [signBt setBackgroundImage:[UIImage imageNamed:@"btn_login_b.png"] forState:UIControlStateHighlighted];
    
    if (title && title.length > 0)
    {
        [signBt setTitle:title];
    }
    
    
    if (textFont > 0)
    {
        [signBt setTitleFont:[UIFont systemFontOfSize:textFont]];
    }
    
    [signBt setTitleShadowColor:[DragonCommentMethod color:155 green:35 blue:0 alpha:1.f]];
    
    
}

//更改按钮背景图
- (void)setButtonImg:(NSString *)imgNormal imgHighlighted:(NSString *)imgHighlighted{
    [signBt setBackgroundImage:[UIImage imageNamed:imgNormal] forState:UIControlStateNormal];
    [signBt setBackgroundImage:[UIImage imageNamed:imgHighlighted] forState:UIControlStateHighlighted];
}

@end
