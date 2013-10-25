//
//  Dragon_UITabBarView.m
//  DragonFramework
//
//  Created by NewM on 13-6-7.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_UITabBarView.h"
#import "Dragon_Runtime.h"

@interface DragonUITabBarView ()
{
    BOOL isFirst;//第一次近来
    
    CGFloat _barHeight;//bar的高度
}

@end

@implementation DragonUITabBarView
@synthesize viewControllers = _viewControllers;
@synthesize selectedIndex = _selectedIndex;
@synthesize selectedVC = _selectedVC;
@synthesize tabBar = _tabBar;
@synthesize tabBarHidden = _tabBarHidden;
@synthesize tabBarTransparent = _tabBarTransparent;

DEF_SIGNAL(TABBARSHOULDSELECT)//将要选中
DEF_SIGNAL(TABBARDIDSELCT)//选中

- (void)dealloc
{
    [self removeAllVCView];
    RELEASEOBJ(_tabBar)
    RELEASEVIEW(_transitionView)
    RELEASEDICTARRAYOBJ(_viewControllers);
    [super dealloc];
}

- (void)removeAllVCView
{
    for (int i = 0; i < [_viewControllers count]; i++)
    {
        [self removeViewControllerAtIndex:i];
    }
}

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr reduceHeight:(CGFloat)reduceHeight
{
    
    return [self initWithViewControllers:vcs
                              imageArray:arr
                            reduceHeight:reduceHeight
                               barHeight:kTabBarHeight
                               withClass:[DragonUITabBar class]];
}

- (id)initWithViewControllers:(NSArray *)vcs imageArray:(NSArray *)arr reduceHeight:(CGFloat)reduceHeight barHeight:(CGFloat)barHeight withClass:(Class)clazz
{
    _barHeight = barHeight;
    CGRect mainFrame = MAINFRAME;
    self = [super initWithFrame:mainFrame];
    if (self != nil)
    {
        _viewControllers = [[NSMutableArray arrayWithArray:vcs] retain];
        
        _transitionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.frame) - barHeight)];
        
        CGFloat tabBarY = CGRectGetHeight(self.frame) - barHeight;
        tabBarY -= reduceHeight;
        
        
        _tabBar = [(DragonUITabBar *)[DragonRuntime allocByClass:clazz] initWithFrame:CGRectMake(0, tabBarY, CGRectGetWidth(self.bounds), _barHeight) buttonImages:arr];
        [_tabBar setDelegate:self];
        
        
        [self addSubview:_transitionView];
        [self addSubview:_tabBar];
        
        
        isFirst = YES;
        
        self.selectedIndex = 0;
    }
    return self;
}

- (void)setTabBarTransparent:(BOOL)tabBarTransparent
{
    if (tabBarTransparent)
    {
        _transitionView.frame = self.bounds;
    }else
    {
        _transitionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.frame) - _barHeight);
    }
}

- (void)hideTabBar:(BOOL)isHidden animated:(BOOL)animated
{
    if (isHidden)
    {
        if (self.tabBar.frame.origin.y == self.frame.size.height)
        {
            return;
        }
    }else
    {
        if (self.tabBar.frame.origin.y == self.frame.size.height - _barHeight)
        {
            return;
        }
    }
    
    if (animated)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:.3f];
        if (isHidden)
        {
            CHANGEFRAMEORIGIN(self.tabBar.frame, self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + _barHeight);
        }else
        {
            CHANGEFRAMEORIGIN(self.tabBar.frame, self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - _barHeight);
        }
        [UIView commitAnimations];
    }else
    {
        if (isHidden)
        {
            CHANGEFRAMEORIGIN(self.tabBar.frame, self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + _barHeight);
        }else
        {
            CHANGEFRAMEORIGIN(self.tabBar.frame, self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - _barHeight);
        }
    }
}

- (DragonViewController *)selectedVC
{
    return [_viewControllers objectAtIndex:_selectedIndex];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [self displayViewAtIndex:selectedIndex];
    [_tabBar selectTabAtIndex:selectedIndex];
}

- (void)removeViewControllerAtIndex:(NSUInteger)index
{
    if (index >= [_viewControllers count])
    {
        return;
    }
    
    DragonViewController *vc = [_viewControllers objectAtIndex:index];
    
    [[vc view] removeFromSuperview];
    vc.view = nil;
    //    RELEASEOBJ(vc);
    
    [_viewControllers removeObjectAtIndex:index];
    
    [_tabBar removeTabAtIndex:index];
}

- (void)insertViewController:(UIViewController *)vc withImageDic:(NSDictionary *)dict atIndex:(NSUInteger)index
{
    [_viewControllers insertObject:vc atIndex:index];
    [_tabBar insertTabWithImageDic:dict atIndex:index];
}


- (void)displayViewAtIndex:(NSUInteger)index
{
    DragonViewSignal *singal = [self sendViewSignal:[DragonUITabBarView TABBARSHOULDSELECT] withObject:[_viewControllers objectAtIndex:index]];
    
    if (!singal.boolValue && !isFirst)
    {
        return;
    }else if (isFirst)
    {
        isFirst = NO;
    }
    
    if (_selectedIndex == index && [[_transitionView subviews] count] != 0)
    {
        return;
    }
    
    _selectedIndex = index;
    
    DragonViewController *selectedVC = [_viewControllers objectAtIndex:index];
    
    selectedVC.view.frame = _transitionView.frame;
    if ([selectedVC.view isDescendantOfView:_transitionView])
    {
        [_transitionView bringSubviewToFront:selectedVC.view];
    }else
    {
        [_transitionView addSubview:selectedVC.view];
    }
    
    [self sendViewSignal:[DragonUITabBarView TABBARDIDSELCT] withObject:selectedVC];
}

- (void)handleViewSignal_DragonUITabBar:(DragonViewSignal *)signal
{
    NSNumber *num = (NSNumber *)[signal object];
    if ([signal is:[DragonUITabBar TABBARBUTTON]])
    {
        if (_selectedIndex != [num intValue])
        {
            [self displayViewAtIndex:[num intValue]];
        }
    }
}

@end
