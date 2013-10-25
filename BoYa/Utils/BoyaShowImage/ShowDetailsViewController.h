//
//  ShowDetailsViewController.h
//  微视角
//
//  Created by apple on 13-1-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASImageScrollView.h"

@class MainViewController;

    //展示细节展示图的控制器,与UIViewController+KNSemiModal.h一起用
@interface ShowDetailsViewController : UIViewController <UIGestureRecognizerDelegate,UIScrollViewDelegate>
{
    UIImage *_img;
}

//@property (nonatomic,retain) DragonUIImageView *_imgV;
//@property (nonatomic,retain) DragonUIScrollView *_scrollV;
@property (nonatomic,retain) ASImageScrollView *_scrollV;

-(id)initWithImg:(UIImage *)img;
-(void)dismissSemiModalView;

@end
