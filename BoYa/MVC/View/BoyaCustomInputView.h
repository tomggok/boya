//
//  inputView.h
//  Yiban
//
//  Created by 周 哲 on 12-11-22.
//
//

#import <UIKit/UIKit.h>
#import "Dragon_UIButton.h"
#import "Dragon_UITableView.h"

#define k_tag_send -1000

//自定义输入框
@interface BoyaCustomInputView : UIView{
    
    DragonUITextView * _textV;
    DragonUIButton * _bt_send;
    UIImageView *_imgV_input_bg;//UITextView的背景框
}

@property (nonatomic,retain)    DragonUITextView * _textV;


- (id)initWithFrame:(CGRect)frame input_bg:(UIImage *)input_bg placeHolder:(NSString *)placeHolder btSignal:(NSString *)btSignal/*发送按钮信号名*/;

@end
