//
//  DragonDatabase.m
//  DragonFramework
//
//  Created by NewM on 13-4-8.
//  Copyright (c) 2013年 ZzL. All rights reserved.
//

#import "Dragon_Database.h"
#import "Dragon_Sandbox.h"

@interface DragonDatabase ()

+ (BOOL)isFullPath:(NSString *)path;

- (void)initSelf;
- (NSString *)internalCreateAliasFromTable:(NSString *)name;
- (void)internalSelect:(NSString *)select alias:(NSString *)alias type:(NSString *)type;
- (void)internalWhere:(NSString *)key value:(NSObject *)value type:(NSString *)type;
- (void)internalLike:(NSString *)field match:(NSObject *)match type:(NSString *)type side:(NSString *)side not:(BOOL)not;
- (void)internalHaving:(NSString *)key value:(NSObject *)value type:(NSString *)type;

- (NSString *)internalCompileSelect:(NSString *)override;
- (NSString *)internalCompileCreate:(NSString *)table;
- (NSString *)internalCompileIndex:(NSString *)table;

//create
- (DragonDatabase *)table:(NSString *)name;
- (DragonDatabase *)field:(NSString *)name type:(NSString *)type size:(NSUInteger)size;
- (DragonDatabase *)unsignedType;
- (DragonDatabase *)notNull;
- (DragonDatabase *)primaryKey;
- (DragonDatabase *)autoIncrement;
- (DragonDatabase *)defaultZero;
- (DragonDatabase *)defaultNull;
- (DragonDatabase *)defaultValue:(id)value;
- (BOOL)createTableIfNotExists;
- (BOOL)createTableIfNotExists:(NSString *)table;
- (BOOL)indexTableOn:(NSArray *)fields;
- (BOOL)indexTable:(NSString *)table on:(NSArray *)fields;
- (BOOL)existsTable:(NSString *)table;

//select

- (DragonDatabase *)select:(NSString *)select;
- (DragonDatabase *)selectMax:(NSString *)select;
- (DragonDatabase *)selectMax:(NSString *)select alias:(NSString *)alias;
- (DragonDatabase *)selectMin:(NSString *)select;
- (DragonDatabase *)selectMin:(NSString *)select alias:(NSString *)alias;
- (DragonDatabase *)selectAvg:(NSString *)select;
- (DragonDatabase *)selectAvg:(NSString *)select alias:(NSString *)alias;
- (DragonDatabase *)selectSum:(NSString *)select;
- (DragonDatabase *)selectSum:(NSString *)select alias:(NSString *)alias;

- (DragonDatabase *)distinct:(BOOL)flag;
- (DragonDatabase *)from:(NSString *)from;

- (DragonDatabase *)where:(NSString *)key value:(id)value;
- (DragonDatabase *)orWhere:(NSString *)key value:(id)value;

- (DragonDatabase *)whereIn:(NSString *)key values:(NSArray *)values;
- (DragonDatabase *)orWhereIn:(NSString *)key values:(NSArray *)values;
- (DragonDatabase *)whereNotIn:(NSString *)key values:(NSArray *)values;
- (DragonDatabase *)orWhereNotIn:(NSString *)key values:(NSArray *)values;

- (DragonDatabase *)like:(NSString *)field match:(id)value;
- (DragonDatabase *)notLike:(NSString *)field match:(id)value;
- (DragonDatabase *)orLike:(NSString *)field match:(id)value;
- (DragonDatabase *)orNotLike:(NSString *)field match:(id)value;

- (DragonDatabase *)groupBy:(NSString *)by;

- (DragonDatabase *)having:(NSString *)key value:(id)value;
- (DragonDatabase *)orHaving:(NSString *)key value:(id)value;

- (DragonDatabase *)orderAscendBy:(NSString *)by;
- (DragonDatabase *)orderDescendBy:(NSString *)by;
- (DragonDatabase *)orderRandomBy:(NSString *)by;
- (DragonDatabase *)orderBy:(NSString *)by direction:(NSString *)direction;

- (DragonDatabase *)limit:(NSUInteger)limit;
- (DragonDatabase *)offset:(NSUInteger)offset;

- (DragonDatabase *)classInfo:(id)obj;

//write

- (DragonDatabase *)set:(NSString *)key;
- (DragonDatabase *)set:(NSString *)key value:(id)value;

- (NSArray *)get;
- (NSArray *)get:(NSString *)table;
- (NSArray *)get:(NSString *)table limit:(NSUInteger)limit;
- (NSArray *)get:(NSString *)table limit:(NSUInteger)limit offset:(NSUInteger)offset;

- (NSUInteger)count;
- (NSUInteger)count:(NSString *)table;

- (NSInteger)insert;
- (NSInteger)insert:(NSString *)table;

- (BOOL)update;
- (BOOL)update:(NSString *)table;

- (BOOL)empty;
- (BOOL)empty:(NSString *)table;

- (BOOL)truncate;
- (BOOL)truncate:(NSString *)table;

- (BOOL)delete;
- (BOOL)delete:(NSString *)table;

//active record
- (void)classType:(Class)clazz;
- (void)associate:(NSObject *)obj;

@end

@implementation DragonDatabase

@dynamic autoOptimize,
ready,
total;
@synthesize filePath = _filePath,
identifier = _identifier;

@dynamic TABLE,
FIELD,
FIELD_WITH_SIZE,
UNSIGNED,
NOT_NULL,
PRIMARY_KEY,
AUTO_INREMENT,
DEFAULT_ZERO,
DEFAULT_NULL,
DEFAULT,
UNIQUE,
CREATE_IF_NOT_EXISTS,
INDEX_ON;

@dynamic SELECT,
SELECT_MAX,
SELECT_MAX_ALIAS,
SELECT_MIN,
SELECT_MIN_ALIAS,
SELECT_AVG,
SELECT_AVG_ALIAS,
SELECT_SUM,
SELECT_SUM_ALIAS;

@dynamic DISTINCT,
FROM;

@dynamic WHERE,
OR_WHERE;

@dynamic WHERE_IN,
OR_WHERE_IN,
WHERE_NOT_IN,
OR_WHERE_NOT_IN;

@dynamic LIKE,
NOT_LIKE,
OR_LIKE,
OR_NOT_LIKE;

@dynamic GROUP_BY;

@dynamic HAVING,
OR_HAVING;

@dynamic ORDER_ASC_BY,
ORDER_DESC_BY,
ORDER_RAND_BY,
ORDER_BY;

@dynamic LIMIT,
OFFSET;

@dynamic GET,
COUNT;

@dynamic INSERT,
UPDATE,
EMPTY,
TRUNCATE,
DELETE;

@dynamic BATCH_BEGIN,
BATCH_END;

@dynamic CLASS_TYPE,
ASSOCIATE;

@dynamic resultArray,
resultCount,
inserID,
succeed;

static DragonDatabase *_shareDB = nil;
static NSUInteger      _indentSeed = 1;

- (NSArray *)resultArray
{
    [self __internalResetSelect];
    [self __internalResetWrite];
    [self __internalResetCreate];
    
    return [[[NSMutableArray alloc] initWithArray:_resultArray] autorelease];
}

