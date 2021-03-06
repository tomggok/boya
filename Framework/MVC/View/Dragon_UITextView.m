//
//  Dragon_UITextView.m
//  DragonFramework
//
//  Created by NewM on 13-3-28.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_UITextView.h"
#import "UIView+DragonCategory.h"

@interface DragonUITextViewAgent : NSObject<UITextViewDelegate>
{
    DragonUITextView *_target;
}
@property (nonatomic, assign)DragonUITextView *target;

@end

@implementation DragonUITextViewAgent
@synthesize target = _target;

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [_target updatePlaceHolder];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:textView, @"textView", nil];
    
    DragonViewSignal *signal = [_target sendViewSignal:[DragonUITextView TEXTVIEWSHOULDBEGINEDITING] withObject:dict];
    
    RELEASEDICTARRAYOBJ(dict);
    
    if (signal && [signal returnValue]) {
        return signal.boolValue;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [_target updatePlaceHolder];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:textView, @"textView", nil];
    
    [_target sendViewSignal:[DragonUITextView TEXTVIEWDIDBEGINEDITING] withObject:dict];
    
    RELEASEDICTARRAYOBJ(dict);
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [_target updatePlaceHolder];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:textView, @"textView", nil];
    
    DragonViewSignal *signal = [_target sendViewSignal:[DragonUITextView TEXTVIEWSHOULDENDEDITING] withObject:dict];
    
    RELEASEDICTARRAYOBJ(dict);
    
    if (signal && [signal returnValue]) {
        
        
        return signal.boolValue;
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [_target updatePlaceHolder];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:textView, @"textView", nil];
    
    [_target sendViewSignal:[DragonUITextView TEXTVIEWDIDENDEDITING] withObject:dict];
    
    RELEASEDICTARRAYOBJ(dict);
}

- (void)textViewDidChange:(UITextView *)textView
{
    [_target updatePlaceHolder];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:textView, @"textView", nil];
    
    [_target sendViewSignal:[DragonUITextView TEXTVIEWDIDCHANGE] withObject:dict];
    
    RELEASEDICTARRAYOBJ(dict);
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    [_target updatePlaceHolder];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:textView, @"textView", nil];
    
    [_target sendViewSignal:[DragonUITextView TEXTVIEWDIDCHANGESELECTION] withObject:dict];
    
    RELEASEDICTARRAYOBJ(dict);
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *length = [NSString stringWithFormat:@"%d",range.length];
    NSString *location = [NSString stringWithFormat:@"%d", range.location];
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:length,@"length",location, @"location", textView, @"textView", text, @"text", nil];
    
    NSString *_text = [_target.text stringByReplacingCharactersInRange:range withString:text];
    
    if (_target.maxLength > 0 && _text.length > _target.maxLength) {
        DragonViewSignal *signal = [_target sendViewSignal:[DragonUITextView TEXT_OVERFLOW] withObject:userInfo];
        
        if (signal && [signal returnValue]) {
            
            return signal.boolValue;
        }
        
        return YES;
    }
    DragonViewSignal *signal = [_target sendViewSignal:[DragonUITextView TEXTVIEW] withObject:userInfo];
    
    RELEASEOBJ(userInfo);
    if (signal && [signal returnValue]) {
        return signal.boolValue;
    }
    
    return YES;
}

@end


@implementation DragonUITextView
@synthesize placeHolder = _placeHolder,
            placeHolderColor = _placeHolderColor,
            placeHolderLabel = _placeHolderLabel,
            maxLength = _maxLength;
DEF_SIGNAL(TEXTVIEWSHOULDBEGINEDITING)
DEF_SIGNAL(TEXTVIEWSHOULDENDEDITING)
DEF_SIGNAL(TEXTVIEWDIDBEGINEDITING)
DEF_SIGNAL(TEXTVIEWDIDENDEDITING)
DEF_SIGNAL(TEXTVIEW)
DEF_SIGNAL(TEXTVIEWDIDCHANGE)
DEF_SIGNAL(TEXTVIEWDIDCHANGESELECTION)
DEF_SIGNAL(TEXT_OVERFLOW)//文字超长



- (id)init
{
    self = [super init];
    if (self) {
        [self initSelf];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSelf];
    }
    
    return self;
}

- (void)initSelf
{
    RELEASEOBJ(_agent);
    _agent = [[DragonUITextViewAgent alloc] init];
    _agent.target = self;
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
    self.placeHolder = @"";
    self.placeHolderColor = [UIColor grayColor];
    
    _maxLength = 0;
    
    self.delegate = _agent;
    
}

- (void)drawRect:(CGRect)rect
{
    [self updatePlaceHolder];
    [super drawRect:rect];
}

//初始化默认文字
- (void)updatePlaceHolder
{
    if ([_placeHolder length] > 0)
    {
        if (!_placeHolderLabel)
        {
            CGRect labelFrame = CGRectMake(8.f, 8, self.frame.size.width, .0f);
            
            _placeHolderLabel = [[UILabel alloc] initWithFrame:labelFrame];
            _placeHolderLabel.lineBreakMode = UILineBreakModeCharacterWrap;
            _placeHolderLabel.numberOfLines = 1;
            _placeHolderLabel.font = self.font;
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = _placeHolderColor;
            _placeHolderLabel.alpha = .0f;
            _placeHolderLabel.opaque = NO;
            [self addSubview:_placeHolderLabel];
            
        }
        
        _placeHolderLabel.frame = CGRectMake(_placeHolderLabel.frame.origin.x, _placeHolderLabel.frame.origin.y, self.frame.size.width, 0);
        _placeHolderLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        _placeHolderLabel.numberOfLines = 1;
        _placeHolderLabel.text = _placeHolder;
        [_placeHolderLabel sizeToFit];
        [self sendSubviewToBack:_placeHolderLabel];
        
    }
    
    if (_placeHolderLabel)
    {
        _placeHolderLabel.text = _placeHolder;
        [_placeHolderLabel sizeToFit];
        
        if ([_placeHolder length] > 0)
        {
            if ([_placeHolder length] > 0)
            {
                if ([self.text length] == 0)
                {
                    [_placeHolderLabel setAlpha:1.f];
                }else
                {
                    [_placeHolderLabel setAlpha:.0f];
                }
            }
        }
        
    }
    
//    [_placeHolderLabel changePosInSuperViewWithAlignment:1];

}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (!text.length > 0)
    {
        [self updatePlaceHolder];
    }
}

- (BOOL)active
{
    return [self isFirstResponder];
}

- (void)setActive:(BOOL)_active
{
    if (_active)
    {
        [self becomeFirstResponder];
    }else
    {
        [self resignFirstResponder];
    }
}

- (void)dealloc
{
    RELEASEOBJ(_agent);
    RELEASEOBJ(_placeHolderLabel);
    self.placeHolder = nil;
    self.placeHolderColor = nil;
    [super dealloc];
}

#pragma mark - textViewDelete

@end
