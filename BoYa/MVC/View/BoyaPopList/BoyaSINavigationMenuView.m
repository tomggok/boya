//
//  SINavigationMenuView.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "BoyaSINavigationMenuView.h"
#import "QuartzCore/QuartzCore.h"
#import "BoyaSIMenuConfiguration.h"
#import "UIView+DragonViewSignal.h"

@interface BoyaSINavigationMenuView  ()
@property (nonatomic, strong) UIView *menuContainer;
@end

@implementation BoyaSINavigationMenuView

@synthesize items,menuButton,menuContainer,table,delegate;

DEF_SIGNAL(SHOW)       
DEF_SIGNAL(HIDE)
DEF_SIGNAL(SELECT)

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.delegate=self;
        self.menuButton = [[BoyaSIMenuButton alloc] initWithFrame:/*frame*/ CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(didBackgroundTap)];
//        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;
}

#pragma mark -
#pragma mark Actions
- (void)onHandleMenuTap:(id)sender
{
    if (self.menuButton.isActive) {
//        [self onShowMenu];
        [self sendViewSignal:[BoyaSINavigationMenuView SHOW] withObject:Nil from:self target:Nil];

    } else {
//        [self onHideMenu];
        [self sendViewSignal:[BoyaSINavigationMenuView HIDE] withObject:Nil from:self target:Nil];

    }
}

- (void)onShowMenu
{
    if (self.table._b_isAnimating) {
        return;
    }
//    if (!self.table)
    {
//        UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
//        CGRect frame = mainWindow.frame;
//        frame.origin.y += self.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
        
        self.table = [[[BoyaSIMenuTable alloc] initWithFrame:/*self.menuContainer.frame*/ CGRectMake(self.menuContainer.frame.origin.x, self.frame.origin.y+self.frame.size.height, self.menuContainer.frame.size.width, self.menuContainer.frame.size.height- self.frame.origin.y-self.frame.size.height+5) items:self.items] autorelease];
        self.table.menuDelegate = self;

    }
//    else{
//        [self.table.table reloadData];
//    }
    
    self.table._b_isAnimating=YES;
    [self.menuContainer addSubview:self.table];
    [self rotateArrow:M_PI];
    [self.table show];
}

- (void)onHideMenu
{
    if (self.table._b_isAnimating) {
        return;
    }
    
    self.table._b_isAnimating=YES;
    [self rotateArrow:0];
    [self.table hide];

}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:[BoyaSIMenuConfiguration animationDuration] delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -
#pragma mark Delegate methods
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
//    [self.delegate didSelectItemAtIndex:index];

    [self sendViewSignal:[BoyaSINavigationMenuView SELECT] withObject:[NSNumber numberWithInt:index] from:self target:Nil];
}

- (void)didBackgroundTap
{
    self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    self.items = nil;
    self.menuButton = nil;
    self.menuContainer = nil;
}

@end
