//
//  DragonDatabase.h
//  DragonFramework
//
//  Created by NewM on 13-4-8.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject+DragonProperty.h"

#import "FMDatabase.h"

@class DragonDatabase;

typedef DragonDatabase *(^DragonDataBaseBlock)(void);
typedef DragonDatabase *(^DragonDataBaseBlockN)(id key,...);
typedef DragonDatabase *(^DragonDataBaseBlockU)(NSUInteger val);


#undef DBPATH
#define DBPATH  @"Database"

@interface DragonDatabase : NSObject
{
    BOOL                    _autoOptimize;
    BOOL                    _batch;
    NSUInteger              _identifier;
    
    NSString                *_filePath;
    FMDatabase              *_database;
    
    NSMutableArray          *_select;
    BOOL                    _distinct;
    NSMutableArray          *_from;//保存数据库里所有的表名
    NSMutableArray          *_where;
    NSMutableArray          *_like;
    NSMutableArray          *_groupby;
    NSMutableArray          *_having;
    NSMutableArray          *_keys;
    NSUInteger              _limit;
    NSUInteger              _offset;
    NSMutableArray          *_orderby;
    NSMutableDictionary     *_set;//保存要插入的数据的键值
    
    NSMutableArray          *_resultArray;
    NSUInteger              _resultCount;
    NSUInteger              _lastInsertID;
    BOOL                    _lastSucceed;
    
    NSMutableArray          *_table;
    NSMutableArray          *_field;//保存每个表里的所有字段信息(字典)
    NSMutableArray          *_index;
    
    NSMutableArray          *_classType;
    NSMutableArray          *_associate;
    NSMutableArray          *_has;
}

@property (nonatomic, assign)BOOL                       autoOptimize;
@property (nonatomic, retain)NSString                   *filePath;
@property (nonatomic, readonly)NSUInteger               total;
@property (nonatomic, readonly)BOOL                     ready;
@property (nonatomic, readonly)NSUInteger               identifier;

@property (nonatomic, readonly)DragonDataBaseBlockN     TABLE;
@property (nonatomic, readonly)DragonDataBaseBlockN     FIELD;
@property (nonatomic, readonly)DragonDataBaseBlockN     FIELD_WITH_SIZE;
@property (nonatomic, readonly)DragonDataBaseBlock      UNSIGNED;
@property (nonatomic, readonly)DragonDataBaseBlock      NOT_NULL;
@property (nonatomic, readonly)DragonDataBaseBlock      PRIMARY_KEY;
@property (nonatomic, readonly)DragonDataBaseBlock      AUTO_INREMENT;
@property (nonatomic, readonly)DragonDataBaseBlock      DEFAULT_ZERO;
@property (nonatomic, readonly)DragonDataBaseBlock      DEFAULT_NULL;
@property (nonatomic, readonly)DragonDataBaseBlockN     DEFAULT;
@property (nonatomic, readonly)DragonDataBaseBlock      UNIQUE;
@property (nonatomic, readonly)DragonDataBaseBlock      CREATE_IF_NOT_EXISTS;

@property (nonatomic, readonly)DragonDataBaseBlockN     INDEX_ON;

@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_MAX;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_MAX_ALIAS;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_MIN;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_MIN_ALIAS;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_AVG;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_AVG_ALIAS;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_SUM;
@property (nonatomic, readonly)DragonDataBaseBlockN     SELECT_SUM_ALIAS;

@property (nonatomic, readonly)DragonDataBaseBlock      DISTINCT;
@property (nonatomic, readonly)DragonDataBaseBlockN     FROM;

@property (nonatomic, readonly)DragonDataBaseBlockN     WHERE;
@property (nonatomic, readonly)DragonDataBaseBlockN     OR_WHERE;

