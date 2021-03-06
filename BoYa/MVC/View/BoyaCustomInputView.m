//
//  inputView.m
//  Yiban
//
//  Created by 周 哲 on 12-11-22.
//
//

#import "BoyaCustomInputView.h"
#import "UIImageView+Init.h"
#import "BoyaParameter.h"
#import "UIView+DragonCategory.h"
#import "UITextView+Property.h"

@implementation BoyaCustomInputView

@synthesize _textV;

- (id)initWithFrame:(CGRect)frame input_bg:(UIImage *)input_bg placeHolder:(NSString *)placeHolder btSignal:(NSString *)btSignal/*发送按钮信号名*/
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor clearColor];
        self.userInteractionEnabled=YES;
        
        _imgV_input_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) backgroundColor:[UIColor whiteColor] image:input_bg isAdjustSizeByImgSize:NO userInteractionEnabled:YES masksToBounds:NO cornerRadius:-1 borderWidth:-1 borderColor:Nil superView:self Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
        [_imgV_input_bg release];
        
        _textV = [[DragonUITextView alloc]initWithFrame:CGRectMake(2, 0, _imgV_input_bg.frame.size.width-5, _imgV_input_bg.frame.size.height-4)];
        [_textV setBackgroundColor:[UIColor clearColor]];
        [_textV setPlaceHolder:placeHolder];
        //        _textV.returnKeyType=UIReturnKeySend;
        [_textV setFont:[UIFont systemFontOfSize:14.5]];
        [_imgV_input_bg addSubview:_textV];
        [_textV release];
//        _textV._orign_contentInset=_textV.contentInset;
//        _textV._orign_contentSize=_textV.contentSize;
//        _textV._orign_font=[UIFont systemFontOfSize:13.5];
        //        [_textV addObserver:self forKeyPath:@"contentSize"options:NSKeyValueObservingOptionNew context:nil];//也可以监听contentSize属性
        
        
        {
//            UIImage *img=[UIImage imageNamed:@"btn_foot_a.png"];
//            UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-img.size.width/4, 0, img.size.width/4, img.size.height/4) backgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] image:Nil isAdjustSizeByImgSize:NO userInteractionEnabled:YES masksToBounds:NO cornerRadius:-1 borderWidth:1 borderColor:[UIColor blackColor].CGColor superView:_imgV_input_bg Alignment:1 contentMode:UIViewContentModeScaleAspectFill stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
//            [imgV release];
//            imgV.tag=-1;
            //                imgV.alpha=0.5;
            
            {
//                {
//                    UIImage *img=[UIImage imageNamed:@"icon_reply.png"];
//                    UIImageView *imgV=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-img.size.width/2-5, 0, img.size.width/2, img.size.height/2) backgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:YES masksToBounds:NO cornerRadius:-1 borderWidth:1 borderColor:[UIColor blackColor].CGColor superView:_imgV_input_bg Alignment:1 contentMode:UIViewContentModeScaleAspectFill stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
//                    [imgV release];
//                    imgV.tag=-1;
//                }
                
                if(btSignal){
                    UIImage *img=[UIImage imageNamed:@"btn_foot_a.png"];
                    _bt_send = [[DragonUIButton alloc]initWithFrame:CGRectMake(_imgV_input_bg.frame.size.width-(img.size.width/3), _imgV_input_bg.frame.size.height-img.size.height/3, img.size.width/3, img.size.height/3)];
                    _bt_send._originFrame=CGRectMake(_bt_send.frame.origin.x, _bt_send.frame.origin.y, _bt_send.frame.size.width, _bt_send.frame.size.height);
                    [_bt_send addSignal:btSignal forControlEvents:UIControlEventTouchUpInside];
                    [/*imgV*/ _imgV_input_bg addSubview:_bt_send];
                    [_bt_send release];
                    [_bt_send changePosInSuperViewWithAlignment:1];
                    _bt_send.tag=k_tag_send;
                    _bt_send.backgroundColor=[UIColor clearColor];
                }
               
            }
            
        }
        
    }
    return self;
}

//-(void)layoutSubviews
//{
//    
//    [_imgV_input_bg setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    [_textV setFrame:CGRectMake(2, 0, _imgV_input_bg.frame.size.width-40, _imgV_input_bg.frame.size.height-4)];
//
//    //避免self加高后_bt_send位置变化
//    [_bt_send setFrame:CGRectMake(_bt_send.frame.origin.x, _imgV_input_bg.frame.size.height-_bt_send.frame.size.height, _bt_send.frame.size.width, _bt_send.frame.size.height)];
//    
//    {
//        CGSize size = [[_textV text] sizeWithFont:[_textV font]];
//        
//        // 2. 取出文字的高度
//        int length = size.height;
//        
//        //3. 计算行数
//        int colomNumber = _textV.contentSize.height/length;
//        
//        UIImageView *imgV=(UIImageView *)[_imgV_input_bg viewWithTag:-1];
//        
//        if (colomNumber>1) {
//            [imgV setFrame:CGRectMake(imgV.frame.origin.x, imgV.superview.frame.size.height-imgV.frame.size.height-5, imgV.frame.size.width, imgV.frame.size.height)];
//        }else{
//            [imgV changePosInSuperViewWithAlignment:1];
//        }
//        
//    }
//    
////    [self contentSizeToFit];
//    
//    [super layoutSubviews];
//    
//}

//UITextView内容上下居中
//- (void)contentSizeToFit {
//    if([_textV.text length]>0) {
//        CGSize contentSize = _textV.contentSize;
//        //NSLog(@"w:%f h%f",contentSize.width,contentSize.height);
//        UIEdgeInsets offset;
//        CGSize newSize = contentSize;
//        if(contentSize.height <= _textV.frame.size.height) {
//            CGFloat offsetY = (_textV.frame.size.height - contentSize.height)/2;
//            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0);
//        }
//        else {
////            newSize = _textV.frame.size;
////            offset = UIEdgeInsetsZero;
////            CGFloat fontSize = 13.5+10;
////            while (contentSize.height > _textV.frame.size.height) {
////                [_textV setFont:[UIFont /*fontWithName:@"Helvetica Neue" size:fontSize--*/ systemFontOfSize:fontSize--]];
////                contentSize = _textV.contentSize;
////            }
////            newSize = contentSize;
//////            newSize.width+=20;
////            newSize.height+=20;
//        }
////        [_textV setContentSize:newSize];
////        [_textV setContentInset:offset];
//        
//    }else{
//        [_textV setContentSize:_textV._orign_contentSize];
//        [_textV setContentInset:_textV._orign_contentInset];
//        [_textV setFont:_textV._orign_font];
//
//    }
//}

//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    UITextView *mText = object;
//
//    CGFloat topCorrect = ([mText bounds].size.height - [mText contentSize].height);
//
//    topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
//
//    mText.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};
//
//}

- (void)dealloc{
    [super dealloc];
}


@end
