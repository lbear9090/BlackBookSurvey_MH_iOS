//
//
//
//  Created by Purbo Mohamad on 8/22/14.
//
//

#import <CoreData/CoreData.h>


typedef void(^CoreDataErrorBlock)(NSError *error);
typedef void(^CoreDataRecordBlock)(id record);

@interface CoreDataQueryable : NSObject

- (CoreDataQueryable *)where:(id)condition, ...;
- (CoreDataQueryable *)order:(id)order;
- (CoreDataQueryable *)limit:(NSUInteger)numberOfRecords;
- (CoreDataQueryable *)offset:(NSUInteger)fromRecordNum;
- (CoreDataQueryable *)error:(CoreDataErrorBlock)errorBlock;

/**---------------------------------------------------------------------------------------
 * @name NSFetchedResultsController specific query construction
 * ---------------------------------------------------------------------------------------
 */

- (CoreDataQueryable *)sectionNameKeyPath:(NSString *)sectionNameKeyPath;
- (CoreDataQueryable *)cacheName:(NSString *)cacheName;

/**---------------------------------------------------------------------------------------
 * @name Producing result
 * ---------------------------------------------------------------------------------------
 */

- (id)first;
- (NSArray *)all;
- (void)each:(CoreDataRecordBlock)recordBlock;

- (NSFetchedResultsController *)fetchedResultsController;


- (NSUInteger)count;
- (id)min:(NSString *)attributeName;
- (id)max:(NSString *)attributeName;
- (id)sum:(NSString *)attributeName;

@end


@interface NSManagedObject (CoreDataActive)

+ (instancetype)create;
+ (void)clear:(NSPredicate *)predicate;

- (instancetype)insert:(NSDictionary *)data;
- (instancetype)delete;
- (instancetype)save;

+ (CoreDataQueryable *)query;

@end
