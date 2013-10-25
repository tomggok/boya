//
//  BoyaSiteCommentModel.h
//  BoYa
//
//  Created by zhangchao on 13-6-1.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_JSONReflection.h"

@interface BoyaSiteCommentModel : DragonJSONReflection

@property (nonatomic, retain)NSString *Com_content;//
@property (nonatomic, retain)NSString *Com_id;
@property (nonatomic, retain)NSString *Com_star;
@property (nonatomic, retain)NSString *Com_time;
@property (nonatomic, retain)NSString *Com_type;//
@property (nonatomic, retain)NSString *Member_id;
@property (nonatomic, retain)NSString *Member_name;
@property (nonatomic, retain)NSString *Place_id;
@property (nonatomic, retain)NSString *isshow;//
@property (nonatomic, retain)NSString *orderid;

@end
