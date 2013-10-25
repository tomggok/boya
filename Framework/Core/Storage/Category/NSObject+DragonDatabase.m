//
//  NSObject+DragonDatabase.m
//  DragonFramework
//
//  Created by NewM on 13-4-12.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "NSObject+DragonDatabase.h"

@implementation NSObject (DragonDatabase)

+ (DragonDatabase *)DB
{
    DragonDatabase *db = [DragonDatabase sharedDatabase];
    
    if (!db) {
        NSBundle * bundle = [NSBundle mainBundle];
		NSString * bundleName = [bundle objectForInfoDictionaryKey:@"CFBundleName"];//项目名
		if ( bundleName )
		{
			NSString * dbName = [NSString stringWithFormat:@"%@.db", bundleName];
			BOOL succeed = [DragonDatabase openSharedDatabase:dbName];
			if ( succeed )
			{
				db = [DragonDatabase sharedDatabase];
			}
		}
        
		if ( db )
		{
			[db clearState];
		}
    }
    return db;
}

- (DragonDatabase *)DB
{
    return [NSObject DB];
}

- (NSString *)tableName
{
    return [[self class] tableName];
}

+ (NSString *)tableName
{
    return [DragonDatabase tableNameForClass:self];
}
@end
