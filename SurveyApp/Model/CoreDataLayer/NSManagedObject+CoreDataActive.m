//
//  NSManagedObject+CoreDataActive.m
//  Pods
//
//  Created by Purbo Mohamad on 8/22/14.
//
//

#import "NSManagedObject+CoreDataActive.h"
#import "CoreDataHelper.h"


@interface CoreDataQueryable()

@property (nonatomic, strong) Class entityClass;

@property (nonatomic, strong) id conditions;
@property (nonatomic, strong) id order;
@property (nonatomic, strong) NSNumber *numberOfRecords;
@property (nonatomic, strong) NSNumber *fromRecordNum;
#if TARGET_OS_IPHONE
@property (nonatomic, strong) NSString *sectionNameKeyPath;
@property (nonatomic, strong) NSString *cacheName;
#endif
@property (nonatomic, copy) CoreDataErrorBlock errorBlock;

- (id)initWithClass:(Class)entityClass;

@end

@implementation CoreDataQueryable

- (id)initWithClass:(Class)entityClass;
{
    if (self = [super init]) {
        self.entityClass = entityClass;
        self.conditions = nil;
        self.order = nil;
        self.numberOfRecords = nil;
        self.fromRecordNum = nil;
#if TARGET_OS_IPHONE
        self.sectionNameKeyPath = nil;
        self.cacheName = nil;
#endif
        self.errorBlock = nil;
    }
    return self;
}

- (CoreDataQueryable *)where:(id)condition, ...
{
    va_list va_arguments;
    va_start(va_arguments, condition);
    _conditions =  [CoreDataHelper predicateFromObject:condition arguments:va_arguments];
    va_end(va_arguments);
    return self;
}

- (CoreDataQueryable *)order:(id)order
{
    _order = order;
    return self;
}

- (CoreDataQueryable *)limit:(NSUInteger)numberOfRecords
{
    _numberOfRecords = @(numberOfRecords);
    return self;
}

- (CoreDataQueryable *)offset:(NSUInteger)fromRecordNum
{
    _fromRecordNum = @(fromRecordNum);
    return self;
}

- (CoreDataQueryable *)error:(CoreDataErrorBlock)errorBlock
{
    _errorBlock = errorBlock;
    return self;
}

#if TARGET_OS_IPHONE
- (CoreDataQueryable *)sectionNameKeyPath:(NSString *)sectionNameKeyPath
{
    _sectionNameKeyPath = sectionNameKeyPath;
    return self;
}

- (CoreDataQueryable *)cacheName:(NSString *)cacheName
{
    _cacheName = cacheName;
    return self;
}
#endif

- (id)first
{
    NSArray *result = [self all];
    return ([result count] > 0) ? [result objectAtIndex:0] : nil;
}

- (NSArray *)all
{
    NSError *error = nil;
    NSArray *ret = [CoreDataHelper objectsOfEntity:_entityClass
                                                where:_conditions
                                                order:_order
                                                limit:_numberOfRecords
                                               offset:_fromRecordNum
                                                error:&error];
    if (error) {
        if (_errorBlock) {
            _errorBlock(error);
        } else {
            NSLog(@"[ERROR] Unhandled MMPCoreDataHelper query error: %@", error);
        }
    }
    
    return ret;
}

- (void)each:(CoreDataRecordBlock)recordBlock
{
    NSArray *result = [self all];
    if (result && [result count] > 0) {
        for (id record in result) {
            recordBlock(record);
        }
    }
}

#if TARGET_OS_IPHONE
- (NSFetchedResultsController *)fetchedResultsController
{
    return [CoreDataHelper fetchedResultsControllerForEntity:_entityClass
                                                          where:_conditions
                                                          order:_order
                                                          limit:_numberOfRecords
                                                         offset:_fromRecordNum
                                             sectionNameKeyPath:_sectionNameKeyPath
                                                      cacheName:_cacheName];
}
#endif

- (NSUInteger)count
{
    NSError *error = nil;
    NSUInteger ret = [CoreDataHelper countObjectsOfEntity:_entityClass
                                                       where:_conditions
                                                       error:&error];
    
    if (error) {
        if (_errorBlock) {
            _errorBlock(error);
        } else {
            NSLog(@"[ERROR] Unhandled MMPCoreDataHelper count error: %@", error);
        }
    }
    
    return ret;
}

- (id)_aggregate:(NSString *)aggregateFunction of:(NSString *)attributeName
{
    NSError *error = nil;
    id result = [CoreDataHelper runAggregate:aggregateFunction
                                          where:_conditions
                                   forAttribute:attributeName
                                       ofEntity:_entityClass
                                          error:&error];
    if (error) {
        if (_errorBlock) {
            _errorBlock(error);
        } else {
            NSLog(@"[ERROR] Unhandled MMPCoreDataHelper aggregate min error: %@", error);
        }
    }
    
    return result;
}

- (id)min:(NSString *)attributeName
{
    return [self _aggregate:@"min:" of:attributeName];
}

- (id)max:(NSString *)attributeName
{
    return [self _aggregate:@"max:" of:attributeName];
}

- (id)sum:(NSString *)attributeName
{
    return [self _aggregate:@"sum:" of:attributeName];
}

@end


@implementation NSManagedObject (CoreDataActive)

+ (instancetype)create
{
    return [CoreDataHelper createObjectOfEntity:[self class]];
}

+ (void)clear:(NSPredicate *)predicate
{
    [CoreDataHelper deleteObjectsOfEntity:[self class] withPredicate:predicate];
}

- (instancetype)insert:(NSDictionary *)data
{
    //[self setValuesForKeysWithDictionary:data];
    [self safeSetValuesForKeysWithDictionary:data dateFormatter:[Function getDateFormatForApp]];
    return self;
}
- (void)safeSetValuesForKeysWithDictionary:(NSDictionary *)keyedValues dateFormatter:(NSDateFormatter *)dateFormatter
{
    NSDictionary *attributes = [[self entity] attributesByName];
    for (NSString *attribute in attributes)
    {
        id value = [keyedValues objectForKey:attribute];
        if (value == nil) {
            continue;
        }
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]]))
        {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) || (attributeType == NSInteger32AttributeType) || (attributeType == NSInteger64AttributeType) || (attributeType == NSBooleanAttributeType)) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value integerValue]];
        } else if ((attributeType == NSFloatAttributeType) &&  ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        } else if ((attributeType == NSDateAttributeType) && ([value isKindOfClass:[NSString class]]) && (dateFormatter != nil)) {
            value = [dateFormatter dateFromString:value];
        }
        [self setValue:value forKey:attribute];
    }
}

- (instancetype)delete
{
    [CoreDataHelper deleteObject:self];
    return self;
}

- (instancetype)save
{
    [CoreDataHelper save];
    return self;
}


+ (CoreDataQueryable *)query
{
    return [[CoreDataQueryable alloc] initWithClass:[self class]];
}

@end