- (NSUInteger)resultCount
{
    return _resultCount;
}

- (NSInteger)inserID
{
    return _lastInsertID;
}

- (BOOL)succeed
{
    return _lastSucceed;
}

- (NSUInteger)total
{
    return [self count];
}

- (void)initSelf
{
    _select = [[NSMutableArray alloc] init];
    _distinct = NO;
    _from = [[NSMutableArray alloc] init];
    _where = [[NSMutableArray alloc] init];
    _like = [[NSMutableArray alloc] init];
    _groupby = [[NSMutableArray alloc] init];
    _having = [[NSMutableArray alloc] init];
    _keys = [[NSMutableArray alloc] init];
    _limit = 0;
    _offset = 0;
    _orderby = [[NSMutableArray alloc] init];
    _set = [[NSMutableDictionary alloc] init];
    _classType = [[NSMutableArray alloc] init];
    _associate = [[NSMutableArray alloc] init];
    
    _table = [[NSMutableArray alloc] init];
    _field = [[NSMutableArray alloc] init];
    _index = [[NSMutableArray alloc] init];
    
    _resultArray = [[NSMutableArray alloc] init];
    _resultCount = 0;
    
    _identifier = _indentSeed++;
    
    
}

+ (BOOL)openSharedDatabase:(NSString *)path
{
    if (_shareDB) {
        if (_shareDB.ready && [_shareDB.filePath isEqualToString:path])
        {
            return YES;
        }
        
        [_shareDB close];
        RELEASEOBJ(_shareDB);
    }
    
    _shareDB = [[[self class] alloc] initWithPath:path];
    
    if (_shareDB)
    {
        if (!_shareDB.ready) {
            RELEASEOBJ(_shareDB);
        }
    }
    
    return (_shareDB && _shareDB.ready) ? YES : NO;
}

+ (BOOL)existsSharedDatabase:(NSString *)path
{
    return [DragonDatabase exists:path];
}

+ (void)closeSharedDatabase
{
    RELEASEOBJ(_shareDB);
}

+ (void)setSharedDatabase:(DragonDatabase *)db
{
    if(_shareDB != db)
    {
        [db retain];
        
        RELEASEOBJ(_shareDB);
        
        _shareDB = db;
    }
}

+ (DragonDatabase *)sharedDatabase
{
    return _shareDB;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self initSelf];
    }
    return self;
}

- (id)initWithPath:(NSString *)path
{
    self = [super init];
    if(self)
    {
        [self initSelf];
        [self open:path];
    }
    return self;
    
}

- (BOOL)ready
{
    if (!_database)
    {
        return NO;
    }
    
    return _database.open;
}

+ (BOOL)isFullPath:(NSString *)path
{
    if ([[path componentsSeparatedByString:@"/"] count] > 1)
    {
        return YES;
    }
    return NO;
}

+ (NSString *)storePath:(NSString *)path
{
    if ([DragonDatabase isFullPath:path])
    {
        return path;
    }
    
    NSString *fullPath = [NSString stringWithFormat:@"%@/%@/", [DragonSandbox docPath], DBPATH];
    NSString *fullName = [fullPath stringByAppendingString:path];
    return fullName;
}

+ (BOOL)exists:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *fullName = [DragonDatabase storePath:path];
    BOOL isDirectory = NO;
    BOOL returnValue = [manager fileExistsAtPath:fullName isDirectory:&isDirectory];
    
    if (!returnValue || isDirectory)
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)open:(NSString *)path
{
    if (_filePath && [_filePath isEqualToString:path])
    {
        return YES;
    }
    
    [self close];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![DragonDatabase isFullPath:path])
    {
        NSString *fullPath = [NSString stringWithFormat:@"%@/%@/",[DragonSandbox docPath], DBPATH];
        
        if (![manager fileExistsAtPath:fullPath]) {
            BOOL ret = [manager createDirectoryAtPath:fullPath
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:nil];
            if (!ret)
            {
                return NO;
            }
        }
        
    }
    _database = [[FMDatabase alloc] initWithPath:[DragonDatabase storePath:path]];
    if (!_database)
    {
        return NO;
    }
    
    BOOL ret = [_database open];
    if (!ret)
    {
        RELEASEOBJ(_database);
    }
    
    self.filePath = path;
    return YES;
    
}

- (void)close
{
    if (_database) {
        [_database close];
        RELEASEOBJ(_database);
    }
}

- (void)clearState
{
    [self __internalResetCreate];
    [self __internalResetWrite];
    [self __internalResetSelect];
}

- (void)dealloc
{
    RELEASEOBJ(_database);
    RELEASEOBJ(_filePath);
    RELEASEDICTARRAYOBJ(_select);
    RELEASEDICTARRAYOBJ(_from);
    RELEASEDICTARRAYOBJ(_where);
    RELEASEDICTARRAYOBJ(_like);
    RELEASEDICTARRAYOBJ(_groupby);
    RELEASEDICTARRAYOBJ(_having);
    RELEASEDICTARRAYOBJ(_keys);
    RELEASEDICTARRAYOBJ(_orderby);
    RELEASEDICTARRAYOBJ(_set);
    RELEASEDICTARRAYOBJ(_field);
    RELEASEDICTARRAYOBJ(_table);
    RELEASEDICTARRAYOBJ(_index);
    RELEASEDICTARRAYOBJ(_resultArray);
    RELEASEDICTARRAYOBJ(_classType);
    RELEASEDICTARRAYOBJ(_associate);
    
    [super dealloc];
}


- (void)__internalResetCreate
{
    [_field removeAllObjects];
    [_table removeAllObjects];
    [_index removeAllObjects];
    
    [_classType removeAllObjects];
    [_associate removeAllObjects];
}

    //创建表
- (DragonDatabase *)table:(NSString *)name
{
    if (!_database)
    {
        return self;
    }
    
    if (!name)
    {
        return self;
    }
    for (NSString *table in _table)
    {
        if (NSOrderedSame == [table compare:name options:NSCaseInsensitiveSearch])
        {
            return self;
        }
    }
    [_table addObject:name];
    return self;
}

    //在表里创建一个column(列)
- (DragonDatabase *)field:(NSString *)name/*表里的某列的列头名*/ type:(NSString *)type/*field列数据的类型*/ size:(NSUInteger)size
{
    if (!_database)
    {
        return self;
    }
    
    name = [[self class] fieldNameForIdentifier:name];

    for (NSMutableDictionary *dict in _field)
    {
        NSString *name2 = [dict objectForKey:@"name"];
        if (NSOrderedSame == [name2 compare:name options:NSCaseInsensitiveSearch])
        {
            if (type)
            {
                [dict setObject:type forKey:@"type"];
            }
            if (size)
            {
                [dict setObject:[NSNumber numberWithInt:size] forKey:@"size"];
            }
            return self;
        }
    }
    
    [_field addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:name ? name : @"", @"name",
                       type ? type : @"int", @"type",
                       [NSNumber numberWithInt:size], @"size",
                       nil]];
    
    return self;
}

- (DragonDatabase *)unsignedType
{
    if (!_database)
    {
        return self;
    }
    
    NSMutableDictionary *dict = (NSMutableDictionary *)_field.lastObject;
    if (!dict)
    {
        return self;
    }
    
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"unsigned"];
    return self;
}

