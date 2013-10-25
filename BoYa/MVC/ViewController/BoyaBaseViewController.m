//
//  BoyaBaseViewController.m
//  BoYa
//
//  Created by Hyde.Xu on 13-5-27.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaBaseViewController.h"
#import "BoyaParameter.h"

@interface BoyaBaseViewController ()

@end

@implementation BoyaBaseViewController

//DEF_SIGNAL(BUTTON_TOUCHED) //bt信号

@synthesize barView = _barView;

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
    
    [self.view setBackgroundColor:[DragonCommentMethod color:107 green:212 blue:216 alpha:1.f]];
    
    CGFloat barHeight = 45;
/*
    UIImage *rightImg = [UIImage imageNamed:@"logo_top.png"];
    DragonUIImageView *rightView = [[DragonUIImageView alloc] initWithFrame:CGRectMake(320-rightImg.size.width/2-11,
                                                                                       (barHeight - rightImg.size.height/2)/2,
                                                                                       rightImg.size.width/2,
                                                                                       rightImg.size.height/2)];
    [rightView setImage:rightImg];
    rightView.tag=-1;
*/    
    _barView = [[BoyaNavBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), barHeight)];
    [_barView setBackgroundColor:[UIColor clearColor]];
    [_barView setLeftBtImg:[UIImage imageNamed:@"arrow_back.png"]];
    [_barView setBackgroundColor:[DragonCommentMethod color:107 green:212 blue:216 alpha:1.f]];
    [_barView setIsTop:YES];
    [_barView setNavi:self.drNavigationController];
    [_barView setLeftLabelFont:[UIFont boldSystemFontOfSize:BoyaHEADERTITLEFONT]];
    [_barView setCenterLabelFont:[UIFont boldSystemFontOfSize:BoyaHEADERTITLEFONT]];
//    [_barView setLeftLabelText:@"登录"];
//    [_barView setRightView:rightView];
    
    [self.view addSubview:_barView];
    
    [self.drNavigationController setDNavBarView:_barView];
    
//    [rightView release];
    
    [self setVCBackAnimation:SWIPESCROLLERBACKTYPE canBackPageNumber:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
