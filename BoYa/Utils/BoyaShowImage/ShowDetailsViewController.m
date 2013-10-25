//
//  ShowDetailsViewController.m
//
//  Created by apple on 13-1-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ShowDetailsViewController.h"


@interface ShowDetailsViewController ()

@end

@implementation ShowDetailsViewController

@synthesize _scrollV;


-(id)initWithImg:(UIImage *)img
{
    if (self=[super init]) {
//        if (!_imgV) {
//            _imgV=[[DragonUIImageView alloc]initWithFrame:CGRectMake(0, 0,0,0) backgroundColor:[UIColor clearColor] image:img isAdjustSizeByImgSize:NO userInteractionEnabled:YES masksToBounds:NO cornerRadius:0 borderWidth:0 borderColor:nil superView:nil Alignment:-1 contentMode:UIViewContentModeScaleAspectFit stretchableImageWithLeftCapWidth:-1 topCapHeight:-1];
//            _imgV.tag=-111;
//            
////            [DeBug CreatPinchGeture:self selector:@selector(handlePinchGesture:) addInView:_imgV];
//        }
        
        _img=img;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    
    [self.view setFrame:CGRectMake(0, kH_UINavigationController*-1, screenShows.size.width, screenShows.size.height-kH_UINavigationController*2)];
    self.view.backgroundColor=[UIColor colorWithWhite:0.80 alpha:0];
    self.view.userInteractionEnabled=YES;
    
//    [_imgV setFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    
    {
        _scrollV = [[ASImageScrollView alloc] initWithFrame:self.view.bounds];
        [_scrollV displayImage:_img];
        [self.view addSubview:_scrollV];
        [_scrollV release];
    }
    
    
//    [_imgV release];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

    //检测捏合手势
-(void)handlePinchGesture:(UIPinchGestureRecognizer *)param
{
//    if (param.state==UIGestureRecognizerStateEnded) {
//        _imgV._scale=param.scale;
//        
//    }else if (param.state==UIGestureRecognizerStateBegan&&_imgV._scale!=0) {//第>0次开始触发此事件
//        param.scale=_imgV._scale;
//    }else if (UIGestureRecognizerStateChanged==param.state) {
//    }

//    LogFloat(__FUNCTION__, @"_imgV._scale", _imgV._scale, Nil);

//    if (param.scale!=NAN) {
//        param.view.transform=CGAffineTransformMakeScale(param.scale, param.scale);
//    }

}

-(void)dismissSemiModalView
{

//    [_imgV setFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];

//    [_scrollV setContentSize:_imgV.frame.size];
//    _imgV.center=_scrollV.center;
    _scrollV.maximumZoomScale=3;
    _scrollV.minimumZoomScale=2;
    _scrollV.zoomScale=1;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark- UIScrollViewDelegate
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
//	return _imgV;
//}

-(void)dealloc
{
//    [_imgV removeFromSuperview];
//    _imgV=Nil;
    
    [_scrollV removeFromSuperview];
    _scrollV=Nil;
    
    [super dealloc];
}

@end