- (DragonDatabase *)notNull
{
    if (!_database)
    {
        return self;
    }
    
    NSMutableDictionary *dict = (NSMutableDictionary *)_field.lastObject;
    if (!dict)
    {
        return self;
    }
    
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"notNull"];
    return self;
}

- (DragonDatabase *)primaryKey
{
    if (!_database)
    {
        return self;
    }
    
    NSMutableDictionary *dict = (NSMutableDictionary *)_field.lastObject;
    if (!dict)
    {
        return self;
    }
    
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"primaryKey"];
    
    return self;
}

    //自增
- (DragonDatabase *)autoIncrement
{
    if (!_database)
    {
        return self;
    }
    
    NSMutableDictionary *dict = (NSMutableDictionary *)_field.lastObject;
    if (!dict)
    {
        return self;
    }
    
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"autoIncrement"];
    return self;
}

- (DragonDatabase *)defaultZero
{
    return [self defaultValue:[NSNumber numberWithInt:0]];
}

- (DragonDatabase *)defaultNull
{
    return [self defaultValue:[NSNull null]];
}

- (DragonDatabase *)defaultValue:(id)value
{
    if (!_database)
    {
        return self;
    }
    
    NSMutableDictionary *dict = (NSMutableDictionary *)_field.lastObject;
    if (!dict)
    {
        return self;
    }
    
    [dict setObject:value forKey:@"default"];
    return self;
}

- (DragonDatabase *)unique
{
    if (!_database)
    {
        return self;
    }
    
    NSMutableDictionary *dict = (NSMutableDictionary *)_field.lastObject;
    if (!dict)
    {
        return self;
    }
    
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"unique"];
    return self;
    
}

- (BOOL)createTableIfNotExists
{
    return [self createTableIfNotExists:nil];
}

- (BOOL)createTableIfNotExists:(NSString *)table
{
    [self __internalResetResult];
    
    if (!_database)
    {
        return NO;
    }
    if (_table.count == 0)
    {
        return NO;
    }
    
    if (!table)
    {
        table = (NSString *)_table.lastObject;
    }
    
    if (!table || table.length == 0)
    {
        return NO;
    }
    
    if (_field.count == 0)
    {
        return NO;
    }
    
    NSString *sql = [self internalCompileCreate:table];
    [self __internalResetCreate];
    
    BOOL ret = [_database executeUpdate:sql];
    if (ret)
    {
        _lastSucceed = YES;
    }
    
    return ret;
    
}

    //组织sql语句
- (NSString *)internalCompileCreate:(NSString *)table
{
    NSMutableString *sql = [NSMutableString string];
    [sql appendFormat:@"CREATE TABLE IF NOT EXISTS %@ ( ", table];
    for (int i = 0; i < _field.count; i++) {
        NSDictionary *dict = [_field objectAtIndex:i];
        
        NSString *name = (NSString *)[dict objectForKey:@"name"];
        NSString *type = (NSString *)[dict objectForKey:@"type"];
        NSString *size = (NSString *)[dict objectForKey:@"size"];
        NSString *PK = (NSString *)[dict objectForKey:@"primaryKey"];
        NSString *AI = (NSString *)[dict objectForKey:@"autoIncrement"];
        NSString *UN = (NSString *)[dict objectForKey:@"unique"];//表示基本表中的索引值不允许重复，若缺省则表示索引值在表中允许重复
        NSString *NN = (NSString *)[dict objectForKey:@"notNull"];
        
        NSObject *defaultValue = [dict objectForKey:@"default"];
        
        if (i == 0)
        {
            [sql appendFormat:@"%@", name];
        }else
        {
            [sql appendFormat:@", %@", name];
        }
        
        if (type)
        {
            [sql appendFormat:@" %@", type];
        }
        
        if (size && size.intValue)
        {
            [sql appendFormat:@"(%@)", size];
        }
        
        if (PK && PK.intValue)
        {
            [sql appendString:@" PRIMARY KEY"];
        }
        
        if (AI && AI.intValue)
        {
            [sql appendString:@" AUTOINCREMENT"];
        }
        
        if (UN && UN.intValue)
        {
            [sql appendString:@" UNIQUE"];
        }
        
        if (NN && NN.intValue)
        {
            [sql appendString:@" NOT NULL"];
        }
        
        if (defaultValue)
        {
            if ([defaultValue isKindOfClass:[NSNull class]])
            {
                [sql appendString:@" DEFAULT NULL"];
            }else
            {
                [sql appendFormat:@" DEFAULT '%@'", defaultValue];
            }
        }
    }
    [sql appendString:@" )"];
    return sql;
}

- (BOOL)indexTableOn:(NSArray *)fields
{
    [self __internalResetResult];
    
    if (!_database)
    {
        return NO;
    }
    
    if (!fields || fields.count == 0)
    {
        return NO;
    }
    
    if (_table.count == 0)
    {
        return NO;
    }
    
    NSString *table = (NSString *)_table.lastObject;
    if (!table || table.length == 0)
    {
        return NO;
    }
    
    for (NSString *field in fields)
    {
        field = [[self class] fieldNameForIdentifier:field];
        [_index addObject:field];
    }
    
    if (_index.count == 0)
    {
        return NO;
    }
    
    NSString *sql = [self internalCompileIndex:table];
    [self __internalResetCreate];
    
    BOOL ret = [_database executeUpdate:sql];
    if (ret)
    {
        _lastSucceed = YES;
    }
    return ret;
    
}

- (BOOL)indexTable:(NSString *)table on:(NSArray *)fields
{
    [self __internalResetResult];
    
    if (!_database)
    {
        return NO;
    }
    
    if (!fields || fields.count == 0)
    {
        return NO;
    }
    
    if (_table.count == 0)
    {
        return NO;
    }
    
    if (!table)
    {
        table = (NSString *)_table.lastObject;
    }
    
    if (!table || 0 == table.length)
    {
        return NO;
    }
    
    for (NSString *field in fields)
    {
        field = [[self class] fieldNameForIdentifier:field];
        [_index addObject:field];
    }
    
    if (_index.count == 0)
    {
        return NO;
    }
    
    NSString *sql = [self internalCompileIndex:table];
    [self __internalResetCreate];
    
    BOOL ret = [_database executeUpdate:sql];
    if (ret)
    {
        _lastSucceed = YES;
    }
    
    return ret;
}

- (NSString *)internalCompileIndex:(NSString *)table
{
    NSMutableString *sql = [NSMutableString string];
    
    [sql appendFormat:@"CREATE INDEX IF NOT EXISTS index_%@ ON %@ (", table, table];
    
    for (int i = 0; i < [_index count]; i++)
    {
        NSString *field = [_index objectAtIndex:i];
        if (i == 0)
        {
            [sql appendFormat:@"%@", field];
        }else
        {
            [sql appendFormat:@", %@", field];
        }
    }
    
    [sql appendString:@" )"];
    return sql;
}

