//
//  BoyaInputView.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaInputView.h"
#import "BoyaParameter.h"

@implementation BoyaInputView
@synthesize inputViewType = _inputViewType;
@synthesize imgName = _imgName;
@synthesize placeText = _placeText;
@synthesize fieldTag = _fieldTag;
@synthesize inputText = _inputText;
@synthesize secureTextEntry = _secureTextEntry;

DEF_SIGNAL(SJINPUTFIELD)

- (void)dealloc
{
    RELEASEOBJ(_inputText)
    RELEASEOBJ(_imgName)
    RELEASEOBJ(_placeText)
    RELEASEVIEW(nameImgView)
    RELEASEVIEW(nameField)
    RELEASEVIEW(nameBackImgView)
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame placeText:@"" img:@"" fieldTag:0];
}

- (id)initWithFrame:(CGRect)frame placeText:(NSString *)placeText img:(NSString *)imgName fieldTag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        
        nameBackImgView = [[DragonUIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                              CGRectGetWidth(frame),
                                                                              CGRectGetHeight(frame))];
        
        nameImg = [UIImage imageNamed:imgName];
        
        nameImgView = [[DragonUIImageView alloc] initWithFrame:CGRectMake(9,
                                                                          (CGRectGetHeight(nameBackImgView.frame) - nameImg.size.height/2)/2,
                                                                          nameImg.size.width/2,
                                                                          nameImg.size.height/2)];
        
        nameField = [[DragonUITextField alloc] initWithFrame:CGRectZero];
        [nameField setReturnKeyType:UIReturnKeyDone];
        
        self.placeText = placeText;
        self.imgName = imgName;
        self.fieldTag = tag;
        self.tag = tag;
        
        
    }
    return self;
}
- (BOOL)secureTextEntry
{
    return nameField.secureTextEntry;
}
- (void)setSecureTextEntry:(BOOL)secureTextEntry
{
    _secureTextEntry = secureTextEntry;
    [nameField setSecureTextEntry:_secureTextEntry];
}
//设置input最长文字
- (void)setFieldMaxLeght:(NSInteger)maxLeght
{
    [nameField setMaxLength:maxLeght];
}

- (NSString *)inputText
{
    return nameField.text;
}
//设置输入框文字
- (void)setInputText:(NSString *)inputText
{
    nameField.text = inputText;
    [_inputText release];
    _inputText = [inputText retain];
}

//设置默认文字
- (void)setPlaceText:(NSString *)placeText
{
    [_placeText release];
    _placeText = [placeText retain];
    
    [self addInputView:placeText img:@"" fieldTag:0];
}
//设置前面图片名字
- (void)setImgName:(NSString *)imgName
{
    if (_imgName == imgName)
    {
        return;
    }
    [_imgName release];
    _imgName = [imgName retain];
    
    if (_imgName && _imgName.length > 0)
    {
        [self setInputViewType:1];
    }else
    {
        [self setInputViewType:2];
    }
    
    [self addInputView:@"" img:imgName fieldTag:0];
}
//设置tag
- (void)setFieldTag:(NSInteger)tag
{
    _fieldTag = tag;
    
    [self addInputView:@"" img:@"" fieldTag:tag];
}
//设置input类型
- (void)setInputViewText:(NSInteger)inputViewType
{
    _inputViewType = inputViewType;
    
    if (inputViewType == 2)
    {
        [nameImgView setHidden:YES];
    }
    
    [self addInputView:@"" img:@"" fieldTag:0];
}


//输入框view
- (CGRect)addInputView:(NSString *)placeText
                   img:(NSString *)imgName
              fieldTag:(NSInteger)tag
{
    
    [nameBackImgView setUserInteractionEnabled:YES];
    [nameBackImgView setImage:[UIImage imageNamed:@"input.png"]];
    [self addSubview:nameBackImgView];
    
    if (imgName && imgName.length)
    {
        nameImg = [UIImage imageNamed:imgName];
    }
    [nameImgView setFrame:CGRectMake(9,
                                     (CGRectGetHeight(nameBackImgView.frame) - nameImg.size.height/2)/2,
                                     nameImg.size.width/2,
                                     nameImg.size.height/2)];
    [nameImgView setImage:nameImg];
    
    float nameFieldFrameX = CGRectGetWidth(nameImgView.frame) + nameImgView.frame.origin.x + 7;
    if (_inputViewType == 2)
    {
        nameFieldFrameX = 8;
    }
    [nameField setFrame:CGRectMake(nameFieldFrameX,
                                   (CGRectGetHeight(nameBackImgView.frame) - (BoyaLOGININPUTPLACEHOLDER + 2))/2,
                                   CGRectGetWidth(nameBackImgView.frame) - (nameFieldFrameX),
                                   BoyaLOGININPUTPLACEHOLDER + 4)];
    
    if (placeText && placeText.length > 0)
    {
        [nameField setPlaceholder:placeText];
    }
    if (tag > 0)
    {
        [nameField setTag:tag];
    }
    
    [nameField setFont:[UIFont systemFontOfSize:BoyaLOGININPUTPLACEHOLDER]];
    
    
    [nameBackImgView addSubview:nameField];
    [nameBackImgView addSubview:nameImgView];
    
    
    return nameBackImgView.frame;
}



@end
