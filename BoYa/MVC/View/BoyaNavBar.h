//
//  BoyaNavBar.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_UINavigationBar.h"

@interface BoyaNavBar : DragonUINavigationBar
{
    DragonUILabel *_leftLabel;
    DragonUILabel *_centerLabel;
    DragonUIImageView *_leftImgView;
    DragonUIButton * rightBt;
}

@property (nonatomic,retain)     DragonUILabel *_leftLabel;
@property (nonatomic,retain)     DragonUILabel *_centerLabel;
@property (nonatomic,retain)     DragonUIButton *rightBt;

//设置label文字
- (void)setLeftLabelText:(NSString *)text;

//设置label字体大小
- (void)setLeftLabelFont:(UIFont *)font;

//设置左边图片
- (void)setLeftImg:(UIImage *)img;

-(void)hideOrShowbackleftLabel:(BOOL)b;//隐藏label

-(void)hideOrShowbackBt:(BOOL)b;//隐藏backbt

-(void)hideOrShowRightView:(BOOL)b;

-(DragonUILabel *)_leftLabel;

- (void)setLeftLabelTextColor:(UIColor *)color;


- (void)setCenterLabelText:(NSString *)text;
- (void)setCenterLabelTextColor:(UIColor *)color;
- (void)setCenterLabelFont:(UIFont *)font;
- (void)setRightText:(NSString *)rightBtText;
- (void)setRightBt:(NSString *)imgNameNormal hightIMG:(NSString *)imgNameHighLighted;
@end