- (BOOL)existsTable:(NSString *)table
{
    FMResultSet *result = [_database executeQuery:@"SELECT COUNT(*) as 'numrows' FROM sqlite_master WHERE type = 'table' AND name = ?", table];
    
    if (!result)
    {
        return NO;
    }
    
    BOOL succed = [result next];
    if (!succed)
    {
        return NO;
    }
    
    NSDictionary *dict = [result resultDictionary];
    if (!dict)
    {
        return NO;
    }
    
    NSNumber *numrows = [dict objectForKey:@"numrows"];
    if (!numrows)
    {
        return NO;
    }
    
    return numrows.intValue ? YES : NO;
}

- (void)__internalResetSelect
{
    [_select removeAllObjects];
    [_from removeAllObjects];
    [_where removeAllObjects];
    [_like removeAllObjects];
    [_groupby removeAllObjects];
    [_having removeAllObjects];
    [_orderby removeAllObjects];
    
    if (!_batch)
    {
        [_classType removeAllObjects];
        [_associate removeAllObjects];
    }
    
    _distinct = NO;
    _limit = 0;
    _offset = 0;
}

- (void)__internalResetWrite
{
    [_set removeAllObjects];
    [_from removeAllObjects];
    [_where removeAllObjects];
    [_like removeAllObjects];
    [_orderby removeAllObjects];
    [_keys removeAllObjects];
    
    if (!_batch)
    {
        [_classType removeAllObjects];
        [_associate removeAllObjects];
    }
    
    _limit = 0;
    
}

- (DragonDatabase *)select:(NSString *)select
{
    if (!_database)
    {
        return self;
    }
    
    if (!select)
    {
        return self;
    }
    
    NSArray *components = [select componentsSeparatedByString:@","];
    for (NSString *component in components)
    {
        component = [component stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (component && component.length)
        {
            [_select addObject:component];
        }
    }
    
    return self;
}

- (DragonDatabase *)selectMax:(NSString *)select
{
    return [self selectMax:select alias:nil];
}

- (DragonDatabase *)selectMax:(NSString *)select alias:(NSString *)alias
{
    if (!_database)
    {
        return self;
    }
    
    [self internalSelect:select alias:alias type:@"MAX"];
    return self;
}

- (DragonDatabase *)selectMin:(NSString *)select
{
    return [self selectMin:select alias:nil];
}

- (DragonDatabase *)selectMin:(NSString *)select alias:(NSString *)alias
{
    if (!_database)
    {
        return self;
    }
    
    [self internalSelect:select alias:alias type:@"MIN"];
    return self;
}

- (DragonDatabase *)selectAvg:(NSString *)select
{
    return [self selectAvg:select alias:nil];
}

- (DragonDatabase *)selectAvg:(NSString *)select alias:(NSString *)alias
{
    if (!_database)
    {
        return self;
    }
    
    [self internalSelect:select alias:alias type:@"AVG"];
    return self;
}

- (DragonDatabase *)selectSum:(NSString *)select
{
    return [self selectSum:select alias:nil];
}

- (DragonDatabase *)selectSum:(NSString *)select alias:(NSString *)alias
{
    if (!_database)
    {
        return self;
    }
    
    [self internalSelect:select alias:alias type:@"SUM"];
    return self;
}

- (void)internalSelect:(NSString *)select alias:(NSString *)alias type:(NSString *)type
{
    if (!select)
    {
        return;
    }
    
    if (!alias || alias.length == 0)
    {
        alias = [self internalCreateAliasFromTable:alias];
    }
    
    NSString *sql = [NSString stringWithFormat:@"%@(%@) AS %@", type,
                     [select stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]],
                     alias];
    [_select addObject:sql];
}

- (NSString *)internalCreateAliasFromTable:(NSString *)name
{
    NSRange range = [name rangeOfString:@"."];
    
    if (range.length)
    {
        NSArray *array = [name componentsSeparatedByString:@"."];
        if (array && array.count)
        {
            return array.lastObject;
        }
    }
    return name;
}

- (DragonDatabase *)distinct:(BOOL)flag
{
    if (!_database)
    {
        return self;
    }
    
    _distinct = flag;
    return self;
}

