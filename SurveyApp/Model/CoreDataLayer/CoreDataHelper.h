//
//  MMPCoreDataHelper.h
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject+CoreDataActive.h"


extern NSString * const CoreDataErrorDomain;
extern NSString * const DataAccessSaveErrorNotification;
extern NSString * const DataAccessDidSaveNotification;

@interface CoreDataHelper : NSObject

@property (readonly, strong) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (copy, nonatomic) NSString *databaseName;
@property (copy, nonatomic) NSString *modelName;


+ (instancetype)instance;

- (NSString *)sqliteStorePath;
+ (NSEntityDescription *)entityDescriptionOf:(Class)entityClass;

/***
 Commits all changes asynchronously regardless of which thread this method is called  from.
 If this method is called on a background thread, the changes will be propagated to main thread
***/

+ (void)save;
+ (id)createObjectOfEntity:(Class)entityClass;
+ (void)deleteObject:(NSManagedObject *)object;
+ (void)deleteObjectsOfEntity:(Class)entityClass withPredicate:(NSPredicate *)predicate;
+ (id)objectWithID:(NSManagedObjectID *)objectID;
+ (NSPredicate *)predicateFromObject:(id)condition arguments:(va_list)arguments;

/**
 ---------------------------------------------------------------------------------------
 * @name Query producing multiple objects
 ---------------------------------------------------------------------------------------
**/

+ (NSArray *)objectsOfEntity:(Class)entityClass
                       where:(id)condition
                       order:(id)order
                       limit:(NSNumber *)numberOfRecords
                      offset:(NSNumber *)fromRecordNum
                       error:(NSError **)error;

+ (NSArray *)objectsOfEntity:(Class)entityClass
               withPredicate:(NSPredicate *)predicate
             sortDescriptors:(NSArray *)sortDescriptors
                  fetchLimit:(NSNumber *)fetchLimit
                 fetchOffset:(NSNumber *)fetchOffset
                       error:(NSError **)error;

/**---------------------------------------------------------------------------------------
 * @name Aggregate query
 *  ---------------------------------------------------------------------------------------
 */

+ (NSUInteger)countObjectsOfEntity:(Class)entityClass
                             where:(id)condition
                             error:(NSError **)error;

+ (NSUInteger)countObjectsOfEntity:(Class)entityClass
                     withPredicate:(NSPredicate *)predicate
                             error:(NSError **)error;

+ (id)runAggregate:(NSString *)aggregateFunction
             where:(id)condition
      forAttribute:(NSString *)attributeName
          ofEntity:(Class)entityClass
             error:(NSError **)error;

+ (id)runAggregate:(NSString *)aggregateFunction
     withPredicate:(NSPredicate *)predicate
      forAttribute:(NSString *)attributeName
          ofEntity:(Class)entityClass
             error:(NSError **)error;


/**---------------------------------------------------------------------------------------
 * @name Query producing NSFetchedResultsController
 *  ---------------------------------------------------------------------------------------
 */

+ (NSFetchedResultsController *)fetchedResultsControllerForEntity:(Class)entityClass
                                                            where:(id)condition
                                                            order:(id)order
                                                            limit:(NSNumber *)numberOfRecords
                                                           offset:(NSNumber *)fromRecordNum
                                               sectionNameKeyPath:(NSString *)sectionNameKeyPath
                                                        cacheName:(NSString *)cacheName;

+ (NSFetchedResultsController *)fetchedResultsControllerForEntity:(Class)entityClass
                                                    withPredicate:(NSPredicate *)predicate
                                                  sortDescriptors:(NSArray *)sortDescriptors
                                                       fetchLimit:(NSNumber *)fetchLimit
                                                      fetchOffset:(NSNumber *)fetchOffset
                                               sectionNameKeyPath:(NSString *)sectionNameKeyPath
                                                        cacheName:(NSString *)cacheName;

@end
