//
//  NSObject+DragonDatabase.h
//  DragonFramework
//
//  Created by NewM on 13-4-12.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dragon_Database.h"
@interface NSObject (DragonDatabase)

@property (nonatomic, readonly)DragonDatabase *DB;

+ (DragonDatabase *)DB;

- (NSString *)tableName;
+ (NSString *)tableName;
@end