- (DragonDatabase *)from:(NSString *)from
{
    if (!_database)
    {
        return self;
    }
    
    if (!from)
    {
        return self;
    }
    
    for (NSString *table in _from)
    {
        if (NSOrderedSame == [table compare:from options:NSCaseInsensitiveSearch])
        {
            return self;
        }
    }
    
    [_from addObject:[from stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return self;
}

- (void)internalWhere:(NSString *)key value:(NSObject *)value type:(NSString *)type
{
    NSString *prefix = (0 == _where.count) ? @"" : type;
    NSString *sql = nil;
    
    key = [[self class] fieldNameForIdentifier:key];
    
    if (!value)
    {
        sql = [NSString stringWithFormat:@"%@ %@ IS NULL", prefix, key];
    }else
    {
        if ([value isKindOfClass:[NSNumber class]])
        {
            sql = [NSString stringWithFormat:@"%@ %@ = %@", prefix, key, value];
        }else
        {
            sql = [NSString stringWithFormat:@"%@ %@ = '%@'", prefix, key, value];
        }
    }
    
    [_where addObject:sql];
    
}

- (DragonDatabase *)where:(NSString *)key value:(id)value
{
    if (!_database)
    {
        return self;
    }
    
    [self internalWhere:key value:value type:@"AND"];
    return self;
}

- (DragonDatabase *)orWhere:(NSString *)key value:(id)value
{
    if (!_database)
    {
        return self;
    }
    
    [self internalWhere:key value:value type:@"OR"];
    return self;
}

- (DragonDatabase *)whereIn:(NSString *)key values:(NSArray *)values
{
    if (!_database)
    {
        return self;
    }
    
    [self internalWhereIn:key values:values not:NO type:@"AND"];
    return self;
}

- (DragonDatabase *)orWhereIn:(NSString *)key values:(NSArray *)values
{
    if (!_database)
    {
        return self;
    }
    
    [self internalWhereIn:key values:values not:NO type:@"OR"];
    return self;
}

- (DragonDatabase *)whereNotIn:(NSString *)key values:(NSArray *)values
{
    if (!_database)
    {
        return self;
    }
    
    [self internalWhereIn:key values:values not:YES type:@"AND"];
    return self;
}

- (DragonDatabase *)orWhereNotIn:(NSString *)key values:(NSArray *)values
{
    if (!_database)
    {
        return self;
    }
    [self internalWhereIn:key values:values not:YES type:@"OR"];
    return self;
    
}

- (void)internalWhereIn:(NSString *)key values:(NSArray *)values not:(BOOL)not type:(NSString *)type
{
    if (!key || !values || values.count == 0)
    {
        return;
    }
    
    key = [[self class] fieldNameForIdentifier:key];
    
    NSMutableString *sql = [NSMutableString string];
    
    if (_where.count)
    {
        [sql appendFormat:@"%@ ",type];
    }
    [sql appendString:key];
    
    if (not)
    {
        [sql appendString:@" NOT"];
    }
    
    [sql appendString:@" IN ("];
    
    for (int i = 0; i < values.count; i ++)
    {
        NSObject *value = [values objectAtIndex:i];
        
        if (i > 0)
        {
            [sql appendString:@", "];
        }
        
        if ([value isKindOfClass:[NSNumber class]])
        {
            [sql appendFormat:@"%@", value];
        }else
        {
            [sql appendFormat:@"'%@'", value];
        }
    }
    
    [sql appendString:@")"];
    [_where addObject:sql];
}

- (DragonDatabase *)like:(NSString *)field match:(id)value
{
    if (!_database)
    {
        return self;
    }
    
    [self internalLike:field match:value type:@"AND" side:@"both" not:NO];
    return self;
}

- (DragonDatabase *)notLike:(NSString *)field match:(id)value
{
    if (!_database)
    {
        return self;
    }
    
    [self internalLike:field match:value type:@"AND" side:@"both" not:YES];
    return self;
}

- (DragonDatabase *)orLike:(NSString *)field match:(id)value
{
    if (!_database)
    {
        return self;
    }
    
    [self internalLike:field match:value type:@"OR" side:@"both" not:NO];
    return self;
}

- (DragonDatabase *)orNotLike:(NSString *)field match:(id)value
{
    if (!_database)
    {
        return self;
    }
    
    [self internalLike:field match:value type:@"OR" side:@"both" not:YES];
    return self;
}

- (void)internalLike:(NSString *)field match:(NSObject *)match type:(NSString *)type side:(NSString *)side not:(BOOL)not
{
    if (!field || !match)
    {
        return;
    }
    
    field = [[self class] fieldNameForIdentifier:field];
    NSString *value = nil;
    
    if ([side isEqualToString:@"before"])
    {
        value = [NSString stringWithFormat:@"%%%@",match];
    }else if ([side isEqualToString:@"after"])
    {
        value = [NSString stringWithFormat:@"%@%%",match];
    }else
    {
        value = [NSString stringWithFormat:@"%%%@%%", match];
    }
    
    NSMutableString *sql = [NSMutableString string];
    
    if (_like.count)
    {
        [sql appendString:type];
    }
    
    [sql appendFormat:@" %@", field];
    
    if (not)
    {
        [sql appendString:@" NOT"];
    }
    
    [sql appendFormat:@" LIKE '%@'", value];
    
    [_like addObject:sql];
    
}

- (DragonDatabase *)groupBy:(NSString *)by
{
    if (!_database)
    {
        return self;
    }
    
    by = [[self class] fieldNameForIdentifier:by];
    [_groupby addObject:by];
    
    return self;
    
}

- (DragonDatabase *)having:(NSString *)key value:(id)value
{
    
    if (!_database)
    {
        return self;
    }
    
    [self internalHaving:key value:value type:@"AND"];
    return self;
}

- (DragonDatabase *)orHaving:(NSString *)key value:(id)value
{
    if (_database)
    {
        return self;
    }
    
    [self internalHaving:key value:value type:@"OR"];
    return self;
}

- (void)internalHaving:(NSString *)key value:(NSObject *)value type:(NSString *)type
{
    if (!key || !value)
    {
        return;
    }
    key = [[self class] fieldNameForIdentifier:key];
    
    NSString *sql = nil;
    
    if (_having.count)
    {
        sql = [NSString stringWithFormat:@"%@ %@ = '%@'", type, key, value];
    }else
    {
        sql = [NSString stringWithFormat:@"%@ = '%@'", key, value];
    }
    
    [_having addObject:sql];
    
}

//表里的每行按by随机排
- (DragonDatabase *)orderAscendBy:(NSString *)by
{
    return [self orderBy:by direction:@"ASC"];
}

//表里的每行按by倒叙排
- (DragonDatabase *)orderDescendBy:(NSString *)by
{
    return [self orderBy:by direction:@"DESC"];
}

//表里的每行按by随机排
- (DragonDatabase *)orderRandomBy:(NSString *)by
{
    return [self orderBy:by direction:@"RAND()"];
}

//排序表里每行,
- (DragonDatabase *)orderBy:(NSString *)by direction:(NSString *)direction
{
    if (!_database)
    {
        return self;
    }
    
    if (!by)
    {
        return self;
    }
    
    by = [[self class] fieldNameForIdentifier:by];
    
    NSString *sql = [NSString stringWithFormat:@"%@ %@", by, direction];
    [_orderby addObject:sql];
    
    return self;
    
}

- (DragonDatabase *)limit:(NSUInteger)limit
{
    if (!_database)
    {
        return self;
    }
    
    _limit = limit;
    return self;
}

- (DragonDatabase *)offset:(NSUInteger)offset
{
    if (!_database)
    {
        return self;
    }
    
    _offset = offset;
    return self;
    
}

- (DragonDatabase *)classInfo:(id)obj
{
    if (!obj)
    {
        return self;
    }
    
    [_classType addObject:obj];
    return self;
    
}

- (DragonDatabase *)set:(NSString *)key
{
    return [self set:key value:nil];
}

- (DragonDatabase *)set:(NSString *)key value:(id)value
{
    
    if (!_database)
    {
        return self;
    }
    
    if (!key)
    {
        return self;
    }
    
    key = [[self class] fieldNameForIdentifier:key];
    
    value = (value ? value : [NSNull null]);
    
    [_set setObject:value forKey:key];
    
    return self;
    
}

- (void)__internalResetResult
{
    [_resultArray removeAllObjects];
    
    _resultCount = 0;
    _lastInsertID = -1;
    _lastSucceed = NO;
}

- (NSArray *)get
{
    return [self get:nil limit:0 offset:0];
}

- (NSArray *)get:(NSString *)table
{
    return [self get:table limit:0 offset:0];
}

- (NSArray *)get:(NSString *)table limit:(NSUInteger)limit
{
    return [self get:table limit:limit offset:0];
}

- (NSArray *)get:(NSString *)table limit:(NSUInteger)limit offset:(NSUInteger)offset
{
    [self __internalResetResult];
    
    if(!_database)
    {
        return nil;
    }
    
    if(table)
    {
        [self from:table];
    }
    
    if(limit)
    {
        [self limit:limit];
    }
    
    if(offset)
    {
        [self offset:offset];
    }
    
    NSString *sql = [self internalCompileSelect:nil];
    [self __internalResetSelect];
    
    FMResultSet *result = [_database executeQuery:sql];
    if(result)
    {
        while ([result next])
        {
            [_resultArray addObject:[result resultDictionary]];
        }
        _resultCount = _resultArray.count;
        _lastSucceed = YES;
        
    }
    
    return _resultArray;
    
}

- (NSString *)internalCompileSelect:(NSString *)override
{
    NSMutableString *sql = [NSMutableString string];
    
    if (override)
    {
        [sql appendString:override];
    }else
    {
        if (_distinct)
        {
            [sql appendString:@"SELECT DISTINCT"];
        }else
        {
            [sql appendString:@"SELECT "];
        }
        
        if (_select.count)
        {
            for (int i = 0; i < _select.count; i++)
            {
                NSString *select = [_select objectAtIndex:i];
                if (i == 0)
                {
                    [sql appendString:select];
                }else
                {
                    [sql appendFormat:@", %@", select];
                }
            }
        }else
        {
            [sql appendString:@"*"];
        }
        
    }
    if (_from.count)
    {
        [sql appendString:@" FROM "];
        
        for (int i = 0; i < _from.count; i++)
        {
            NSString *from = [_from objectAtIndex:i];
            if (i == 0)
            {
                [sql appendString:from];
            }else
            {
                [sql appendFormat:@", %@", from];
            }
        }
    }
    
    if (_where.count || _like.count)
    {
        [sql appendString:@" WHERE"];
    }
    
    if (_where.count)
    {
        for (NSString *where in _where)
        {
            [sql appendFormat:@" %@ ", where];
        }
    }
    
    if (_like.count)
    {
        if (_where.count)
        {
            [sql appendString:@" AND "];
        }
        
        for (NSString *like in _like)
        {
            [sql appendFormat:@" %@ ",like];
        }
    }
    
    if (_groupby.count)
    {
        [sql appendString:@" GROUP BY "];
        
        for (int i = 0; i < [_groupby count]; i++)
        {
            NSString *by = [_groupby objectAtIndex:i];
            
            if (i == 0)
            {
                [sql appendString:by];
            }else
            {
                [sql appendFormat:@", %@", by];
            }
        }
    }
    
    if (_having.count)
    {
        [sql appendString:@" HAVING "];
        
        for (NSString *have in _having)
        {
            [sql appendFormat:@" %@ ",have];
        }
    }
    
    if (_orderby.count)
    {
        [sql appendString:@" ORDER BY "];
        
        for (int i = 0; i < [_orderby count]; i++)
        {
            NSString *by = [_orderby objectAtIndex:i];
            if (i == 0)
            {
                [sql appendString:by];
            }else
            {
                [sql appendFormat:@", %@", by];
            }
        }
        
    }
    
    if (_limit)
    {
        if (_offset)
        {
            [sql appendFormat:@" LIMIT %u, %u", _offset, _limit];
        }else
        {
            [sql appendFormat:@" LIMIT %u", _limit];
        }
    }
    
    return sql;
    
}

- (NSUInteger)count
{
    return [self count:nil];
}

- (NSUInteger)count:(NSString *)table
{
    [self __internalResetResult];
    
    if (!_database)
    {
        return 0;
    }
    
    if (table)
    {
        [self from:table];
    }
    
    NSString *sql = [self internalCompileSelect:@"SELECT COUNT(*) AS numrows"];
    [self __internalResetSelect];
    
    FMResultSet *result = [_database executeQuery:sql];
    
    if (result)
    {
        BOOL ret = [result next];
        if (!ret)
        {
            return 0;
        }
        
        _resultCount = (NSUInteger)[result unsignedLongLongIntForColumn:@"numrows"];
        _lastSucceed = YES;
    }
    
    return _resultCount;
    
}

- (NSInteger)insert
{
    return [self insert:nil];
}

- (NSInteger)insert:(NSString *)table
{
    [self __internalResetResult];
    if (!_database)
    {
        return -1;
    }
    
    if (_set.count == 0)
    {
        return -1;
    }
    
    if (!table)
    {
        if (_from.count == 0)
        {
            return -1;
        }
        
        table = [_from objectAtIndex:0];
    }
    
    NSMutableString *sql = [NSMutableString string];
    NSArray *allKeys = _set.allKeys;
    NSMutableArray *allValues = [NSMutableArray array];
    
    NSString *field = nil;
    NSObject *value = nil;
    
    [sql appendFormat:@"INSERT INTO %@ (",table];
    
    for (int i = 0; i < allKeys.count; i++)
    {
        NSString *key = [allKeys objectAtIndex:i];
        
        field = [[self class] fieldNameForIdentifier:key];
        value = [_set objectForKey:key];
        
        if (i == 0)
        {
            [sql appendString:field];
        }else
        {
            [sql appendFormat:@", %@", field];
        }
        
        [allValues addObject:value];
        
    }
    
    [sql appendString:@") VALUES ("];
    
    for (int i = 0; i < allValues.count; i++)
    {
        if (i == 0)
        {
            [sql appendString:@"?"];
        }else
        {
            [sql appendString:@", ?"];
        }
    }
    [sql appendString:@")"];
    
    [self __internalResetWrite];
    
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:allValues];
    if (ret)
    {
        _lastInsertID = (NSInteger)_database.lastInsertRowId;
        _lastSucceed = YES;
    }
    
    return _lastInsertID;
    
}

- (BOOL)update
{
    return [self update:nil];
}

    //要更新的表名
- (BOOL)update:(NSString *)table
{
    [self __internalResetResult];
    
    if (!_database)
    {
        return NO;
    }
    if (!_set.count)
    {
        return NO;
    }
    
    if (!table)
    {
        if (0 == _from.count)
        {
            return NO;
        }
        table = [_from objectAtIndex:0];
    }
    
    NSMutableString *sql = [NSMutableString string];
    NSArray *allkeys = _set.allKeys;
    NSMutableArray *allValues = [NSMutableArray array];
    
    NSString *field = nil;
    NSObject *value = nil;
    
    [sql appendFormat:@"UPDATE %@ SET", table];
    
    for (int i = 0; i < allkeys.count; i++)
    {
        NSString *key = [allkeys objectAtIndex:i];
        
        field = [[self class] fieldNameForIdentifier:key];
        value = [_set objectForKey:key];
        
        if (value)
        {
            [allValues addObject:value];
            
            if (i == 0)
            {
                [sql appendFormat:@" %@ = ?", field];
            }else
            {
                [sql appendFormat:@", %@ = ?", field];
            }
        }
    }
    
    if (_where.count)
    {
        [sql appendString:@" WHERE"];
        
        for (NSString *where in _where)
        {
            [sql appendFormat:@" %@", where];
        }
    }
    
    if (_orderby.count)
    {
        [sql appendString:@" ORDER BY "];
        
        for (int i = 0; i < _orderby.count; i++)
        {
            NSString *by = [_orderby objectAtIndex:i];
            
            if (i == 0)
            {
                [sql appendString:by];
            }else
            {
                [sql appendFormat:@", %@", by];
            }
            
        }
    }
    
    if (_limit)
    {
        [sql appendFormat:@" LIMIT %u", _limit];
    }
    
    [self __internalResetWrite];
    
    BOOL ret = [_database executeUpdate:sql withArgumentsInArray:allValues];
    if (ret)
    {
        _lastSucceed = YES;
    }
    return ret;
}

- (BOOL)empty
{
    return [self empty:nil];
}

- (BOOL)empty:(NSString *)table
{
    [self __internalResetResult];
    
    if (!_database)
    {
        return NO;
    }
    
    if (!table)
    {
        if (_from.count == 0)
        {
            return NO;
        }
        table = [_from objectAtIndex:0];
    }
    
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@", table];
    [self __internalResetWrite];
    
    BOOL ret = [_database executeUpdate:sql];
    if (ret)
    {
        _lastSucceed = YES;
    }
    
    return ret;
    
}

- (BOOL)truncate
{
    return [self truncate:nil];
    
}

- (BOOL)truncate:(NSString *)table
{
    [self __internalResetResult];
    if (!_database)
    {
        return NO;
    }
    
    if (!table)
    {
        if (_from.count == 0)
        {
            return NO;
        }
        
        table = [_from objectAtIndex:0];
    }
    
    NSString * sql = [NSString stringWithFormat:@"TRUNCATE %@", table];
    
    [self __internalResetWrite];
    
    BOOL ret = [_database executeUpdate:sql];
    if (ret)
    {
        _lastSucceed = YES;
    }
    return ret;
    
}

- (BOOL)delete
{
    return [self delete:nil];
}

- (BOOL)delete:(NSString *)table
{
    [self __internalResetResult];
    if (!_database)
    {
        return NO;
    }
    
    if (!table)
    {
        if (_from.count == 0)
        {
            return NO;
        }
        table = [_from objectAtIndex:0];
    }
    
    if (_where.count == 0 && _like.count == 0)
    {
        return NO;
    }
    
    NSMutableString *sql = [NSMutableString string];
    
    [sql appendFormat:@"DELETE FROM %@", table];
    
    if (_where.count || _like.count)
    {
        [sql appendString:@" WHERE "];
        if (_where.count)
        {
            for (NSString *where in _where)
            {
                [sql appendFormat:@" %@ ", where];
            }
        }
        
        if (_like.count)
        {
            if (_where.count)
            {
                [sql appendString:@" AND "];
            }
            
            for (NSString *like in _like)
            {
                [sql appendFormat:@" %@ ",like];
            }
            
        }
    }
    if (_limit)
    {
        [sql appendFormat:@" LIMIT %u", _limit];
    }
    
    [self __internalResetWrite];
    
    BOOL ret = [_database executeUpdate:sql];

    return ret;
    
}

- (BOOL)drop
{
    return [self drop:nil];
}

- (BOOL)drop:(NSString *)table
{
    [self __internalResetResult];
    if (!_database)
    {
        return NO;
    }
    
    if (!table)
    {
        if (_from.count == 0)
        {
            return NO;
        }
        table = [_from objectAtIndex:0];
    }
    
    NSString * sql = [NSString stringWithFormat:@"DROP TABLE %@", table];
    
    [self __internalResetWrite];
    
    BOOL ret = [_database executeUpdate:sql];
    if (ret)
    {
        _lastSucceed = YES;
    }
    return ret;
}

+ (NSString *)fieldNameForIdentifier:(NSString *)identifier
{
    NSString *name = identifier;
    name = [name stringByReplacingOccurrencesOfString:@"." withString:@"_"];
    name = [name stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return name;
}

+ (NSString *)tableNameForClass:(Class)clazz
{
    return [NSString stringWithFormat:@"table_%@", [clazz description]];
}

- (Class)classType
{
    NSString *className = _classType.lastObject;
    
    if (!className || className.length == 0)
    {
        return NULL;
    }
    
    Class classType = NSClassFromString(className);

    return classType;
}

- (NSArray *)associateObjects
{
    return _associate;
}

- (NSArray *)associateObjectsFor:(Class)clazz
{
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSObject *obj in _associate)
    {
        if ([obj isKindOfClass:clazz])
        {
            [array addObject:obj];
        }
    }
    
    return array;
}

- (NSArray *)hasObjects
{
    return _has;
}

- (NSArray *)hasObjectsFor:(Class)clazz
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSObject *obj in _has)
    {
        if ([obj isKindOfClass:clazz])
        {
            [array addObject:obj];
        }
    }
    return array;
}

