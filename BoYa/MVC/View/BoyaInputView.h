//
//  BoyaInputView.h
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BoyaInputView : UIView{
    DragonUIImageView *nameBackImgView;
    
    UIImage *nameImg;
    DragonUIImageView *nameImgView;
    
    DragonUITextField *nameField;
}

@property (nonatomic, retain)NSString *placeText;//设置默认文字
@property (nonatomic, retain)NSString *imgName;//设置前面图片名字
@property (nonatomic, assign)NSInteger fieldTag;//设置fieldtag
@property (nonatomic, assign)NSInteger inputViewType;//设置input类型
@property (nonatomic, assign)NSString *inputText;//输入框文字
@property (nonatomic, assign)BOOL secureTextEntry;//设置输入框类型

AS_SIGNAL(SJINPUTFIELD)

//初始化
- (id)initWithFrame:(CGRect)frame placeText:(NSString *)placeText img:(NSString *)imgName fieldTag:(NSInteger)tag;

//设置input最长文字
- (void)setFieldMaxLeght:(NSInteger)maxLeght;

@end
