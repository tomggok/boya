//
//  Dragon_Cell.h
//  ShangJiaoYuXin
//
//  Created by zhangchao on 13-5-9.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dragon_UILabel.h"

//自定义cell
@interface BoyaCustomCell : UITableViewCell

-(void)setContent:(id)data indexPath:(NSIndexPath *)indexPath tbv:(UITableView *)tbv;

//初始化固定的控件
-(void)initFixedView;

@end