- (void)classType:(Class)clazz
{
    if (!clazz)
    {
        return;
    }
    
    [_classType addObject:[clazz description]];
    
    [self from:[DragonDatabase tableNameForClass:clazz]];
}

- (void)associate:(NSObject *)obj
{
    if (!obj)
    {
        return;
    }
    [_associate addObject:obj];
}

- (DragonDataBaseBlockN)TABLE
{
    DragonDataBaseBlockN block = ^ DragonDatabase*(id first,...)
    {
        return [self table:(NSString *)first];
    };
    return [[block copy] autorelease];
}

    //在表里创建一个column(列),列的名字是第一个参数
- (DragonDataBaseBlockN)FIELD
{
    DragonDataBaseBlockN block = ^ DragonDatabase*(id first,...)
    {
    va_list args;//结构体里的第一个变量指向可变参数列表的第一个参数的指针
        va_start(args, first);//初始化args

        NSString *field = (NSString *)first;
        NSString *type = va_arg(args, NSString *);//获取可变参数的当前参数，返回指定类型并将指针指向下一参数（第二个参数描述了当前参数的类型）
        va_end(args);
        return [self field:field type:type size:0];
        
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)FIELD_WITH_SIZE
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *field = (NSString *)first;
        NSString *type = va_arg(args, NSString *);
        NSUInteger size = va_arg(args, NSUInteger);
        
        va_end(args);
        return [self field:field type:type size:size];
        
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)UNSIGNED
{
    DragonDataBaseBlock block = ^ DragonDatabase*(void)
    {
        return [self unsignedType];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)NOT_NULL
{
    DragonDataBaseBlock block = ^ DragonDatabase*(void)
    {
        return [self notNull];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)PRIMARY_KEY
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        return [self primaryKey];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)AUTO_INREMENT
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        return [self autoIncrement];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)DEFAULT_ZERO
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        return [self defaultZero];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)DEFAULT_NULL
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        return [self defaultNull];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)DEFAULT
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self defaultValue:first];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)UNIQUE
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        return [self unique];
    };
    return [[block copy] autorelease];
}

    //如果表名已存在就不创建
