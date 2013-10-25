//
//  Dragon_UILabel.h
//  DragonFramework
//
//  Created by NewM on 13-4-18.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+ReSize.h"

@class DragonUILabel;

typedef DragonUILabel*(^DragonUILabelC)(id key,...);
typedef DragonUILabel*(^DragonUILabelF)(id key,...);
typedef DragonUILabel*(^DragonUILabelI)(id key,...);
typedef DragonUILabel*(^DragonUILabelAI)(id key,...);

@interface DragonUILabel : UILabel
{
    long    _chartSpacing;//字间距
    CGFloat _linesSpacing;//行间距
    NSMutableAttributedString *_str_AttributedString;
    
}

@property (nonatomic, assign)CGFloat linesSpacing;
@property (nonatomic, assign)long    chartSpacing;
@property (nonatomic, assign)BOOL    needCoretext;//是否需要coretext


- (DragonUILabelC)COLOR;//loc,lenght,color
- (DragonUILabelF)FONT;//loc,lenght,size
- (DragonUILabelI)IMG;//name,x,y,width,height
- (DragonUILabelAI)IMGA;//name,loc,width,height
                        //得到字符串中特定范围的字体属性
-(NSDictionary *)getAttributesAtRange:(NSRange)range;

@end
