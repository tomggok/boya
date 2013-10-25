//
//  BoyaButtonView.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoyaButtonView : UIView{
    DragonUIButton *signBt;
}

@property (nonatomic, retain)NSString *btString;
@property (nonatomic, assign)CGFloat textFont;
@property (nonatomic, retain)NSString *addSignal;
@property (nonatomic, assign)NSInteger btTag;

- (id)initWithFrame:(CGRect)frame textFont:(CGFloat)textFont title:(NSString *)title signal:(NSString *)signalName;
- (void)setButtonImg:(NSString *)imgNormal imgHighlighted:(NSString *)imgHighlighted;

@end