- (DragonDataBaseBlock)CREATE_IF_NOT_EXISTS
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        return [self createTableIfNotExists] ? self : nil;
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)INDEX_ON
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id field,...)
    {
        va_list args;
        va_start(args, field);
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (; ; field = nil)
        {
            NSObject *name = field ? field : va_arg(args, NSObject *);
            if (!name || ![name isKindOfClass:[NSString class]])
            {
                break;
            }
            [array addObject:(NSString *)name];
        }
        va_end(args);
        return [self indexTableOn:array] ? self : nil;
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT
{
    DragonDataBaseBlockN block = ^ DragonDatabase*(id first,...)
    {
        return [self select:(NSString *)first];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT_MAX
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self selectMax:(NSString *)first];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT_MAX_ALIAS
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *field = (NSString *)first;
        NSString *alias = (NSString *)va_arg(args, NSString *);
        va_end(args);
        
        return [self selectMax:field alias:alias];
    };
    
    return [[block copy] autorelease];

}

- (DragonDataBaseBlockN)SELECT_MIN
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self selectMin:(NSString *)first];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT_MIN_ALIAS
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
		va_start( args, first );
		
		NSString * field = (NSString *)first;
		NSString * alias = (NSString *)va_arg( args, NSString * );
		va_end(args);
		return [self selectMin:field alias:alias];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT_AVG
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self selectAvg:(NSString *)first];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT_AVG_ALIAS
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *field = (NSString *)first;
        NSString *alias = (NSString *)va_arg(args, NSString *);
        va_end(args);
        
        return [self selectAvg:field alias:alias];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT_SUM
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self selectSum:(NSString *)first];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)SELECT_SUM_ALIAS
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        NSString *field = (NSString *)first;
        NSString *alias = (NSString *)va_arg(args, NSString *);
        va_end(args);
        return [self selectSum:field alias:alias];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)DISTINCT
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        return [self distinct:YES];
    };
    
    return [[block copy] autorelease];
}

    //表
