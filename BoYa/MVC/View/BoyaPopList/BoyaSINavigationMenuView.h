//
//  SINavigationMenuView.h
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoyaSIMenuTable.h"
#import "BoyaSIMenuButton.h"
#import "Dragon_ViewSignal.h"

@protocol BoyaSINavigationMenuDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSUInteger)index;

@end

@interface BoyaSINavigationMenuView : UIView <BoyaSIMenuDelegate,BoyaSINavigationMenuDelegate>

AS_SIGNAL(SHOW)       //显示消息
AS_SIGNAL(HIDE)       //隐藏消息
AS_SIGNAL(SELECT)       //选中消息

@property (nonatomic, assign) id <BoyaSINavigationMenuDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) BoyaSIMenuButton *menuButton;
@property (nonatomic, strong) BoyaSIMenuTable *table;

- (id)initWithFrame:(CGRect)frame title:(NSString *)title;
- (void)displayMenuInView:(UIView *)view;
- (void)onShowMenu;
- (void)onHideMenu;
- (void)didBackgroundTap;
@end
