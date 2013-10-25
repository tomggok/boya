//
//  UITableView+CellH.h
//  ShangJiaoYuXin
//
//  Created by zhangchao on 13-5-7.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (property)//tbv动态属性

@property (nonatomic,assign) CGFloat _cellH;//cell高
@property (nonatomic,assign) NSInteger _i_endSection/*上次被选中的section*/,_i_didSection/*本次被选中的section*/;
@property (nonatomic,assign) BOOL _b_ifOpen/*本次操作是展开还是收缩tbv*/,_b_isNeedResizeCell/*是否需要重新计算cell的frame*/;
@property (nonatomic,assign) NSIndexPath *_selectIndex_now/*当前被选中的cell的IndexPath*/,*_selectIndex_last/*上次被选中的cell的IndexPath*/;
@property (nonatomic,assign) NSMutableArray *_muA_differHeightCellView/*装不同高度的cell的view,下标与tbv的indexPath.row对应*/;

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert/*本次是否插入cell*/ nextDo:(BOOL)nextDoInsert/*下次是否插入cell*/ dataSourceCount:(NSInteger)dataSourceCount/*总section数量*/ firstDoInsertCellNums:(NSInteger)firstDoInsertCellNums/*第一次要插入或删除的cell*/ nextDoInsertCellNums:(NSInteger)nextDoInsertCellNums/*第2次要插入或删除的cell*/;

- (void)reloadSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
@end