- (DragonDataBaseBlockN)FROM
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self from:(NSString *)first];
    };
    return [[block copy] autorelease];
}

//条件判断 where  first＝value
- (DragonDataBaseBlockN)WHERE
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        va_end(args);
        return [self where:key value:value];
        
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)OR_WHERE
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first, ...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        va_end(args);
        return [self orWhere:key value:value];
    
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)WHERE_IN
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id field,...)
    {
        va_list args;
        va_start(args, field);
        
        NSString *key = (NSString *)field;
        NSMutableArray *array = [NSMutableArray array];
        NSString *str;
        while ((str = va_arg(args, NSString *)))
        {
            [array addObject:(NSString *)str];
        }
        va_end(args);
        return [self whereIn:key values:array];
        
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)OR_WHERE_IN
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id field,...)
    {
        va_list args;
        va_start(args, field);
        
        NSString *key = (NSString *)field;
        NSMutableArray *array = [NSMutableArray array];
        
        NSString *str;
        while ((str = va_arg(args, NSString *)))
        {
            [array addObject:(NSString *)str];
        }
        
        va_end(args);
        return [self orWhereIn:key values:array];
        
    };
    
    return [[block copy] autorelease];
    
}

- (DragonDataBaseBlockN)WHERE_NOT_IN
{
    DragonDataBaseBlockN block = ^DragonDatabase *(id field, ...)
    {
        va_list args;
        va_start(args, field);
        
        NSString *key = (NSString *)field;
        NSMutableArray *array = [NSMutableArray array];
        NSString *str;
        while ((str = va_arg(args, NSString *)))
        {
            [array addObject:(NSString *)str];
        }
        va_end(args);
        return [self whereNotIn:key values:array];
        
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)OR_WHERE_NOT_IN
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id field, ...)
    {
        
        va_list args;
        va_start(args, field);
        
        NSString *key = (NSString *)field;
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSString *str;
        while ((str = va_arg(args, NSString *)))
        {
            [array addObject:(NSString *)str];
        }
        va_end(args);
        return [self orWhereNotIn:key values:array];
        
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)LIKE
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        va_end(args);
        return [self like:key match:value];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)NOT_LIKE
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        
        return [self notLike:key match:value];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)OR_LIKE
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        va_end(args);
        
        return [self orLike:key match:value];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)OR_NOT_LIKE
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        va_end(args);
        return [self orNotLike:key match:value];
    
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)GROUP_BY
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self groupBy:(NSString *)first];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)HAVING
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        va_end(args);
        return [self having:key value:value];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)OR_HAVING
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);
        va_end(args);
        return [self orHaving:key value:value];
    };
    return [[block copy] autorelease];
}

//表里的内容按first正序排
- (DragonDataBaseBlockN)ORDER_ASC_BY
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self orderAscendBy:(NSString *)first];
    };
    return [[block copy] autorelease];
    
}

//表里的内容按first反序排
- (DragonDataBaseBlockN)ORDER_DESC_BY
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self orderDescendBy:(NSString *)first];
    };
    
    return [[block copy] autorelease];
}

//表里的内容按first随机排
- (DragonDataBaseBlockN)ORDER_RAND_BY
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self orderRandomBy:(NSString *)first];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)ORDER_BY
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        NSString *by = (NSString *)first;
        NSString *direction = (NSString *)va_arg(args, NSString *);
        va_end(args);
        
        return [self orderBy:by direction:direction];
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockU)LIMIT
{
    DragonDataBaseBlockU block = ^DragonDatabase *(NSUInteger value)
    {
        return [self limit:value];
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockU)OFFSET
{
    DragonDataBaseBlockU block = ^DragonDatabase*(NSUInteger value)
    {
        return [self offset:value];
    };
    
    return [[block copy] autorelease];
}


- (DragonDataBaseBlockN)SET_NULL
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        return [self set:first];
    };
    return [[block copy] autorelease];
}

    //插入数据
- (DragonDataBaseBlockN)SET
{
    DragonDataBaseBlockN block = ^DragonDatabase*(id first,...)
    {
        va_list args;
        va_start(args, first);
        
        NSString *key = (NSString *)first;
        NSObject *value = (NSObject *)va_arg(args, NSObject *);//获取可变参数的当前参数，返回指定类型并将指针指向下一参数（第二个参数描述了当前参数的类型）
        va_end(args);
        return [self set:key value:value];
        
    };
    return [[block copy] autorelease];
}

    //查找
- (DragonDataBaseBlock)GET
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        [self get];
        return self;
    };
    
    return [[block copy] autorelease];
}


- (DragonDataBaseBlock)COUNT
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        [self count];
        return self;
    };
    
    return [[block copy] autorelease];
}

- (DragonDataBaseBlock)INSERT
{
	DragonDataBaseBlock block = ^DragonDatabase*(void)
	{
		[self insert];
		return self;
	};
	
	return [[block copy] autorelease];
}

- (DragonDataBaseBlock)UPDATE
{
	DragonDataBaseBlock block = ^DragonDatabase*(void)
	{
		[self update];
		return self;
	};
	
	return [[block copy] autorelease];
}

//清空表里的内容但表名还在
- (DragonDataBaseBlock)EMPTY
{
	DragonDataBaseBlock block = ^DragonDatabase*(void)
	{
		[self empty];
		return self;
	};
	
	return [[block copy] autorelease];
}

- (DragonDataBaseBlock)TRUNCATE
{
	DragonDataBaseBlock block = ^DragonDatabase*(void)
	{
		[self truncate];
		return self;
	};
	
	return [[block copy] autorelease];
}

- (DragonDataBaseBlock)DELETE
{
	DragonDataBaseBlock block = ^DragonDatabase*(void)
	{
		[self delete];
		return self;
	};
	
	return [[block copy] autorelease];
}

//删除整个表(包括表名)
- (DragonDataBaseBlock)DROP
{
    DragonDataBaseBlock block = ^DragonDatabase*(void)
    {
        [self drop];
        return self;
    
    };
    return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)CLASS_TYPE
{
	DragonDataBaseBlockN block = ^DragonDatabase*(id first, ...)
	{
		[self classType:(Class)first];
		return self;
	};
	
	return [[block copy] autorelease];
}

- (DragonDataBaseBlockN)ASSOCIATE
{
	DragonDataBaseBlockN block = ^DragonDatabase*(id first, ...)
	{
		[self associate:first];
		return self;
	};
	
	return [[block copy] autorelease];
}

- (DragonDataBaseBlock)BATCH_BEGIN
{
	DragonDataBaseBlock block = ^DragonDatabase*(void)
	{
		_batch = YES;
		return self;
	};
	
	return [[block copy] autorelease];
}

- (DragonDataBaseBlock)BATCH_END
{
	DragonDataBaseBlock block = ^DragonDatabase*(void)
	{
		_batch = NO;
		return self;
	};
	
	return [[block copy] autorelease];
}
@end
