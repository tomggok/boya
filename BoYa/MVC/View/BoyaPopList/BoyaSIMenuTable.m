//
//  SAMenuTable.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "BoyaSIMenuTable.h"
#import "BoyaSIMenuCell.h"
#import "BoyaSIMenuConfiguration.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Extension.h"
#import "BoyaSICellSelection.h"
#import "UITableView+property.h"
#import "BoyaSINavigationMenuView.h"
#import "UITableView+property.h"

@interface BoyaSIMenuTable () {
    CGRect endFrame;
    CGRect startFrame;
    NSIndexPath *currentIndexPath;
}
@property (nonatomic, strong) NSArray *items;
@end

@implementation BoyaSIMenuTable

@synthesize items,table,menuDelegate,_b_isAnimating;

- (id)initWithFrame:(CGRect)frame items:(NSMutableArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        self.items = [NSMutableArray arrayWithArray:items];
        
        self.layer.backgroundColor = [UIColor color:[BoyaSIMenuConfiguration mainColor] withAlpha:0.0].CGColor;
        self.clipsToBounds = YES;
        
        endFrame = self.bounds;
        startFrame = endFrame;
        startFrame.origin.y -= self.items.count*[BoyaSIMenuConfiguration itemCellHeight];
        
        self.table = [[UITableView alloc] initWithFrame:startFrame style:UITableViewStylePlain];
        self.table.delegate = self;
        self.table.dataSource = self;
        self.table.backgroundColor = [UIColor clearColor];
        self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.table._cellH=kH_cellDefault-10;
        
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.table.bounds.size.height, [BoyaSIMenuConfiguration menuWidth], self.table.bounds.size.height)];
        header.backgroundColor = [UIColor color:[BoyaSIMenuConfiguration itemsColor] withAlpha:[BoyaSIMenuConfiguration menuAlpha]];
        [self.table addSubview:header];

    }
    return self;
}

- (void)show
{
    [self addSubview:self.table];
    if (!self.table.tableFooterView) {
        [self addFooter];
    }
    [UIView animateWithDuration:[BoyaSIMenuConfiguration animationDuration] animations:^{
        self.layer.backgroundColor = [UIColor color:[BoyaSIMenuConfiguration mainColor] withAlpha:[BoyaSIMenuConfiguration backgroundAlpha]].CGColor;
        self.table.frame = endFrame;
        self.table.contentOffset = CGPointMake(0, [BoyaSIMenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
            self.table.contentOffset = CGPointMake(0, 0);
            
            _b_isAnimating=NO;
        }];
    }];
}

- (void)hide
{
    [UIView animateWithDuration:[self bounceAnimationDuration] animations:^{
        self.table.contentOffset = CGPointMake(0, [BoyaSIMenuConfiguration bounceOffset]);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:[BoyaSIMenuConfiguration animationDuration] animations:^{
            self.layer.backgroundColor = [UIColor color:[BoyaSIMenuConfiguration mainColor] withAlpha:0.0].CGColor;
            self.table.frame = startFrame;
        } completion:^(BOOL finished) {
//            [self.table deselectRowAtIndexPath:currentIndexPath animated:NO];
            BoyaSIMenuCell *cell = (BoyaSIMenuCell *)[self.table cellForRowAtIndexPath:currentIndexPath];
            [cell setSelected:NO withCompletionBlock:^{

            }];
            currentIndexPath = nil;
            [self removeFooter];
//            [self.table removeFromSuperview];
//            self.table =Nil;
            RELEASEVIEW(self.table);
            [self removeFromSuperview];
            
            ((BoyaSINavigationMenuView *)(self.menuDelegate)).menuButton.isActive=NO;
            
            _b_isAnimating=NO;

        }];
    }];
}

- (float)bounceAnimationDuration
{
    float percentage = 28.57;
    return [BoyaSIMenuConfiguration animationDuration]*percentage/100.0;
}

- (void)addFooter
{
//    DLogInfo(@"%f",self.table.contentSize.height);
    if (self.items.count*self.table._cellH<self.table.frame.size.height) {//避免向上滑动后内容出屏
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [BoyaSIMenuConfiguration menuWidth], self.table.bounds.size.height -self.items.count*self.table._cellH /*(self.items.count * self.table._cellH)*/ )];
        self.table.tableFooterView = footer;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTap:)];
        [footer addGestureRecognizer:tap];
    }
    
    
//    if (table.contentSize.height<self.frame.size.height) {
//        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, table.contentSize.height)];
//    }else{
//        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, table._originFrame.size.height)];
//    }
}

- (void)removeFooter
{
    self.table.tableFooterView = nil;
}

- (void)onBackgroundTap:(id)sender
{
    [self.menuDelegate didBackgroundTap];
}

- (void)dealloc
{
    self.items = nil;
    self.table = nil;
    self.menuDelegate = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return /*[BoyaSIMenuConfiguration itemCellHeight]*/ tableView._cellH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    BoyaSIMenuCell *cell = (BoyaSIMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[BoyaSIMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier tbv:tableView];
    }
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 14.0 ];
    cell.textLabel.font  = myFont;
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block/*避免在hide函数里用到时已被释放*/ currentIndexPath = indexPath;
    
    BoyaSIMenuCell *cell = (BoyaSIMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES withCompletionBlock:^{
        [self.menuDelegate didSelectItemAtIndex:indexPath.row];
    }];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BoyaSIMenuCell *cell = (BoyaSIMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO withCompletionBlock:^{

    }];
}



@end
