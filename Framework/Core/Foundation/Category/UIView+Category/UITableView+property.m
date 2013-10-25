//
//  UITableView+CellH.m
//  ShangJiaoYuXin
//
//  Created by zhangchao on 13-5-7.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "UITableView+property.h"
#import <objc/runtime.h>

@implementation UITableView (property)

@dynamic _cellH,_b_ifOpen,_i_didSection,_i_endSection,_selectIndex_now,_selectIndex_last,_muA_differHeightCellView,_b_isNeedResizeCell;

static char _c_cellH;
-(CGFloat)_cellH
{    
    return [objc_getAssociatedObject(self, &_c_cellH) floatValue];
    
}
-(void)set_cellH:(CGFloat)f
{
    objc_setAssociatedObject(self, &_c_cellH, [NSNumber numberWithFloat:f], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char _c_b_ifOpen;
-(BOOL)_b_ifOpen
{
    return [objc_getAssociatedObject(self, &_c_b_ifOpen) boolValue];
    
}
-(void)set_b_ifOpen:(BOOL)b
{
    objc_setAssociatedObject(self, &_c_b_ifOpen, [NSNumber numberWithBool:b], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char _c_i_didSection;
-(NSInteger)_i_didSection
{
    return [objc_getAssociatedObject(self, &_c_i_didSection) integerValue];
    
}
-(void)set_i_didSection:(NSInteger)i
{
    objc_setAssociatedObject(self, &_c_i_didSection, [NSNumber numberWithInteger:i], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char _c_i_endSection;
-(NSInteger)_i_endSection
{
    return [objc_getAssociatedObject(self, &_c_i_endSection) integerValue];
    
}
-(void)set_i_endSection:(NSInteger)i
{
    objc_setAssociatedObject(self, &_c_i_endSection, [NSNumber numberWithInteger:i], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char _c_selectIndex_now;
-(NSIndexPath *)_selectIndex_now
{
    return objc_getAssociatedObject(self, &_c_selectIndex_now);
    
}
-(void)set_selectIndex_now:(NSIndexPath *)index
{
    objc_setAssociatedObject(self, &_c_selectIndex_now, index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char _c_selectIndex_last;
-(NSIndexPath *)_selectIndex_last
{
    return objc_getAssociatedObject(self, &_c_selectIndex_last);
    
}
-(void)set_selectIndex_last:(NSIndexPath *)index
{
    objc_setAssociatedObject(self, &_c_selectIndex_last, index, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char _c_muA_differHeightCellView;
-(NSMutableArray *)_muA_differHeightCellView
{
    return objc_getAssociatedObject(self, &_c_muA_differHeightCellView);
    
}
-(void)set_muA_differHeightCellView:(NSMutableArray *)muA
{
    objc_setAssociatedObject(self, &_c_muA_differHeightCellView, muA, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static char _c_b_isNeedResizeCell;
-(BOOL)_b_isNeedResizeCell
{
    return [objc_getAssociatedObject(self, &_c_b_isNeedResizeCell) boolValue];
    
}
-(void)set_b_isNeedResizeCell:(BOOL)b
{
    objc_setAssociatedObject(self, &_c_b_isNeedResizeCell, [NSNumber numberWithBool:b], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark-选中section后展开或收缩cell
- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert/*第一次是否插入或删除cell*/ nextDo:(BOOL)nextDoInsert/*下次是否插入或删除cell*/ dataSourceCount:(NSInteger)dataSourceCount/*总section数量*/ firstDoInsertCellNums:(NSInteger)firstDoInsertCellNums/*第一次要插入或删除的cell*/ nextDoInsertCellNums:(NSInteger)nextDoInsertCellNums/*第2次要插入或删除的cell*/{
    [self beginUpdates];
    self._b_ifOpen = firstDoInsert;
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    
    for (int i=0; i<firstDoInsertCellNums; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self._i_didSection];
        [rowToInsert addObject:indexPath];
    }
    
    if (!self._b_ifOpen) {
        self._i_didSection = -1;
        [self deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }else{
        [self insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationFade];
    }
    [rowToInsert release];
    [self endUpdates];
    
    if (nextDoInsert) {//下次插入cell
        self._i_didSection = self._i_endSection;
        [self didSelectCellRowFirstDo:YES nextDo:NO dataSourceCount:dataSourceCount firstDoInsertCellNums:nextDoInsertCellNums nextDoInsertCellNums:0];
    }
    [self scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark-刷新section
- (void)reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0){
    NSRange range = NSMakeRange(section, 1);
    
    NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
    
    [self reloadSections:sectionToReload withRowAnimation:animation];
}

//-(void)dealloc
//{
//    DLogInfo(@"%d",self._muA_differHeightCellView.retainCount);
//    [self._muA_differHeightCellView release];
////    self._muA_differHeightCellView=Nil;
//    [super dealloc];
//}


@end