@property (nonatomic, readonly)DragonDataBaseBlockN     WHERE_IN;
@property (nonatomic, readonly)DragonDataBaseBlockN     OR_WHERE_IN;
@property (nonatomic, readonly)DragonDataBaseBlockN     WHERE_NOT_IN;
@property (nonatomic, readonly)DragonDataBaseBlockN     OR_WHERE_NOT_IN;

@property (nonatomic, readonly)DragonDataBaseBlockN     LIKE;
@property (nonatomic, readonly)DragonDataBaseBlockN     NOT_LIKE;
@property (nonatomic, readonly)DragonDataBaseBlockN     OR_LIKE;
@property (nonatomic, readonly)DragonDataBaseBlockN     OR_NOT_LIKE;

@property (nonatomic, readonly)DragonDataBaseBlockN     GROUP_BY;

@property (nonatomic, readonly)DragonDataBaseBlockN     HAVING;
@property (nonatomic, readonly)DragonDataBaseBlockN     OR_HAVING;

@property (nonatomic, readonly)DragonDataBaseBlockN     ORDER_ASC_BY;
@property (nonatomic, readonly)DragonDataBaseBlockN     ORDER_DESC_BY;
@property (nonatomic, readonly)DragonDataBaseBlockN     ORDER_RAND_BY;
@property (nonatomic, readonly)DragonDataBaseBlockN     ORDER_BY;

@property (nonatomic, readonly)DragonDataBaseBlockU     LIMIT;
@property (nonatomic, readonly)DragonDataBaseBlockU     OFFSET;

@property (nonatomic, readonly)DragonDataBaseBlockN     SET;
@property (nonatomic, readonly)DragonDataBaseBlockN     SET_NULL;

@property (nonatomic, readonly)DragonDataBaseBlock      GET;
@property (nonatomic, readonly)DragonDataBaseBlock      COUNT;

@property (nonatomic, readonly)DragonDataBaseBlock      INSERT;
@property (nonatomic, readonly)DragonDataBaseBlock      UPDATE;
@property (nonatomic, readonly)DragonDataBaseBlock      EMPTY;
@property (nonatomic, readonly)DragonDataBaseBlock      TRUNCATE;
@property (nonatomic, readonly)DragonDataBaseBlock      DELETE;
@property (nonatomic, readonly)DragonDataBaseBlock      DROP;

@property (nonatomic, readonly)DragonDataBaseBlock      BATCH_BEGIN;
@property (nonatomic, readonly)DragonDataBaseBlock      BATCH_END;

@property (nonatomic, readonly)DragonDataBaseBlockN     CLASS_TYPE;
@property (nonatomic, readonly)DragonDataBaseBlockN     ASSOCIATE;
@property (nonatomic, readonly)DragonDataBaseBlockN     HAS;

@property (nonatomic, readonly)NSArray                  *resultArray;
@property (nonatomic, readonly)NSUInteger               resultCount;
@property (nonatomic, readonly)NSInteger                inserID;
@property (nonatomic, readonly)BOOL                     succeed;

+ (BOOL)openSharedDatabase:(NSString *)path;
+ (BOOL)existsSharedDatabase:(NSString *)path;
+ (void)closeSharedDatabase;

+ (void)setSharedDatabase:(DragonDatabase *)db;
+ (DragonDatabase *)sharedDatabase;

- (id)initWithPath:(NSString *)path;

+ (BOOL)exists:(NSString *)path;
- (BOOL)open:(NSString *)path;
- (void)close;
- (void)clearState;

+ (NSString *)fieldNameForIdentifier:(NSString *)identifier;
+ (NSString *)tableNameForClass:(Class)clazz;

- (Class)classType;

- (NSArray *)associateObjects;
- (NSArray *)associateObjectsFor:(Class)clazz;

- (NSArray *)hasObjects;
- (NSArray *)hasObjectsFor:(Class)clazz;

- (void)__internalResetCreate;
- (void)__internalResetSelect;
- (void)__internalResetWrite;
- (void)__internalResetResult;


@end
