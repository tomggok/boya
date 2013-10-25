//
//  BoyaSiteCommentModel.m
//  BoYa
//
//  Created by zhangchao on 13-6-1.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "BoyaSiteCommentModel.h"

@implementation BoyaSiteCommentModel

@synthesize Place_id,Com_content,Com_id,Com_star,Com_time,Com_type,isshow,Member_id,Member_name,orderid;

- (void)dealloc
{
    RELEASEOBJ(Place_id);
    RELEASEOBJ(Com_content);
    RELEASEOBJ(Com_id);
    RELEASEOBJ(Com_star);
    RELEASEOBJ(Com_time);
    RELEASEOBJ(Com_type);
    RELEASEOBJ(isshow);
    RELEASEOBJ(Member_id);
    RELEASEOBJ(Member_name);
    RELEASEOBJ(orderid);
    
    [super dealloc];
}

@end
