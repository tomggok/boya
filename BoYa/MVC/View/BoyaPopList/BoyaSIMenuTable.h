//
//  SAMenuTable.h
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BoyaSIMenuDelegate <NSObject>
- (void)didBackgroundTap;
- (void)didSelectItemAtIndex:(NSUInteger)index;
-(void)hideSucess;//已经隐藏
@end

@interface BoyaSIMenuTable : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id <BoyaSIMenuDelegate> menuDelegate;
@property (nonatomic, strong) UITableView *table;
@property (nonatomic,assign) BOOL _b_isAnimating;//是否正在show或者hiden的动画中

- (id)initWithFrame:(CGRect)frame items:(NSMutableArray *)items;
- (void)show;
- (void)hide;

@end
