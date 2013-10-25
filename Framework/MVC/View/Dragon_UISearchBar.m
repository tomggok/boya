//
//  Dragon_UISearchBar.m
//  ShangJiaoYuXin
//
//  Created by zhangchao on 13-5-7.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_UISearchBar.h"

@implementation DragonUISearchBar

DEF_SIGNAL(BEGINEDITING) //第一次按下搜索框
DEF_SIGNAL(CANCEL) //取消搜索
DEF_SIGNAL(SEARCH) //按下搜索按钮

-(id)initWithFrame:(CGRect)frame  backgroundColor:(UIColor *)backgroundColor placeholder:(NSString *)placeholder isHideOutBackImg:(BOOL)isHideOutBackImg isHideLeftView:(BOOL)isHideLeftView/*隐藏左边的放大镜*/
{
    if (self=[super initWithFrame:frame]) {
        self.delegate=self;
        self.backgroundColor=backgroundColor;
        self.placeholder=placeholder;
        self.barStyle =UIBarStyleBlackTranslucent;//控件的样式
        self.autocorrectionType = UITextAutocorrectionTypeNo;//对于文本对象自动校正风格
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;//首字母不自动大写
        
        if (isHideOutBackImg) {/*外围背景图是否隐藏*/
            [(UIView *)[[self subviews] objectAtIndex:0] removeFromSuperview];
            
        }
        _isHideLeftView=isHideLeftView;/*是否隐藏左边的视图*/
    }
    return self;
}

//- (void)drawRect:(CGRect)rect
//{
//    UIImage *image = [UIImage imageNamed: @"input.png"];
//    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//}

//自定义背景
-(void)customBackGround:(UIImageView *)imgV
{
    [imgV setFrame:CGRectMake(0, 0, self.bounds.size.width-10, self.frame.size.height-19)];//调整新背景图大小已覆盖 原来 的圆角边框
    imgV.contentMode=UIViewContentModeScaleToFill;
    imgV.tag=-1;
    UIView *segment = [self.subviews objectAtIndex:0];//背景图
    [segment addSubview: imgV];
//    segment.hidden=YES;=lpppp
}

- (void)layoutSubviews {
    
//    for (UIView *subview in self.subviews){//去背景
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
//        {
//            [subview removeFromSuperview];
//            break;
//        }
//        
//    }

//    if (_isHideLeftView)
    {
        UITextField *searchField;
        for(int i = 0; ; i++) {
            if([[self.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) { //conform?
                searchField = [self.subviews objectAtIndex:i];
                break;
            }
        }
        if(!(searchField == nil)) {
            searchField.textColor = [UIColor blackColor];
            {
//            [searchField setFrame:CGRectMake(60, 0, self.frame.size.width-10, self.frame.size.height)];
//            UILabel *lb;
//            for(int i = 0; i < [searchField.subviews count]; i++) {
//                if([[searchField.subviews objectAtIndex:i] isKindOfClass:[UILabel class]]) { //conform?
////                    LogRect(__FUNCTION__, lb.frame);
//                }
//            }
//	[searchField setBackground: [UIImage imageNamed:@"input"] ];
//		[searchField setBorderStyle:UITextBorderStyleRoundedRect];
//		UIImage *image = [UIImage imageNamed: @"esri.png"];
//		UIImageView *iView = [[UIImageView alloc] initWithImage:image];
//		searchField.leftView = iView;
//		[iView release];
            }
           
            if (_isHideLeftView)
            {
                [searchField.leftView removeFromSuperview];
                [searchField.leftView release];
                searchField.leftView=Nil;

            }
         
//            searchField.layer.masksToBounds=NO;
//            searchField.layer.cornerRadius=0;
//            searchField.layer.borderColor=[UIColor clearColor].CGColor;
        }
    }
    
	[super layoutSubviews];
}

//重写函数,改变取消按钮的样式
-(void)addSubview:(UIView *)view
{
    [super addSubview:view];
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *cancelButton = (UIButton *)view;
        cancelButton.tag=-1;
//        cancelButton.backgroundColor=[UIColor clearColor];
//        [cancelButton setFrame:CGRectMake(cancelButton.frame.origin.x, cancelButton.frame.origin.y, cancelButton.frame.size.width-10, cancelButton.frame.size.height)];
        
        UIImage *img=[UIImage imageNamed:@"btn_foot_b.png"];
        
//        UIImageView *imgV=[[UIImageView alloc]initWithImage:img];
//        imgV.contentMode=UIViewContentModeScaleAspectFit;
//        [imgV setFrame:CGRectMake(0, 0, cancelButton.frame.size.width, cancelButton.frame.size.height)];
//        [cancelButton addSubview:imgV];
//        [imgV release];
        
        [cancelButton setBackgroundImage:img forState:UIControlStateNormal];
        [cancelButton setBackgroundImage:img forState:UIControlStateHighlighted];
        [cancelButton setTitle:@"取 消" forState:UIControlStateNormal];
        cancelButton.titleLabel.font=[UIFont systemFontOfSize:13];
        cancelButton.layer.borderColor=[UIColor blackColor].CGColor;
        cancelButton.layer.borderWidth=0.6;
//        [cancelButton setBounds:CGRectMake(0, 0, img.size.width/2, img.size.height/2)];

    }
}


#pragma mark- UISearchBarDelegate
//输入搜索文字时隐藏搜索按钮，清空时显示
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {

    [self sendViewSignal:[DragonUISearchBar BEGINEDITING] withObject:self];

    UIView *segment = [self.subviews objectAtIndex:0];
    [segment setFrame:CGRectMake(segment.frame.origin.x, segment.frame.origin.y, 50, segment.frame.size.height)];
    
    [self setNeedsDisplay];
    
    return YES;
    
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    searchBar.showsScopeBar = NO;
    
//    [searchBar sizeToFit];
    
    [searchBar setShowsCancelButton:NO animated:YES];
    
    return YES;  
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar                    // called when cancel button pressed
{
//    DLogInfo(@"%f",CGRectGetWidth(self.bounds));
//    [self resignFirstResponder];
    
    [self sendViewSignal:[DragonUISearchBar CANCEL] withObject:self];

//    self.text=self.placeholder;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                  // called when keyboard search button pressed
{
    [self sendViewSignal:[DragonUISearchBar SEARCH] withObject:self];
}

@end
